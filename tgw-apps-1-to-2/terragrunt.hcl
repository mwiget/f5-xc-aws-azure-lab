include "root" {
  path = find_in_parent_folders()
}

terraform {
    extra_arguments "volterra" {
        commands = ["apply","plan","destroy"]
        arguments = []
        env_vars = {
            VOLT_API_TIMEOUT  = "60s"
        }
    }

}


dependencies {
  paths = ["../tgw-site","../tgw-workload","../tgw-site2","../tgw-workload2","../tgw-apps"]
}

dependency "workloads" {
  config_path = "../tgw-workload"
}

dependency "workloads2" {
  config_path = "../tgw-workload2"
}

inputs = {
    workload_ip = dependency.workloads.outputs.workload_ip
    workload_ip2 = dependency.workloads2.outputs.workload_ip    
}