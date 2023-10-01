variable "token" {
  description = "Token"
  type = string
}

variable "zone" {
  description = "Instance zone"
  type = string
}

variable "cloud_id" {
  description = "Yandex cloud identifier"
  type = string
}

variable "folder_id" {
  description = "Folder identifier"
  type = string
}

variable "service_account_name" {
  description = "Service account name"
  type = string
}

variable "bucket" {
  description = "Bucket for storing the state of terraforms and application resources"
  type = string
}
