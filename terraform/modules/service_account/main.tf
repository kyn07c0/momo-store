resource "yandex_iam_service_account" "sa" {
  name = var.service_account
}

resource "yandex_resourcemanager_folder_iam_binding" "editor" {
  folder_id = var.folder_id
  role = "editor"
  members = ["serviceAccount:${yandex_iam_service_account.sa.id}"]
}

resource "yandex_resourcemanager_folder_iam_binding" "vpc-admin" {
  folder_id = var.folder_id
  role = "vpc.publicAdmin"
  members = ["serviceAccount:${yandex_iam_service_account.sa.id}"]
}

resource "yandex_resourcemanager_folder_iam_binding" "cert-downloader" {
  folder_id = var.folder_id
  role = "certificate-manager.certificates.downloader"
  members = ["serviceAccount:${yandex_iam_service_account.sa.id}"]
}

resource "yandex_resourcemanager_folder_iam_binding" "compute-viewer" {
  folder_id = var.folder_id
  role = "compute.viewer"
  members = ["serviceAccount:${yandex_iam_service_account.sa.id}"]
}

resource "yandex_resourcemanager_folder_iam_binding" "alb-editor" {
  folder_id = var.folder_id
  role = "alb.editor"
  members = ["serviceAccount:${yandex_iam_service_account.sa.id}"]
}

resource "yandex_resourcemanager_folder_iam_binding" "images-puller" {
  folder_id = var.folder_id
  role = "container-registry.images.puller"
  members = ["serviceAccount:${yandex_iam_service_account.sa.id}"]
}

resource "yandex_resourcemanager_folder_iam_binding" "images-pusher" {
  folder_id = var.folder_id
  role = "container-registry.images.pusher"
  members = ["serviceAccount:${yandex_iam_service_account.sa.id}"]
}

resource "yandex_resourcemanager_folder_iam_binding" "storage-uploader" {
  folder_id = var.folder_id
  role = "storage.uploader"
  members = ["serviceAccount:${yandex_iam_service_account.sa.id}"]
}

resource "yandex_resourcemanager_folder_iam_binding" "storage-viewer" {
  folder_id = var.folder_id
  role = "storage.viewer"
  members = ["serviceAccount:${yandex_iam_service_account.sa.id}"]
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

resource "yandex_storage_bucket" "terraform-object-storage" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = "momo-store-backet"
}

#output "bucket" {
#  value = {
#    "access_key": yandex_storage_bucket.terraform-object-storage.access_key
#    "secret_key": yandex_storage_bucket.terraform-object-storage.secret_key
#    "bucket": yandex_storage_bucket.terraform-object-storage.bucket
#  }
#  sensitive = true
#}

