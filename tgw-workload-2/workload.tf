resource "aws_instance" "f5-workload-2" {
  ami                         = data.aws_ami.ubuntu_amd64.id
  instance_type               = "t2.micro"
  subnet_id                   = var.spokeExternalSubnets["az1"].id
  vpc_security_group_ids      = [var.spokeSecurityGroup]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.workload_ssh_key.id
  user_data                   = <<-EOF
#!/bin/bash
sleep 30
snap install docker
systemctl enable snap.docker.dockerd
systemctl start snap.docker.dockerd
sleep 30
docker run -d  --net=host --restart=always \
-e F5DEMO_APP=website \
-e F5DEMO_NODENAME='Private Endpoint' \
-e F5DEMO_COLOR=ffd734 \
-e F5DEMO_NODENAME_SSL='AWS Environment (Backend App)' \
-e F5DEMO_COLOR_SSL=a0bf37 \
-e F5DEMO_BRAND=volterra \
-e F5DEMO_PONG_URL=http://backend.example.local:8080/pong/extended \
public.ecr.aws/y9n2y5q5/f5-demo-httpd:openshift
EOF

  tags = {
    Name = "${var.projectPrefix}-f5-xc-workload-2"
  }
}

