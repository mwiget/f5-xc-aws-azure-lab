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
  paths = ["../tgw-site-1","../tgw-workload-1"]
}

dependency "workloads" {
  config_path = "../tgw-workload-1"
}

inputs = {
    workload_ip = dependency.workloads.outputs.workload_private_ip
}
