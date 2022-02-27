variable "buildSuffix" {
  type        = string
  default     = null
  description = "random build suffix for resources"
}
variable "projectPrefix" {
  type        = string
  description = "projectPrefix name for tagging"
}

variable "namespace" {
  description = "Volterra application namespace"
  type        = string
}


variable "volterraCloudCredAWS" {
  description = "Name of the volterra aws credentials"
  type        = string
}

variable "volterraCloudCredAzure" {
  description = "Name of the volterra aws credentials"
  type        = string
}

variable "awsRegion" {
  description = "aws region"
  type        = string
}

variable "awsAz1" {
  description = "Availability zone, will dynamically choose one if left empty"
  type        = string
  default     = null
}
variable "awsAz2" {
  description = "Availability zone, will dynamically choose one if left empty"
  type        = string
  default     = null
}
variable "awsAz3" {
  description = "Availability zone, will dynamically choose one if left empty"
  type        = string
  default     = null
}

variable "volterraP12" {
  description = "Location of volterra p12 file"
  type        = string
  default     = null
}
variable "volterraUrl" {
  description = "url of volterra api"
  type        = string
  default     = null
}
variable "volterraCaCert" {}
variable "volterraTenant" {
  description = "Tenant of Volterra"
  type        = string
}
variable "vpcId" {}
variable "externalSubnets" {}
variable "internalSubnets" {}
variable "workloadSubnets" {}
variable "securityGroup" {}
variable "spokeVpcId" {}
variable "spokeExternalSubnets" {}
variable "spokeWorkloadSubnets" {}
variable "spokeSecurityGroup" {}
variable "ssh_key" {}
variable "globalNetwork" {}
