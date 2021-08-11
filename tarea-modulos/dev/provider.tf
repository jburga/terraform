terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.50.0"
    }
    http = {
      source = "hashicorp/http"
      version = "2.1.0"
    }
  }
}

provider "aws" {
  region  = var.dev_region
  profile = var.dev_profile
}

provider "http" {
}
