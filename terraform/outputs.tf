output "bucket_name" {
  value = module.service_account.bucket_name
  sensitive = true
}

output "access_key" {
  value = module.service_account.access_key
  sensitive = true
}

output "secret_key" {
  value = module.service_account.secret_key
  sensitive = true
}

