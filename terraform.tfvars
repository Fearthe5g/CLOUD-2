virginia_cidr = "10.10.0.0/16"


#public_subnet = "10.10.0.0/24"
#private_subnet = "10.10.1.0/24"

subnets = ["10.10.0.0/24", "10.10.1.0/24"]

tags = {
  "env"         = "dev"
  "owner"       = "Andresuki"
  "cloud"       = "AWS"
  "IAC"         = "Terraform"
  "IAC_Version" = "1.11.2."
  "project"     = "kerberos"
  "region"      = "virginia"
}

sg_ingress_cidr = "0.0.0.0/0"

ec2_specs = {
  "ami"           = "ami-08b5b3a93ed654d19"
  "instance_type" = "t2.micro"
}

enable_monitoring = true

ingress_ports_list = [22,80.443]
