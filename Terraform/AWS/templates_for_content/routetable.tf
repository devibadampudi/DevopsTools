resource "aws_route_table" "rt" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "tl_rt_${random_id.random_id.hex}"
  }
}
resource "aws_route_table_association" "sub-associate" {
  subnet_id      = "${aws_subnet.subnet.id}"
  route_table_id = "${aws_route_table.rt.id}"
}