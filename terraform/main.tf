module "service_account" {
  source = "./modules/service_account"
}







/*
module "dns" {
  source = "./modules/dns"
  network_id = module.network.network_id
  external_ipv4_address = module.network.external_ipv4_address
}

module "network" {
  source = "./modules/network"
}

resource "yandex_vpc_security_group" "momo-main-sg" {
  description = "Группа безопасности для сервиса управления кластером Kubernetes"
  name = "momo-main-sg"
  network_id = module.network.network_id
}

resource "yandex_vpc_security_group_rule" "loadbalancer" {
  description            = "Правило разрешает проверку доступности из диапазона адресов балансировщика нагрузки"
  direction              = "ingress"
  security_group_binding = yandex_vpc_security_group.momo-main-sg.id
  protocol               = "TCP"
  predefined_target      = "loadbalancer_healthchecks"
  from_port              = 0
  to_port                = 65535
}

resource "yandex_vpc_security_group_rule" "node-interaction" {
  description            = "Правило разрешает взаимодействие мастер-узла и узла внутри группы безопасности"
  direction              = "ingress"
  security_group_binding = yandex_vpc_security_group.momo-main-sg.id
  protocol               = "ANY"
  predefined_target      = "self_security_group"
  from_port              = 0
  to_port                = 65535
}

resource "yandex_vpc_security_group_rule" "pod-service-interaction" {
  description            = "Правило разрешает взаимодействие под-под и сервис-сервис"
  direction              = "ingress"
  security_group_binding = yandex_vpc_security_group.momo-main-sg.id
  protocol               = "ANY"
  v4_cidr_blocks         = [var.v4_cidr_blocks]
  from_port              = 0
  to_port                = 65535
}

resource "yandex_vpc_security_group_rule" "ICMP-debug" {
  description            = "Правило разрешает прием отладочных ICMP-пакетов из внутренних подсетей"
  direction              = "ingress"
  security_group_binding = yandex_vpc_security_group.momo-main-sg.id
  protocol               = "ICMP"
  v4_cidr_blocks         = [var.v4_cidr_blocks]
}

resource "yandex_vpc_security_group_rule" "port-6443" {
  description            = "Правило разрешает подключение к Kubernetes API по порту 6443 из интернета"
  direction              = "ingress"
  security_group_binding = yandex_vpc_security_group.momo-main-sg.id
  protocol               = "TCP"
  v4_cidr_blocks         = ["0.0.0.0/0"]
  port                   = 6443
}

resource "yandex_vpc_security_group_rule" "port-443" {
  description            = "Правило разрешает подключение к Kubernetes API по порту 443 из интернета"
  direction              = "ingress"
  security_group_binding = yandex_vpc_security_group.momo-main-sg.id
  protocol               = "TCP"
  v4_cidr_blocks         = ["0.0.0.0/0"]
  port                   = 443
}

resource "yandex_vpc_security_group_rule" "outgoing-traffic" {
  description            = "Правило разрешает весь входящий трафик"
  direction              = "egress"
  security_group_binding = yandex_vpc_security_group.momo-main-sg.id
  protocol               = "ANY"
  v4_cidr_blocks         = ["0.0.0.0/0"]
  from_port              = 0
  to_port                = 65535
}

resource "yandex_vpc_security_group_rule" "SSH" {
  description            = "Правило разрешает подключение к репозиторию Git по ssh из интернета"
  direction              = "ingress"
  security_group_binding = yandex_vpc_security_group.momo-main-sg.id
  protocol               = "TCP"
  v4_cidr_blocks         = ["0.0.0.0/0"]
  port                   = 22
}

resource "yandex_vpc_security_group_rule" "HTTP" {
  description            = "Правило разрешает весь HTTP-трафик"
  direction              = "ingress"
  security_group_binding = yandex_vpc_security_group.momo-main-sg.id
  protocol               = "TCP"
  v4_cidr_blocks         = ["0.0.0.0/0"]
  port                   = 80
}

resource "yandex_vpc_security_group_rule" "NodePort-access" {
  description            = "Правило разрешает входящий трафик в диапазоне портов NodePort"
  direction              = "ingress"
  security_group_binding = yandex_vpc_security_group.momo-main-sg.id
  protocol               = "TCP"
  v4_cidr_blocks         = ["0.0.0.0/0"]
  from_port              = 30000
  to_port                = 32767
}

resource "yandex_vpc_security_group_rule" "port-10502" {
  direction              = "ingress"
  security_group_binding = yandex_vpc_security_group.momo-main-sg.id
  predefined_target      = "self_security_group"
  protocol               = "TCP"
  port                   = 10502
}

resource "yandex_vpc_security_group_rule" "port-10501" {
  direction              = "ingress"
  security_group_binding = yandex_vpc_security_group.momo-main-sg.id
  predefined_target      = "self_security_group"
  protocol               = "TCP"
  port                   = 10501
}

resource "yandex_kubernetes_cluster" "momo-cluster" {
  name = var.cluster_name
  network_id = module.network.network_id

  master {
    version = var.ver
    zonal {
      zone = module.network.subnet-a_zone
      subnet_id = module.network.subnet-a_id
    }

    public_ip = true

    security_group_ids = [yandex_vpc_security_group.momo-main-sg.id]
  }
  service_account_id = yandex_iam_service_account.sa.id
  node_service_account_id = yandex_iam_service_account.sa.id
  depends_on = [
    yandex_resourcemanager_folder_iam_binding.editor,
    yandex_resourcemanager_folder_iam_binding.images-puller
  ]
}

resource "yandex_kubernetes_node_group" "momo-node-group" {
  description = "Группа узлов для сервиса управления кластером Kubernetes"
  name = "momo-node-group"
  cluster_id = yandex_kubernetes_cluster.momo-cluster.id
  version = var.ver

  scale_policy {
    fixed_scale {
      size = 1
    }
  }

  allocation_policy {
    location {
      zone = module.network.subnet-a_zone
    }
  }

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat = true
      subnet_ids = [module.network.subnet-a_id]
      security_group_ids = [yandex_vpc_security_group.momo-main-sg.id]
    }

    resources {
      memory = 4 
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 30
    }
  }
}
*/
