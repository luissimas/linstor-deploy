# Add description for each variable
variable "instance_name" {
  type    = string
  default = ""
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "cpu_count" {
  type    = string
  default = "1"
}

variable "memory_count" {
  type    = string
  default = "1GiB"
}

variable "image" {
  type    = string
  default = "images:ubuntu/22.04"
}

variable "network_ipv4_cidr" {
  type = string
}

variable "network_ipv6_cidr" {
  type = string
}

variable "volume_size" {
  type    = string
  default = "5GiB"
}
