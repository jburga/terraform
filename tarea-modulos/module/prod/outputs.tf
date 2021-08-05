output "prod_vpc_id" {
  value = module.prod_vpc.this_vpc_id
}

output "prod_id_subnets" {
  value = module.prod_vpc.this_sub_pub
}
