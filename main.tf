provider "aws" {
  region     = var.region
  access_key = var.access-key
  secret_key = var.secret-key
}


module "vpc" {
  source        = "./modules/vpc"
  my_ip_address = var.my_ip_address
}

module "ec2" {
  source         = "./modules/ec2"
  sg-public      = module.vpc.sg-public
  subnet-public  = module.vpc.subnet-public
  subnet-private = module.vpc.subnet-private
  igw            = module.vpc.igw
}
