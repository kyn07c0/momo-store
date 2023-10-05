provider "yandex" {
 token     = var.token
 cloud_id  = var.cloud_id
 folder_id = var.folder_id
 zone      = var.zone_name
 storage_access_key = var.access_key
 storage_secret_key = var.secret_key
}
