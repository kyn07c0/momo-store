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
}
