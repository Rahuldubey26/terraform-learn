terraform {
  backend "remote" {
    organization = "name"

    workspaces {
      name = "=name"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}