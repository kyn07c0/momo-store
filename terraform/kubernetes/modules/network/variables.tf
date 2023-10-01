variable "zone" {
  type = string
  nullable = false
  description = "Instance zone"
  default = "ru-central1-a"
}

variable "v4_cidr_blocks" {
  type = string
  description = "v4_cidr_blocks"
  default = "10.1.0.0/16"
}
