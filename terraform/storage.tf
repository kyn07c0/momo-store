resource "yandex_iam_service_account" "sa-bucket" {
  name = "sa-bucket"
}

resource "yandex_resourcemanager_folder_iam_binding" "storage-admin" {
  folder_id = var.folder_id
  role = "storage.admin"
  members = [ "serviceAccount:${yandex_iam_service_account.sa-bucket.id}" ]
}

resource "yandex_iam_service_account_static_access_key" "static-key" {
  service_account_id = yandex_iam_service_account.sa-bucket.id
}

resource "yandex_storage_bucket" "momo-store" {
  access_key = yandex_iam_service_account_static_access_key.static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.static-key.secret_key
  bucket = "kyn07c0-momo-store"
  anonymous_access_flags {
    read = true
    list = false
  }
}

#resource "yandex_storage_bucket" "terraform" {
#  access_key = yandex_iam_service_account_static_access_key.static-key.access_key
#  secret_key = yandex_iam_service_account_static_access_key.static-key.secret_key
#  bucket = "kyn07c0-terraform"
#}

resource "yandex_storage_object" "image" {
  count = 14
  bucket = yandex_storage_bucket.momo-store.bucket
  key    = "${count.index + 1}.jpg"
  source = "images/${count.index + 1}.jpg"
}
