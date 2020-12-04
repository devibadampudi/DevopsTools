resource "random_id" "random_id" {
  byte_length = 2
}
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "tl_vpc_${random_id.random_id.hex}"
  }
}