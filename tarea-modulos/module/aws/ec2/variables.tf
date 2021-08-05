
variable "ec2_ami" {
  type    = string
  default = "default"
}

variable "bastion_type_instance" {
  type    = string
  default = "t2.micro"
}

variable "type_instance" {
  type    = string
  default = "t2.micro"
}

variable "sub_pub_ids" {
  type    = list(string)
  default = []
}

variable "sub_pri_ids" {
  type    = list(string)
  default = []
}

variable "key_name" {
  type    = string
  default = "default"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "ec2_name_default" {
  type    = string
  default = "default"
}

variable "vpc_id" {
    type = string
    default = "default"
}
