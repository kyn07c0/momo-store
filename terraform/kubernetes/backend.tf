terraform {
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket = "kyn07c0-bucket"
    region = "ru-central1"
    key = "terraform/terraform.tfstate"
    access_key = "YCAJEfjNgoAiUjfrv6Xg7iFFu"
    secret_key = "YCOFq_EqgsAo10yGdRxvZUwqFmuMkbhRDkTQE2z9"
    skip_region_validation = true
    skip_credentials_validation = true
  }
}
