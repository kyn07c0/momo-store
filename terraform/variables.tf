variable "cloud_id" {
  description = "Yandex Cloud cloud ID"
  type = string
  default = "b1g9rramuashv1f7ie3a"
}

variable "folder_id" {
  description = "Yandex Cloud folder ID"
  type = string
  default = "b1g0j845i7calp33d0tc"
}

variable "zone_name" {
  description = "Yandex Cloud zone name"
  type = string
  default = "ru-central1-a"
}

variable "token" {
  description = "OAuth token"
  sensitive = true
  default = "y0_AgAAAABhEo23AATuwQAAAADtKAyLe1s-MJqDT9WasZ0-Fk5W4HhQzUA"
}

variable "access_key" {
  description = "Access key to Storage service"
  sensitive = true
  default = "YCAJEfjNgoAiUjfrv6Xg7iFFu"
}

variable "secret_key" {
  description = "Secret key to Storage service"
  sensitive = true
  default = "YCOFq_EqgsAo10yGdRxvZUwqFmuMkbhRDkTQE2z9"
}

variable "domain" {
  description = "DNS domain"
  sensitive = true
  default = "kyn07c0.ru"
}

