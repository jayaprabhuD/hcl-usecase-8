terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "bayer-terraform-remote-state-bucket"
    key    = "usecase-8/terraform.tfstate"
    region = "ap-south-1" 
    dynamodb_table = "bayer-terraform-remote-lock"    
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}
