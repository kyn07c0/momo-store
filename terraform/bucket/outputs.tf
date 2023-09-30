output "bucket_name" {
  value = yandex_storage_bucket.terraform-object-storage[0].bucket
  sensitive = true
}

output "access_key" {
  value = yandex_storage_bucket.terraform-object-storage[0].access_key
  sensitive = true
}

output "secret_key" {
  value = yandex_storage_bucket.terraform-object-storage[0].secret_key
  sensitive = true
}
