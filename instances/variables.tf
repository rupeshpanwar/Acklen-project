variable "region" {
  default = "us-east-1"
  description = "AWS region"
}

variable "remote_state_bucket" {
  description = "Bucket Name for layer 1 remote state"
}

variable "remote_state_key" {
  description = "Key name for layer 1 remote state"
}

variable "ec2_instance_type" {
  description = "instance type of EC2"
}

variable "key_pair_name" {
  default = "connective"
}

variable "max_instance_size" {
  description = "maximum number of EC2 instances"
}

variable "min_instance_size" {
  description = "minimum number of EC2 instances"
}