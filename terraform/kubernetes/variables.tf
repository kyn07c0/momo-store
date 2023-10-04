variable "service_account_id" {
  type = string
  description =  "Service account ID"
}

variable "token" {
  type = string
  description =  "Token"
  sensitive = "true"
}

variable "cluster_name" {
  type = string
  nullable = false
  description = "Claster name"
  default = "k8s-cluster"
}

variable "ver" {
  type = string
  nullable = false
  description = "Version"
  default = "1.24"
}

variable "cloud_id" {
  type = string
  description =  "Cloud ID"
}

variable "folder_id" {
  type = string
  description =  "Folder ID"
}

variable "zone" {
  type = string
  nullable = false
  description = "Instance zone"
  default = "ru-central1-a"
}

variable "image_id" {
  type = string
  description = "Image ID"
  default = "fd8evlqsgg4e81rbdkn7"
}

variable "v4_cidr_blocks" {
  type = string
  description = "v4_cidr_blocks"
  default = "10.1.0.0/16"
}

variable "endpoint" {
  type = string
  description = "Endpoint"
  default = "storage.yandexcloud.net"
}

variable "bucket" {
  type = string
  description = "bucket name"
}

variable "region" {
  type = string
  description = "region"
  default = "ru-central1"
}

variable "key" {
  type = string
  description = "key"
  default = "terraform/terraform.tfstate"
}

variable "access_key" {
  type = string
  description = "access_key"
  default = "YCAJEmGWjyFZ2gGUbwH7Lc6dc"
}

variable "secret_key" {
  type = string
  description = "secret_key"
  default = "YCPBUsmOjG0y8OnntC1cFtYVejJPwPcgCcpoC7tA"
}

variable "skip_region_validation" {
  type = bool
  description = "Skip region validation"
  default = true
}

variable "skip_credentials_validation" {
  type = bool
  description = "Skip credentials validation"
  default = true
}




variable "zone_id" {
  type = string
  description = "Zone ID"
  default = ""
}

variable "certificate_id" {
  type = string
  description = "Certificate ID"
  default = ""
}


variable "k8s_node_vars" {
  description = "Конфигурация групп узлов"
  type        = list(map(string))
  default     = [
    {
      type        = "staging",
      ram         = "4",
      cpu         = "2",
      platform_id = "standard-v1",
      size = "30"
    },
    {
      type        = "production",
      ram         = "4",
      cpu         = "2",
      platform_id = "standard-v1",
      size = "30"
    },
    {
      type        = "infra",
      ram         = "4",
      cpu         = "2",
      platform_id = "standard-v1",
      size = "30"
    }
  ]
}
