resource "aws_vpc_peering_connection" "peer" {
    vpc_id = aws_vpc.VPC-A.id
    peer_vpc_id = aws_vpc.VPC-B.id
    auto_accept = true
}

resource "aws_route" "vpcA_to_vpcB" {
    route_table_id = aws_vpc.VPC-A.main_route_table_id
    destination_cidr_block = aws_vpc.VPC-B.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

resource "aws_route" "vpcB_to_vpcA" {
    route_table_id = aws_vpc.VPC-B.main_route_table_id
    destination_cidr_block = aws_vpc.VPC-A.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}