terraform {
  backend "s3" {
  endpoint = "storage.yandexcloud.net"
  bucket = "kyn07c0-terraform"
  region = "ru-central1"
  key = "kyn07c0-terraform/terraform.tfstate"
  access_key = ""
  secret_key = "" 
  skip_region_validation = true
  skip_credentials_validation = true
  }
}
