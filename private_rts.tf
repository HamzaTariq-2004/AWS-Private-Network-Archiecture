resource "aws_route_table" "private-rt-A" {
    vpc_id = aws_vpc.VPC-A.id

    route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.nat-gw-A.id
    }

    route {
      cidr_block = aws_vpc.VPC-B.cidr_block #VPC-B's CIDR (Destination)
      vpc_peering_connection_id = aws_vpc_peering_connection.peer.id  #Peering connection or connect target
    }

    tags = {
      Name = "Private-RT-A"
    }
}

resource "aws_route_table_association" "private-assoc-A" {
    subnet_id = aws_subnet.subnet-A.id
    route_table_id = aws_route_table.private-rt-A.id
}

resource "aws_route_table" "private-rt-B" {
    vpc_id = aws_vpc.VPC-B.id

    route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.nat-gw-B.id
    }

    route {
      cidr_block = aws_vpc.VPC-A.cidr_block #VPC-A's CIDR (Destination)
      vpc_peering_connection_id = aws_vpc_peering_connection.peer.id  #Peering connection or connect target
    }

    tags = {
      Name = "Private-RT-B"
    }
}

resource "aws_route_table_association" "private-assoc-B" {
    subnet_id = aws_subnet.subnet-B.id
    route_table_id = aws_route_table.private-rt-B.id
}