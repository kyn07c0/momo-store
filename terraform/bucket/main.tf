resource "yandex_iam_service_account" "sa" {
  name = var.service_account_name
}

resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.folder_id
  role = "storage.editor"
  member = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

resource "yandex_iam_service_account_static_access_key" "static-key" {
  count = length(var.buckets)
  service_account_id = yandex_iam_service_account.sa.id
}

resource "yandex_storage_bucket" "terraform-object-storage" {
  count = length(var.buckets)
  bucket = var.buckets[count.index]
  access_key = yandex_iam_service_account_static_access_key.static-key[count.index].access_key
  secret_key = yandex_iam_service_account_static_access_key.static-key[count.index].secret_key
}
