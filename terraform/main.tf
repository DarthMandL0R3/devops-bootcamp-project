terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.25.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.6.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.1.0"
    }
  }
}

provider "aws" {
  region  = "ap-southeast-1"
  profile = "default"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "devops-bootcamp-terraform-abrar"
  acl    = "private"
  versioning = {
    enabled = true
  }
}