variable awsRegion {
    type = string
}
variable projectPrefix {
    type = string
}
variable ssh_key {
    type = string
}
variable security1Group {
    type = string
}
variable spoke1SecurityGroup {
    type = string
}
variable external1Subnets {
    type = map
}
variable spoke1WorkloadSubnets {
    type = map
}

variable security2Group {
    type = string
}
variable spoke2SecurityGroup {
    type = string
}
variable external2Subnets {
    type = map
}
variable spoke2WorkloadSubnets {
    type = map
}
