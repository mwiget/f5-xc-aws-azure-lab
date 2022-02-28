output jumphost_private_ip {
  value = aws_instance.f5-jumphost-1.private_ip
}
output jumphost_public_ip {
  value = aws_instance.f5-jumphost-1.public_ip
}
output workload_private_ip {
  value = aws_instance.f5-workload-1.private_ip
}
output workload_public_ip {
  value = aws_instance.f5-workload-1.public_ip
}
