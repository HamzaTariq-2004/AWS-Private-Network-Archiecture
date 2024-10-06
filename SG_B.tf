resource "aws_security_group" "vpcB-SG" {
  vpc_id = aws_vpc.VPC-B.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${aws_instance.bastion-B.private_ip}/32", aws_vpc.VPC-A.cidr_block]
  }

  ingress {
    from_port = 8
    to_port = -1
    protocol = "icmp"
    cidr_blocks = [aws_vpc.VPC-A.cidr_block]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"] #Allow all outbound requests
  }

  depends_on = [aws_instance.bastion-B, aws_nat_gateway.nat-gw-B]

}