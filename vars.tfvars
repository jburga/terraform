vpc_main = "vpc-0b543be57021fc072"
region_lab = "us-east-1"
profile-lab = "camilo-gbl-traning"
cirdr_sub_1 = "10.0.2.0/24"
ingress-ac-xl-sg-tmp = [ 
    {
    description = "zzzzzzz"
    cidr_blocks = ["179.33.114.5/32"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
    self = false
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    },
    {
      description = "zzzzzzz"
      cidr_blocks = ["0.0.0.0/0"]
      from_port = 80
      to_port = 80
      protocol = "tcp"
      self = false
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
    },
    {
      description = "zzzzzzz"
      cidr_blocks = ["0.0.0.0/0"]
      from_port = 443
      to_port = 443
      protocol = "tcp"
      self = false
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
    }
]
ami-id-ec2-aws = "ami-0dc2d3e4c0f9ebd18"
key-name-ssh = "camilo-rojas-lab"