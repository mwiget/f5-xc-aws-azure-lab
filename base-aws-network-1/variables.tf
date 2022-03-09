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

variable "trusted_ip" {
    type        = string
      description = "IP to allow external access"
}

variable "domain_name" {
  type        = string
  description = "The DNS domain name that will be used as common parent generated DNS name of loadbalancers."
  default     = "shared.example.internal"
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
variable "volterraTenant" {
  description = "Tenant of Volterra"
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

variable "servicesVpcCidrBlock" {
  default = "10.64.0.0/20"
}
variable "servicesVpc" {
  description = "Services VPC"
  type        = map(any)
  default = {
    "azs" = {
      "az1" = { az = "us-west-2a" },
      "az2" = { az = "us-west-2b" },
      "az3" = { az = "us-west-2c" },
    },
    "external" = {
      "az1" = {
        cidr = "10.64.0.0/24"
      },
      "az2" = {
        cidr = "10.64.3.0/24"
      },
      "az3" = {
        cidr = "10.64.6.0/24"
      }
    },
    "internal" = {
      "az1" = {
        cidr = "10.64.1.0/24"
      },
      "az2" = {
        cidr = "10.64.4.0/24"
      },
      "az3" = {
        cidr = "10.64.7.0/24"
      }
    },
    "workload" = {
      "az1" = {
        cidr = "10.64.2.0/24"
      },
      "az2" = {
        cidr = "10.64.5.0/24"
      },
      "az3" = {
        cidr = "10.64.8.0/24"
      }
    }

  }
}
variable "spokeVpcCidrBlock" {
  default = "10.0.0.0/20"
}
variable "spokeVpc" {
  description = "Spoke VPC"
  type        = map(any)
  default = {
    "azs" = {
      "az1" = { az = "us-west-2a" },
      "az2" = { az = "us-west-2b" },
      "az3" = { az = "us-west-2c" },
    },
    "external" = {
      "az1" = {
        cidr = "10.0.0.0/24"
      },
      "az2" = {
        cidr = "10.0.3.0/24"
      },
      "az3" = {
        cidr = "10.0.6.0/24"
      }
    },
    "internal" = {
      "az1" = {
        cidr = "10.0.1.0/24"
      },
      "az2" = {
        cidr = "10.0.4.0/24"
      },
      "az3" = {
        cidr = "10.0.7.0/24"
      }
    },
    "workload" = {
      "az1" = {
        cidr = "10.0.2.0/24"
      },
      "az2" = {
        cidr = "10.0.5.0/24"
      },
      "az3" = {
        cidr = "10.0.8.0/24"
      }
    }

  }
}
