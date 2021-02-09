output "vpc_id" {
  value = aws_vpc.production-vpc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.production-vpc.cidr_block
}
output "public_subnet_1_id" {
  value = aws_subnet.public-subnets[0].id
}
output "public_subnet_2_id" {
  value = aws_subnet.public-subnets[1].id
}

