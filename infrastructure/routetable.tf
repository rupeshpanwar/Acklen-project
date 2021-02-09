resource "aws_route_table" "public-route-table1" {
  vpc_id = aws_vpc.production-vpc.id
  tags = {
    Name = "Public-Route-Table-Subnet-1"
  }
}
resource "aws_route_table_association" "public-subnet-1-associate" {
  route_table_id = aws_route_table.public-route-table1.id
  subnet_id = aws_subnet.public-subnets[0].id
}

resource "aws_route_table" "public-route-table2" {
  vpc_id = aws_vpc.production-vpc.id
  tags = {
    Name = "Public-Route-Table-Subnet-2"
  }
}
resource "aws_route_table_association" "public-subnet-2-associate" {
  route_table_id = aws_route_table.public-route-table2.id
  subnet_id = aws_subnet.public-subnets[1].id
}




