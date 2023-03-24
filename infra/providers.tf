terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.6.0"
    }
  }
  backend "s3" {
    bucket         = "ecs-ec2-python-api-statefile"
    key            = "terraform.tfstate"
    dynamodb_table = "ecs-ec2-python-api-statelock-db"
    region         = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}
