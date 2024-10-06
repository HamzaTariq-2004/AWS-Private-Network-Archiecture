resource "aws_security_group" "vpcA-SG" {
    vpc_id = aws_vpc.VPC-A.id
  
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${aws_instance.bastion-A.private_ip}/32", aws_vpc.VPC-B.cidr_block]
    }

    ingress {
        from_port = 8 #Echo request from ICMP
        to_port = -1 #All ICMP responses (required to get ping reply)
        protocol = "icmp"
        cidr_blocks = [aws_vpc.VPC-B.cidr_block]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"] #Allow all outbound requests through NAT gateway
    }

    depends_on = [aws_instance.bastion-A, aws_nat_gateway.nat-gw-A]
} 