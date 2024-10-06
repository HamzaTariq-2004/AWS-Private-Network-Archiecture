resource "aws_eip" "eip-B" {
    tags = {
      Name = "EIP-B"
    }
}

resource "aws_nat_gateway" "nat-gw-B" { 
    subnet_id = aws_subnet.public-subnet-B.id
    allocation_id = aws_eip.eip-B.id
}

