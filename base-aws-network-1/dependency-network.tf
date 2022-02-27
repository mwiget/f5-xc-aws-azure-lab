data "template_file" "tgw_network_tfvars" {
  template = file("../base-aws-network-2/terraform.tfvars.json.example")
  vars = {
    vpcPeerId   = aws_vpc.f5-xc-services.id
    vpcPeerCidr = var.spokeVpcCidrBlock
    vpcPeerRt   = aws_route_table.f5-xc-services-vpc-external-rt.id
  }
}

resource "local_file" "tgw_network_tfvars" {
  content  = data.template_file.tgw_network_tfvars.rendered
  filename = "../base-aws-network-2/terraform.tfvars.json"
}
