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
