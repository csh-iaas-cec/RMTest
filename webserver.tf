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
  default = "-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAyILXunpuFCWgZORfiM0DKTzMlb2DqZD22erQI6keyfi81xM+
PpFzP0RAj9A5Hq1iWtGofwPuJTUa4/gxsjK3Tc4CAf59pFTdUCPE7a9i2BFsPWup
xMbGnAaFgjNUNV5mHJPHbtHzevxm56zas9zcGSH6ZjYO67XMnbDTSi41FOAK+bTz
t5xejRGO6Y1cDwf16lIQFYNiyHSSQF3hSlHxmBBZqrdAXaLPw1PKDDJ9BSNCd2M6
vkTOBYJYm9Ad95KAbaI7WBZsCPt+06+ETbmycKlqbfogDWRrCJxQOyMICWLMl6b3
bJX9+AmDhCMAMm9ibBR9RmyyWKEe2G8mcl10DQIDAQABAoIBAC58dztaiw7MsmTx
tVxn+2WiHORSbaXwX+qhz+OUn/i/XDiY04N6ATgXwMgWxEdidz0LAn+AD8Q8jaFw
t0TTEUBOlJSVxddFfZHI2S0pzka9s1SCE3f1hbJCqM1IzSsaWZ4ifMgqkMJgphLs
NkAg4j5JbF4qBkeLfIbKqhG2qMPPy8xCU4A6EfLFbUibkcVaYCse5vnRRy6NllL+
iBaeN/cwWrbbU/0mIkizEQIPqI/8nLK5Y5QR81ZlcATZcM7RAnmH7+T9DPiTXkIA
ZT0h8lAR2WX2VnwuLcUahQcSkbSIH41qWY3GcPFr9mgYNbB5bUkWD0XkYSXQEH1g
Xb+MW8ECgYEA/MySMpPuY9gqeSVKpWltuoVSkS9RO+mppXgTM2SzzqtAZOXFj1W/
ehzStkv4hahOUZMJ48v5tE23THlni/NgFIs6sZQqWGb/npt2fkWSHvPE7wKTJUYr
BhfD/Rq9HN1xET5A388CIxTs+QYgPXsVsN7NEOK78Y3gMjlWrf5VSjkCgYEAywzI
t/9+5qR4BGDOC9ozqjNPUs+MAZqK0UaCF+x0ATQtowhOAiqYKjvlburXsZ1gXqft
iUQVzQzdxrZzZJ8bhOD7cjqWwVmHTVfAqzmaQhMLv6kBeaP/xbtt+SCbasyd7LlN
tm4Hy8sApHA31nwxQrZMxnazojEBUK3F9caWyHUCgYBttfJ01NKOrk+wh8ifhOPE
IPw2WgytLbkcQMJEeZ23QYcOwtE8ZYBV5JBl4Q6YIvTqXh/aprlV0KyOGdogWJ0I
DWyJiL3f48Nn+BwyrMq/eBetiraFZLBjUokSHTqZflkFnLjW6KYKx5gYctonFHXT
br4cZ+oc6O+1nEDL/ibRsQKBgQDHkH0GOpri3OsIgoyAoaj9swhXf50/RkEBhqb+
FGu/cyUXg2YIQwzjFZNd/HqaGu9ImQuhScWTjv25/EBVuPs3EliP4H2i8vdEUOcQ
YsD2B/oYGWdVwpX0JU7k9+NIiGr+6vEyR9pptc+fzptStyVDSCEVPj03P6rnPKO/
97risQKBgFC/bMtoM1Rj0985+//nOUs5hBYBs0sGbsaqWB2lK2342MhFuOUuM8/O
4aMnJK9id8iE/huT858cQTT6u1OqrcM8tp4BhcsAdS9CNQjuu2DDiRfnyC6UVTqk
kCK9fXi4TMV1TAu2t4sSOTytj0hcFkU/0Qxn0/T2eIKebchVm7Hk
-----END RSA PRIVATE KEY-----"
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
  default = "VM.Standard2.1"
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
echo '<html><head></head><body><pre><code>' > /var/www/html/index.html
each '' >> /var/www/html/index.html
echo '<H1><p style="color:red;">' >> /var/www/html/index.html
hostname >> /var/www/html/index.html
echo '</p></H1>' >> /var/www/html/index.html
echo '<p>' >> /var/www/html/index.html
echo '<img src="http://bit.ly/2NBa8MA" alt="OOW2018" align="left">' >> /var/www/html/index.html
echo '</code></pre></body></html>' >> /var/www/html/index.html
firewall-offline-cmd --add-service=http
systemctl enable  firewalld
systemctl restart  firewalld
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
    user_data           = "base64encode(var.user-data)"
  }

  timeouts {
    create = "60m"
  }
}

output "Webserver-AD1" {
  value = "${oci_core_instance.Webserver-AD1.public_ip}"
}
