resource "aws_subnet" "subnet" {
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "tl_subnet_${random_id.random_id.hex}"
  }
}