
module "prod_vpc" {
  source = "../modules/aws/vpc"

  vpc_cidr_block           = var.prod_vpc_cidr_block
  vpc_enable_dns_hostnames = var.prod_vpc_enable_dns_hostnames
  vpc_tags                 = var.prod_vpc_tags
  vpc_pub_subnets          = var.prod_vpc_pub_subnets
  vpc_name                 = var.prod_name_vpc
  name_subnet_nat          = var.prod_vpc_pub_subnets[0].name
  vpc_pri_subnets          = var.prod_vpc_pri_subnets
}

module "prod_ec2" {
  source = "../modules/aws/ec2"

  ec2_ami          = var.prod_ami_id
  sub_pub_ids      = module.prod_vpc.this_sub_pub
  key_name         = var.prod_key_name
  tags             = var.prod_vpc_tags
  ec2_name_default = var.prod_ec2_name_default
  sub_pri_ids = module.prod_vpc.this_sub_pri
  vpc_id = module.prod_vpc.this_vpc_id
}
