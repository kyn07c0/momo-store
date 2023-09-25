variable "service_account" {
  type = string
  description =  "Service account name"
  default = "sa"
}

variable "iam_token" {
  type = string
  description =  "IAM token"
  sensitive = "true"
}

variable "cluster_name" {
  type = string
  nullable = false
  description = "Claster name"
  default = "momo-cluster"
}

variable "namespace" {
  type = string
  nullable = false
  description = "Name"
  default = "momo"
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
  default = "b1g9rramuashv1f7ie3a"
}

variable "folder_id" {
  type = string
  description =  "Folder ID"
  default = "b1g0j845i7calp33d0tc"
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

variable "domain" {
  type = string
  description = "Domain name"
  default = "kyn07c0.ru"
}

variable "endpoint" {
  type = string
  description = "Endpoint"
  default = "storage.yandexcloud.net"
}

variable "bucket" {
  type = string
  description = "bucket name"
  default = "kyn07c0-bucket"
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
