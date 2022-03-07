variable "projectPrefix" {}
variable "namespace" {}
variable "workload_ip1" {}
variable "workload_ip2" {}
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
