terraform {
  backend "remote" {
    organization = "dname"

    workspaces {
      name = "name of workspace"
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