terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "terraform-bucket"
    key    = "vpn/terraform.tfstate"
    region = "eu-north-1"
  }
}

provider "aws" {
  region = "eu-north-1"

  default_tags {
    tags = {
      Application = "Database with AWS Client VPN"
      Author      = "Elia Cakerri"
    }
  }
}
