data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

module "dev_vpc" {
  source = "../modules/aws/vpc"

  vpc_enable_dns_hostnames = var.dev_vpc_enable_dns_hostnames
  vpc_cidr_block = var.dev_vpc_cidr_block
  vpc_name = var.dev_name_vpc
  vpc_igw_tags = var.dev_common_tag
  vpc_nat_gw_tags = var.dev_common_tag
  vpc_subnet_tags = var.dev_common_tag
  vpc_tags = var.dev_common_tag
  vpc_subnets_public = {
    one = {
      cidr_block              = "10.0.81.0/24",
      availability_zone       = "us-east-1a"
      map_public_ip_on_launch = true
    },
    two = {
      cidr_block              = "10.0.82.0/24",
      availability_zone       = "us-east-1b"
      map_public_ip_on_launch = true
    }
  }
  vpc_subnets_private = {
    one = {
      cidr_block              = "10.0.83.0/24",
      availability_zone       = "us-east-1a"
      map_public_ip_on_launch = false
    },
    two = {
      cidr_block              = "10.0.84.0/24",
      availability_zone       = "us-east-1b"
      map_public_ip_on_launch =  false
    }
  }
}

module "dev_ec2_bastion" {
  source = "../modules/aws/ec2"

  vpc_id = module.dev_vpc.vpc_id
  ec2_ami = var.dev_ami_id
  ec2_key_name = var.dev_key_name
  ec2_instance_type = var.dev_instance_type
  ec2_subnets_id = [module.dev_vpc.subnets_public[0]]

  sg_ingress_cidr = {
    one = {
      port = 22,
      protocol = "TCP",
      cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
    }
  }
  sg_name = var.dev_sg_name_bastion
  ec2_name = var.dev_ec2_name_bastion
  ec2_tags = var.dev_common_tag

  depends_on = [module.dev_vpc.subnets_public]
}

module "dev_ec2_apps" {
  source = "../modules/aws/ec2"

  vpc_id = module.dev_vpc.vpc_id
  ec2_ami = var.dev_ami_id
  ec2_key_name = var.dev_key_name
  ec2_subnets_id = module.dev_vpc.subnets_private
  ec2_instance_type = var.dev_instance_type

  sg_ingress_sg = {
    one = {
      sg_id = module.dev_ec2_bastion.sg_id,
      port = 22,
      protocol = "TCP"
    },
    two = {
      sg_id = module.dev_ec2_bastion.sg_id
      port = 80,
      protocol = "TCP"
    }
  }
  sg_name = var.dev_sg_name_app
  ec2_name = var.dev_ec2_name_app
  ec2_tags = var.dev_common_tag
  ec2_user_data = file("./scripts/apache.sh")

  depends_on = [module.dev_vpc.subnets_private]
}

module "dev_alb" {
  source = "../modules/aws/alb"

  ec2_instances_id = module.dev_ec2_apps.ec2_instances_id
  lb_listener_port = 80
  lb_listener_protocol = "HTTP"
  lb_name = var.dev_lb_name
  lb_subnets = module.dev_vpc.subnets_public
  lb_tg_name = var.dev_tg_name
  lb_tg_port = 80
  lb_tg_protocol = "HTTP"
  lb_tga_port = 80
  sg_name = var.dev_sg_name_lb
  lb_tags = var.dev_common_tag
  lb_tg_tags = var.dev_common_tag
  vpc_id = module.dev_vpc.vpc_id
  sg_ingress = {
    one = {
      cidr_blocks = ["0.0.0.0/0"],
      port = 80,
      protocol = "TCP"
    },
    two = {
      cidr_blocks = ["0.0.0.0/0"],
      port = 443,
      protocol = "TCP"
    }
  }
}
