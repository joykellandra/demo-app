provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.54.0"
    }
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"
  cluster_name    = "demo"
  cluster_version = "1.24"
  subnets = [
    "subnet-0d278a9fbc829a970", 
    "subnet-014847ee82d628f15", 
    "subnet-01f0c731b381ee125",  
  ]

  vpc_id = "vpc-0b9cfa0f96883af20"
  tags = {
    Terraform = "true"
  }
}

module "fargate_profile" {
  source = "terraform-module/eks-fargate-profile/aws"
  cluster_name = "demo"
  subnets = module.eks.private_subnets
  tags = {
    Terraform = "true"
  }
}
