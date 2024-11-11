variable "aws_region" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "team_members_ips_cidrs" {
  type        = list(string)
  description = "Check your IP at www.myip.com/, add it to that list as CIDR, ex. 188.122.20.71/32"
}

variable "vpc_id" {
  type = string
}

variable "subnets_ids" {
  type = list(string)
}

