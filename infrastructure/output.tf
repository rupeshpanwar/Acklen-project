output "vpc_id" {
  value = aws_vpc.production-vpc.id
}

//output "public_subnet_id" {
//  value = aws_subnet.public-subnets[count.index]
//}