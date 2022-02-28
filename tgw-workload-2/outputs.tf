output jumphost_private_ip {
  value = aws_instance.f5-jumphost-2.private_ip
}
output jumphost_public_ip {
  value = aws_instance.f5-jumphost-2.public_ip
}
output workload_private_ip {
  value = aws_instance.f5-workload-2.private_ip
}
output workload_public_ip {
  value = aws_instance.f5-workload-2.public_ip
}
