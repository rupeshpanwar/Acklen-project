variable "vpc_cidr" {
  description = "production vpc cidr"
}

variable "public_subnet_cidr" {
  type = list(string)
}

variable "availability_zone" {
  type = list(string)
}

variable "public_subnet_names" {
  type = list(string)
}