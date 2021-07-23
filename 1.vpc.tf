resource "aws_vpc" "ac-xl-vpc-jburga" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "ac-xl-vpc-jburga",
    env = "ac-xl-terr-lab-1"
  }
}
