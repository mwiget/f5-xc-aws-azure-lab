resource "volterra_virtual_network" "global-network" {
  name        = var.globalNetwork
  namespace = "system"
  global_network = true
}
