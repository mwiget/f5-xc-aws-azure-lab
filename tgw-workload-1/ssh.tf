resource "aws_key_pair" "workload_ssh_key" {
  key_name   = format("%s-workload-ssh-key-1", var.projectPrefix)
  public_key = var.ssh_key
}
