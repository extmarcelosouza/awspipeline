terraform {
  required_version = ">=1.0.0"

  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "3.73.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = #"digite sua acess key"
  secret_key = #"digite sua secret key"

  default_tags {
    tags = {
      owner = "Marcelo"
      managed-by = "terraform"
    }
  }
}