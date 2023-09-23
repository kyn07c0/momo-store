terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.87.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.11.0"
    }
  }

  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket = "momo-store-bucket"
    region = "ru-central1"
    key = "terraform.tfstate"
    access_key = "YCAJEmGWjyFZ2gGUbwH7Lc6dc"
    secret_key = "YCPBUsmOjG0y8OnntC1cFtYVejJPwPcgCcpoC7tA"
    skip_region_validation = true
    skip_credentials_validation = true
  }
}
