variable "lb_listener_type" {
  description = "Load Balancer Listener Type"
  type = string
  default = "forward"
}

variable "ec2_instances_id" {
  description = "EC2 Instances Id"
  type = set(string)
}

variable "lb_tga_port" {
  description = "Load Balancer Target Group Attachment"
  type = number
}

variable "lb_enable_http2" {
  description = "Load Balancer Enable Http2"
  type = bool
  default = true
}

variable "lb_internal" {
  description = "Load Balancer Internal"
  type = bool
  default = false
}

variable "lb_type" {
  description = "Load Balancer Type"
  type = string
  default = "application"
}

variable "lb_subnets" {
  description = "Load Balancer Subnets"
  type = list(string)
}

variable "lb_enable_deletion_protection" {
  description = "Load Balancer Deletion Protection"
  type = bool
  default = false
}

variable "lb_name" {
  description = "Load Balancer Name"
  type = string
}

variable "lb_tg_name" {
  description = "Load Balancer Target Group Name"
  type = string
}

variable "lb_tags" {
  description = "Load Balancer Tags"
  type = map(string)
}

variable "lb_tg_tags" {
  description = "Load Balancer Target Group Tags"
  type = map(string)
}

variable "sg_tags" {
  description = "Security Group Tags"
  type = map(string)
  default = {}
}

variable "lb_listener_port" {
  description = "Load Balancer Listener Port"
  type = number
}

variable "lb_listener_protocol" {
  description = "Load Balancer Listener Protocol"
  type = string
}

variable "lb_tg_port" {
  description = "Load Balancer Target Group Port"
  type = number
}

variable "lb_tg_protocol" {
  description = "Load Balancer Target Group Protocol"
  type = string
}

variable "vpc_id" {
  description = "VPC Id"
  type = string
}


variable "sg_name" {
  description = "Security Group Name"
  type = string
}

variable "sg_ingress" {
  description = "Security Group Ingress List"
  type = map(object({
    cidr_blocks: list(string)
    port: number,
    protocol: string
  }))
  default = {}
}
