resource "aws_instance" "instance" {
  ami                         = "ami-0d1cd67c26f5fca19"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["${aws_security_group.sg_list.id}"]
  associate_public_ip_address = true
  subnet_id                   = "${aws_subnet.subnet.id}"
  key_name                    = "${aws_key_pair.key_pair.key_name}"
  tags = {
    Name = "tl_instance_${random_id.random_id.hex}"
  }
}
resource "aws_key_pair" "key_pair" {
  key_name   = "tl_labs_key_${random_id.random_id.hex}"
  public_key = "${var.ssh-pub-key}"
}