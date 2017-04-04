variable "region" {
  description = "The region to deploy the instance"
  default     = "eu-west-1"
}

variable "awsprofile" {
  description = "The local AWS-CLI profile to be used for AWS api credentials"
}

variable "instance_size" {}

variable "instance_name" {}

variable "key_name" {}

variable "ssh_user" {
  description = "ssh username to ec2 instance"
  default     = "ubuntu"
}

variable "ssh_key_path" {
  description = "local path to private key for ssh-ing to ec2 instance"
}

# Subnet Availability zones
variable "subnetaz1" {
  type = "map"
}

variable "subnetaz2" {
  type = "map"
}

variable "subnetaz3" {
  type = "map"
}

variable "web_security_group_name" {}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default     = "10.0.0.0/16"
}
