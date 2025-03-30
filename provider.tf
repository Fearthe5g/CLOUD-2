terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws" # ✅ Corrección
      version = "5.93.0"
    }
    random = {
      source  = "hashicorp/random" # ✅ Si usas `random_string`, necesitas este proveedor
      version = "~> 3.0"
    }
  }
}


provider "aws"{
region = "us-east-1"
access_key = var.access_key
secret_key = var.secret_key
default_tags {
  tags = var.tags
}
}



