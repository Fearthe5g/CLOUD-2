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


