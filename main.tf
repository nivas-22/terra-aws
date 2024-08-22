terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "t1"

  instance_type          = "t2.micro"
  key_name               = "aws"
  monitoring             = true
  vpc_security_group_ids = ["sg-03946aa60e5ded4b0"]
  subnet_id              = "subnet-0bf75427a7b9569dd"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
