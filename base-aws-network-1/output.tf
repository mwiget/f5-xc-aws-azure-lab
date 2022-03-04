output "f5-xc-services-vpc" {
  value = aws_vpc.f5-xc-services.id
}
output "f5-xc-spoke-vpc" {
  value = aws_vpc.f5-xc-spoke.id
}
output "f5-xc-igw" {
  value = aws_internet_gateway.f5-xc-spoke-vpc-gw.id
}
output "allowed_ingress_ip" {
  value = chomp(data.http.f5-xc-http-myip.body)
}

output projectPrefix {
  value = var.projectPrefix
}
output awsRegion {
  value = var.awsRegion
}
output awsAz1 {
  value = var.servicesVpc.azs["az1"]["az"]
}
output awsAz2 {
  value = var.servicesVpc.azs["az2"]["az"]
}
output awsAz3 {
  value = var.servicesVpc.azs["az3"]["az"]
}
output externalSubnets {
  value = aws_subnet.f5-xc-services-external
}
output internalSubnets {
  value = aws_subnet.f5-xc-services-internal
}
output workloadSubnets {
  value = aws_subnet.f5-xc-services-workload
}
output spokeExternalSubnets {
  value   = aws_subnet.f5-xc-spoke-external
}
output spokeWorkloadSubnets {
  value = aws_subnet.f5-xc-spoke-workload
}
output securityGroup {
  value   = aws_security_group.f5-xc-vpc.id
}
output vpcId {
  value = aws_vpc.f5-xc-services.id
}
output spokeVpcId{
  value = aws_vpc.f5-xc-spoke.id
}
output spokeSecurityGroup {
  value = aws_security_group.f5-xc-spoke-vpc.id
}
