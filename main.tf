terraform {
  cloud {
    organization = "StephenCoatsworth"
    workspaces {
      name = "example_workspace"
    }
  }


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"

}

provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0648ea225c13e0729"
  instance_type = "t2.micro"
  tags = {
    Name = var.instance_name
  }
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = "this-is-not-a-kfc-bucket"


  tags = {
    Name = "Stephen_Bucket"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.test_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.test_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}