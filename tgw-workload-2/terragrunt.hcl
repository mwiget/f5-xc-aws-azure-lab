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

#    before_hook "pre-check" {
#        commands = ["apply","plan","destroy"]
#        execute  = ["./pre-check.sh"]
#    }

}


dependencies {
  paths = ["../base-aws-network-2","../tgw-site-1"]
}

dependency "infrastructure" {
  config_path = "../base-aws-network-2"
}

inputs = {
    spokeExternalSubnets = dependency.infrastructure.outputs.spokeExternalSubnets
    spokeWorkloadSubnets = dependency.infrastructure.outputs.spokeWorkloadSubnets
    spokeSecurityGroup   = dependency.infrastructure.outputs.spokeSecurityGroup
}
