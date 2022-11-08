terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0822295a729d2a28e"
  instance_type = "t1.micro"

  tags = {
    Name = "ExampleAppServerInstance"
    Name = var.instance_name
  }
}
