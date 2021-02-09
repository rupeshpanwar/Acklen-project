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