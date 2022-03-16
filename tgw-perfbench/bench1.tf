# create bench1 instance

# network interfaces
resource "aws_network_interface" "f5_bench1_mgmt" {
  subnet_id   = var.external1Subnets["az1"].id
  private_ips = ["10.64.0.101"]
  security_groups = [var.security1Group]
}

resource "aws_network_interface" "f5_bench1_spoke" {
  subnet_id   = var.spoke1WorkloadSubnets["az1"].id
  private_ips = ["10.0.2.101"]
  security_groups = [var.spoke1SecurityGroup]
}

resource "aws_eip" "f5_bench1_eip" {
   vpc                       = true
  network_interface         = aws_network_interface.f5_bench1_mgmt.id
  associate_with_private_ip = "10.64.0.101"
}

resource "aws_instance" "f5_bench1" {

  instance_type = "c5n.xlarge" # 4 cores, 10GB RAM
  ami           = data.aws_ami.ubuntu_amd64.id
  key_name      = var.ssh_key

  tags = {
    Name = "${var.projectPrefix}-f5-xc-bench-1"
  }

  network_interface {
    network_interface_id = aws_network_interface.f5_bench1_mgmt.id
    device_index         = 0
  }
  network_interface {
    network_interface_id = aws_network_interface.f5_bench1_spoke.id
    device_index         = 1
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  user_data =<<EOT
#cloud-config
hostname: bench1
package_update: true
package_upgrade: false
package_reboot_if_required: false

groups:
- docker

packages:
  - ca-certificates
  - curl
  - gnupg-agent
  - software-properties-common
  - iperf3
  - net-tools
  - tcpdump
  - bwm-ng
  - inetutils-traceroute

runcmd:
  - ip route add 10.0.0.0/20 via 10.0.2.1
  - sed -i 's/localhost/localhost bench1/' /etc/hosts

final_message: "The system is finally up, after $UPTIME seconds"
EOT

}
