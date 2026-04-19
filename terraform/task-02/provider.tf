provider "aws" {
    region= "ap-south"
}
terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = ">=6.33.0"
      }
    }
}