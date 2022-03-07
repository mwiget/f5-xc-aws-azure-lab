include "root" {
  path = find_in_parent_folders()
}


dependencies {
  paths = ["../tgw-site-1","../tgw-workload-1","../tgw-site-2","../tgw-workload-2","../tgw-apps"]
}

dependency "workloads1" {
  config_path = "../tgw-workload-1"
}

dependency "workloads2" {
  config_path = "../tgw-workload-2"
}

inputs = {
    workload_ip1 = dependency.workloads1.outputs.workload_private_ip
    workload_ip2 = dependency.workloads2.outputs.workload_private_ip
}
