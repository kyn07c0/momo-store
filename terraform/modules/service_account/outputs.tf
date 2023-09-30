output "access_key" {
  value = yandex_storage_bucket.terraform-object-storage.access_key
  sensitive = true
}

output "bucket_name" {
  value = yandex_storage_bucket.terraform-object-storage.bucket
  sensitive = true
}

output "secret_key" {
  value = yandex_storage_bucket.terraform-object-storage.secret_key
  sensitive = true
}
