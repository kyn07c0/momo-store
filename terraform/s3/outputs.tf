output "service_account_id" {
  value = yandex_iam_service_account.sa.id 
  sensitive = true
}

output "access_key" {
  value = yandex_storage_bucket.terraform-state.access_key
  sensitive = true
}

output "secret_key" {
  value = yandex_storage_bucket.terraform-state.secret_key
  sensitive = true
}
