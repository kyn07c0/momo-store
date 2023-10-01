resource "yandex_resourcemanager_folder_iam_binding" "editor" {
  folder_id = var.folder_id
  role = "editor"
  members = ["serviceAccount:${var.service_account_id}"]
}

resource "yandex_resourcemanager_folder_iam_binding" "vpc-admin" {
  folder_id = var.folder_id
  role = "vpc.publicAdmin"
  members = ["serviceAccount:${var.service_account_id}"]
}

resource "yandex_resourcemanager_folder_iam_binding" "cert-downloader" {
  folder_id = var.folder_id
  role = "certificate-manager.certificates.downloader"
  members = ["serviceAccount:${var.service_account_id}"]
}

resource "yandex_resourcemanager_folder_iam_binding" "compute-viewer" {
  folder_id = var.folder_id
  role = "compute.viewer"
  members = ["serviceAccount:${var.service_account_id}"]
}

resource "yandex_resourcemanager_folder_iam_binding" "alb-editor" {
  folder_id = var.folder_id
  role = "alb.editor"
  members = ["serviceAccount:${var.service_account_id}"]
}

resource "yandex_resourcemanager_folder_iam_binding" "images-puller" {
  folder_id = var.folder_id
  role = "container-registry.images.puller"
  members = ["serviceAccount:${var.service_account_id}"]
}

resource "yandex_resourcemanager_folder_iam_binding" "images-pusher" {
  folder_id = var.folder_id
  role = "container-registry.images.pusher"
  members = ["serviceAccount:${var.service_account_id}"]
}

resource "yandex_resourcemanager_folder_iam_binding" "storage-uploader" {
  folder_id = var.folder_id
  role = "storage.uploader"
  members = ["serviceAccount:${var.service_account_id}"]
}

resource "yandex_resourcemanager_folder_iam_binding" "storage-viewer" {
  folder_id = var.folder_id
  role = "storage.viewer"
  members = ["serviceAccount:${var.service_account_id}"]
}

