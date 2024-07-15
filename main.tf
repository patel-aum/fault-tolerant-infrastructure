provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "e-commerce-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "e-commerce-cluster"
  cluster_version = "1.21"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  node_groups = {
    eks_nodes = {
      desired_capacity = 3
      max_capacity     = 5
      min_capacity     = 1

      instance_type = "t3.medium"
    }
  }
}

module "rds" {
  source  = "terraform-aws-modules/rds/aws"

  identifier = "e-commerce-db"
  engine     = "postgres"
  engine_version = "13.4"
  instance_class = "db.t3.medium"
  allocated_storage = 20

  name     = "ecommercedb"
  username = "admin"
  password = "YourStrongPasswordHere-khekhe"
  port     = "5432"

  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_ids             = module.vpc.private_subnets

  family = "postgres13"
  major_engine_version = "13"
}