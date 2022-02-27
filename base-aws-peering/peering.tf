resource "aws_vpc_peering_connection" "aws-peering" {
  vpc_id        = var.vpcId
  peer_vpc_id   = var.vpcPeerId
  auto_accept   = true

  tags = {
    Name = "${var.projectPrefix}-f5-xc-peering"
  }
}

resource "aws_route" "to-peer" {
  route_table_id         = var.vpcRt
  destination_cidr_block = var.vpcPeerCidr
  gateway_id             = aws_vpc_peering_connection.aws-peering.id
}

resource "aws_route" "from-peer" {
  route_table_id         = var.vpcPeerRt
  destination_cidr_block = var.vpcCidr
  gateway_id             = aws_vpc_peering_connection.aws-peering.id
}
