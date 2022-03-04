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
  paths = ["../base-aws-network-1","../base-aws-network-2"]
}

dependency "network-1" {
  config_path = "../base-aws-network-1"
}

dependency "network-2" {
  config_path = "../base-aws-network-2"
}

inputs = {
    external1Subnets = dependency.network-1.outputs.externalSubnets
    external2Subnets = dependency.network-2.outputs.externalSubnets
    security1Group   = dependency.network-1.outputs.securityGroup
    security2Group   = dependency.network-2.outputs.securityGroup
    spoke1WorkloadSubnets = dependency.network-1.outputs.spokeWorkloadSubnets
    spoke2WorkloadSubnets = dependency.network-2.outputs.spokeWorkloadSubnets
    spoke1SecurityGroup   = dependency.network-1.outputs.spokeSecurityGroup
    spoke2SecurityGroup   = dependency.network-2.outputs.spokeSecurityGroup
}
