terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = ">= 0.87.0"
    }
  }

  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket = "momo-store-bucket"
    region = "ru-central1"
    key = "terraform/terraform.tfstate"
    #access_key = module.service_account.access_key
    #secret_key = module.service_account.secret_key
    skip_region_validation = true
    skip_credentials_validation = true
  }
}
