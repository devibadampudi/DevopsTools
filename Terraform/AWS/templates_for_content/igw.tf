resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name = "tl_igw_${random_id.random_id.hex}"
  }
}