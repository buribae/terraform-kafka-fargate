provider "aws" {
  region = "us-east-1"
}

module "network" {
  source = "./modules/network"
}

module "ec2" {
  source       = "./modules/ec2"
  prefix       = var.prefix
  vpc_id       = module.network.vpc_id
  subnet_ids   = module.network.subnet_ids
  ingress_cidr = var.ingress_cidr
}

module "fargate" {
  source                   = "./modules/fargate"
  prefix                   = var.prefix
  vpc_id                   = module.network.vpc_id
  subnet_ids               = module.network.subnet_ids
  ingress_cidr             = var.ingress_cidr
  bootstrap_brokers        = module.msk.bootstrap_brokers
  zookeeper_connect_string = module.msk.zookeeper_connect_string
  app_image                = "<aws_account_id>.dkr.ecr.us-east-1.amazonaws.com/kafka-consumer:latest"
}

module "msk" {
  source       = "./modules/msk"
  prefix       = var.prefix
  vpc_id       = module.network.vpc_id
  subnet_ids   = module.network.subnet_ids
  ingress_cidr = var.ingress_cidr
}
