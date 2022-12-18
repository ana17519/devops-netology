variable "yc_id" {
  type    = string
  default = ""
}

variable "yc_folder_id" {
  type    = string
  default = ""
}

variable "yc_token" {
  type    = string
  default = ""
}

variable "yc_zone" {
  type    = string
  default = "ru-central1-a"
}
locals {
#  virtual_machines = {
#    "vm1" = 1
#    "vm2" = 2
#  }
  count = {
    stage = 1
    prod  = 2
  }
  instant_types = {
    stage = "standard-v2"
    prod = "standard-v3"
  }
}