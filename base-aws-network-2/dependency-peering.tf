data "template_file" "tgw_peering_tfvars" {
  template = file("../base-aws-peering/terraform.tfvars.json.example")
  vars = {
    projectPrefix   = var.projectPrefix
    awsRegion       = var.awsRegion
    vpcId           = aws_vpc.f5-xc-services.id
    vpcRt           = aws_route_table.f5-xc-services-vpc-external-rt.id
    vpcCidr         = var.servicesVpcCidrBlock
    vpcPeerId       = var.vpcPeerId
    vpcPeerRt       = var.vpcPeerRt
    vpcPeerCidr     = var.vpcPeerCidr
  }
}

resource "local_file" "tgw_peering_tfvars" {
  content  = data.template_file.tgw_peering_tfvars.rendered
  filename = "../base-aws-peering/terraform.tfvars.json"
}
