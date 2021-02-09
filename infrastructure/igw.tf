#Resource mapping from public subnet to internet
#create internet gateway
resource "aws_internet_gateway" "production-igw" {
  vpc_id = aws_vpc.production-vpc.id

  tags = {
    Name = "Production-IGW"
  }
}

#create route for public subnet
resource "aws_route" "public-internet-gw-route-public-subnet1" {
  route_table_id = aws_route_table.public-route-table1.id
  gateway_id = aws_internet_gateway.production-igw.id
  destination_cidr_block = "0.0.0.0/0"
}
resource "aws_route" "public-internet-gw-route-public-subnet2" {
  route_table_id = aws_route_table.public-route-table2.id
  gateway_id = aws_internet_gateway.production-igw.id
  destination_cidr_block = "0.0.0.0/0"
}
