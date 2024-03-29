variable "tenancy_ocid" {
}

#variable "user_ocid" {
#}

#variable "fingerprint" {
#}

variable "private_key_path" {
}

variable "region" {
default = "us-ashburn-1"  
}

variable "ssh_private_key" {
}

variable "ssh_public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDIgte6em4UJaBk5F+IzQMpPMyVvYOpkPbZ6tAjqR7J+LzXEz4+kXM/RECP0DkerWJa0ah/A+4lNRrj+DGyMrdNzgIB/n2kVN1QI8Ttr2LYEWw9a6nExsacBoWCM1Q1XmYck8du0fN6/GbnrNqz3NwZIfpmNg7rtcydsNNKLjUU4Ar5tPO3nF6NEY7pjVwPB/XqUhAVg2LIdJJAXeFKUfGYEFmqt0Bdos/DU8oMMn0FI0J3Yzq+RM4Fglib0B33koBtojtYFmwI+37Tr4RNubJwqWpt+iANZGsInFA7IwgJYsyXpvdslf34CYOEIwAyb2JsFH1GbLJYoR7YbyZyXXQN kishore@oracle.com"
}

variable "compartment_ocid" {
}

variable "ad" {
type = "list"
  default = ["wCBC:US-ASHBURN-AD-1","wCBC:US-ASHBURN-AD-2","wCBC:US-ASHBURN-AD-3"]
}

provider "oci" {
region = "us-ashburn-1"
}

### Network Variables #####

variable "vcn_cidr_block" {
  default = "10.0.0.0/16"
}

variable "dns_label_vcn" {
  default = "dnsvcn"
}
variable "subnet_cidr_w1" {
  default = "10.0.10.0/24"
}

variable "subnet_cidr_w2" {
  default = "10.0.20.0/24"
}

##### COMPUTE INSTANCE #######

variable "instance_shape" {
  default = "VM.Standard2.2"
}

variable "instance_image_ocid" {
  #type = map(string)
  default = {
    // See https://docs.us-phoenix-1.oraclecloud.com/images/
    // Oracle-provided image "Oracle-Linux-7.5-2018.10.16-0"
    us-phoenix-1   = "ocid1.image.oc1.phx.aaaaaaaaoqj42sokaoh42l76wsyhn3k2beuntrh5maj3gmgmzeyr55zzrwwa"
    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaageeenzyuxgia726xur4ztaoxbxyjlxogdhreu3ngfj2gji3bayda"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaaitzn6tdyjer7jl34h2ujz74jwy5nkbukbh55ekp6oyzwrtfa4zma"
    uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaa32voyikkkzfxyo4xbdmadc2dmvorfxxgdhpnk6dw64fa3l4jh7wa"
  }
}

variable "user-data" {
  default = <<EOF
#!/bin/bash -x
echo '################### webserver userdata begins #####################'
touch ~opc/userdata.`date +%s`.start
# echo '########## yum update all ###############'
# yum update -y
echo '########## basic webserver ##############'
yum install -y httpd
systemctl enable  httpd.service
systemctl start  httpd.service
curl https://objectstorage.us-ashburn-1.oraclecloud.com/p/pm4w2IZ33g_cmD7fXj6uOepiDtbAjFHQwLIagYmj3kw/n/orasenatdhubsred01/b/kishore/o/image.html >> /var/www/html/index.html
firewall-offline-cmd --add-service=http
systemctl enable  firewalld
systemctl restart  firewalld
sudo systemctl disable firewalld
sudo systemctl stop firewalld
touch ~opc/userdata.`date +%s`.finish
echo '################### webserver userdata ends #######################'
EOF

}

resource "oci_core_virtual_network" "vcn_w" {
  cidr_block     = "${var.vcn_cidr_block}"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "vcn_webserver"
  dns_label      = "vcn"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

#### Internet Gateay ###

resource "oci_core_internet_gateway" "igw" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "igw"
  vcn_id         = "${oci_core_virtual_network.vcn_w.id}"
}

#### Route Table #####

resource "oci_core_route_table" "rt1" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.vcn_w.id}"
  display_name   = "rt1"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.igw.id}"
  }
}

##### Security Lists ######

resource "oci_core_security_list" "sl_w" {
  display_name   = "sl-loadbalancer"
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.vcn_w.id}"

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    tcp_options {
      max = 22
      min = 22
    }

    protocol = "6"
    source   = "0.0.0.0/0"
  }
  ingress_security_rules {
    tcp_options {
      max = 80
      min = 80
    }

    protocol = "6"
    source   = "0.0.0.0/0"
  }
  ingress_security_rules {
    tcp_options {
      max = 443
      min = 443
    }

    protocol = "6"
    source   = "0.0.0.0/0"
  }
  ingress_security_rules {
    icmp_options {
      type = 0
    }

    protocol = 1
    source   = "0.0.0.0/0"
  }
  ingress_security_rules {
    icmp_options {
      type = 3
      code = 4
    }

    protocol = 1
    source   = "0.0.0.0/0"
  }
  ingress_security_rules {
    icmp_options {
      type = 8
    }

    protocol = 1
    source   = "0.0.0.0/0"
  }
}

#### Subnet  #######

resource "oci_core_subnet" "subnet1" {
  availability_domain = "${var.ad[0]}"
  cidr_block          = "${var.subnet_cidr_w1}"
  display_name        = "subnet1-AD1"
  security_list_ids   = ["${oci_core_security_list.sl_w.id}"]
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.vcn_w.id}"
  route_table_id      = "${oci_core_route_table.rt1.id}"
  dhcp_options_id     = "${oci_core_virtual_network.vcn_w.default_dhcp_options_id}"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "oci_core_subnet" "subnet2" {
  availability_domain = "${var.ad[0]}"
  cidr_block          = "${var.subnet_cidr_w2}"
  display_name        = "subnet2-AD2"
  security_list_ids   = ["${oci_core_security_list.sl_w.id}"]
  compartment_id      = "${var.compartment_ocid}"
  vcn_id              = "${oci_core_virtual_network.vcn_w.id}"
  route_table_id      = "${oci_core_route_table.rt1.id}"
  dhcp_options_id     = "${oci_core_virtual_network.vcn_w.default_dhcp_options_id}"

  provisioner "local-exec" {
    command = "sleep 5"
  }
}

/* Instances */
resource "oci_core_instance" "Webserver-AD1" {
  availability_domain = "${var.ad[0]}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "Webserver-ASHBURN_AD1"
  shape               = "${var.instance_shape}"

  create_vnic_details {
    subnet_id        = "${oci_core_subnet.subnet1.id}"
    display_name     = "primaryvnic"
    assign_public_ip = "true"
  }

  source_details {
    source_type = "image"
    source_id   = "${var.instance_image_ocid[var.region]}"
  }

  metadata = {
    ssh_authorized_keys = "${var.ssh_public_key}"
    user_data           = "${base64encode(var.user-data)}"
  }

  timeouts {
    create = "60m"
  }
}

output "Webserver-AD1" {
  value = "${oci_core_instance.Webserver-AD1.public_ip}"
}
