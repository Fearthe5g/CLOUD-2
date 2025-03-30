resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virginia_cidr
  # tags = var.tags
  tags = {
    "name" = "vpc_virginia-${local.sufix}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_virginia.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true
  #  tags = var.tags
  tags = {
    "name" = "Public_subnet-${local.sufix}"
  }
}


resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_virginia.id
  cidr_block = var.subnets[1]
  # tags = var.tags
  tags = {
    "name" = "private_subnet-${local.sufix}"
  }
  depends_on = [
    aws_subnet.public_subnet
  ]


}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_virginia.id

  tags = {
    name = "igw vpc virginia-${local.sufix}"
  }
}



resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }


  tags = {
    name = "public crt-${local.sufix}"
  }
}

resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}


resource "aws_security_group" "sg_public_instance" {
  name        = "Public instance SG"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc_virginia.id


 dynamic "ingress"{
  for_each = var.ingress_ports_list
  content {
    from_port = ingress.value
    to_port = ingress.value
    protocol = "tcp"
    cidr_blocks = [var.sg_ingress_cidr]
  }
 }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  tags = {
    name = "Public instance SG-${local.sufix}"
  }
}


