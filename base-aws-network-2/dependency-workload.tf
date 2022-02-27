data "template_file" "tgw_workload_tfvars" {
  template = file("../tgw-workload-2/terraform.tfvars.json.example")
  vars = {
    projectPrefix   = var.projectPrefix
    awsRegion       = var.awsRegion
    awsAz1          = var.servicesVpc.azs["az1"]["az"]
    awsAz2          = var.servicesVpc.azs["az2"]["az"]
    awsAz3          = var.servicesVpc.azs["az3"]["az"]
    externalSubnets = jsonencode(aws_subnet.f5-xc-services-external)
    internalSubnets = jsonencode(aws_subnet.f5-xc-services-internal)
    workloadSubnets = jsonencode(aws_subnet.f5-xc-services-workload)
    spokeExternalSubnets    = jsonencode(aws_subnet.f5-xc-spoke-external)    
    spokeWorkloadSubnets    = jsonencode(aws_subnet.f5-xc-spoke-workload)
    securityGroup  = aws_security_group.f5-xc-vpc.id
    vpcId           = aws_vpc.f5-xc-services.id,
    spokeVpcId      = aws_vpc.f5-xc-spoke.id,
    spokeSecurityGroup = aws_security_group.f5-xc-spoke-vpc.id,
    allowedIngressIp = chomp(data.http.f5-xc-http-myip.body)
  }
}

resource "local_file" "tgw_workload_tfvars" {
  content  = data.template_file.tgw_workload_tfvars.rendered
  filename = "../tgw-workload-2/terraform.tfvars.json"
}
