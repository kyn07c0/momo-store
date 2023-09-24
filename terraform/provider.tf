provider "yandex" {
  token = var.iam_token
  cloud_id = var.cloud_id
  folder_id = var.folder_id
  zone = var.zone
}

provider "helm" {
  kubernetes {
    host = yandex_kubernetes_cluster.momo-cluster.master[0].external_v4_endpoint
    cluster_ca_certificate = yandex_kubernetes_cluster.momo-cluster.master[0].cluster_ca_certificate
    token = var.iam_token
  }
}
