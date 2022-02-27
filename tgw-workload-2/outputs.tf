output workload_private_ip {
  value = aws_instance.f5-workload-2.private_ip
}
output workload_public_ip {
  value = aws_instance.f5-workload-2.public_ip
}
