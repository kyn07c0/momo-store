resource "yandex_resourcemanager_folder_iam_binding" "editor" {
  folder_id = var.folder_id
  role = "editor"
  members = ["serviceAccount:${var.service_account_id}"]
}

resource "yandex_resourcemanager_folder_iam_binding" "images-puller" {
  folder_id = var.folder_id
  role = "container-registry.images.puller"
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





resource "yandex_vpc_network" "k8s-network" {
  description = "Network for the Managed Service for Kubernetes cluster"
  name = "k8s-network"
}

resource "yandex_vpc_subnet" "subnet-a" {
  description = "Subnet in ru-central1-a availability zone"
  name = "subnet-a"
  zone = var.zone
  network_id = yandex_vpc_network.k8s-network.id
  v4_cidr_blocks = [var.v4_cidr_blocks]
}




resource "yandex_vpc_security_group" "k8s-main-sg" {
  name        = "k8s-main-sg"
  network_id  = yandex_vpc_network.k8s-network.id
  ingress {
    protocol          = "TCP"
    predefined_target = "loadbalancer_healthchecks"
    from_port         = 0
    to_port           = 65535
  }
  ingress {
    protocol          = "ANY"
    predefined_target = "self_security_group"
    from_port         = 0
    to_port           = 65535
  }
  ingress {
    protocol       = "ANY"
    v4_cidr_blocks = ["10.96.0.0/16", "10.112.0.0/16"]
    from_port      = 0
    to_port        = 65535
  }
  ingress {
    protocol       = "ICMP"
    v4_cidr_blocks = ["172.16.0.0/12", "10.0.0.0/8", "192.168.0.0/16"]
  }
  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}



resource "yandex_vpc_security_group" "k8s-public-services" {
  name        = "k8s-public-services"
  network_id  = yandex_vpc_network.k8s-network.id

  ingress {
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 30000
    to_port        = 32767
  }
}

resource "yandex_vpc_security_group" "k8s-nodes-ssh-access" {
  name        = "k8s-nodes-ssh-access"
  network_id  = yandex_vpc_network.k8s-network.id

  ingress {
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }
}

resource "yandex_vpc_security_group" "k8s-master-whitelist" {
  name        = "k8s-master-whitelist"
  network_id  = yandex_vpc_network.k8s-network.id

  ingress {
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 6443
  }

  ingress {
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  ingress {
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }
}




resource "yandex_kubernetes_cluster" "k8s-cluster" {
  name = "k8s-cluster"
  network_id = yandex_vpc_network.k8s-network.id

  master {
    version = var.ver
    zonal {
      zone = yandex_vpc_subnet.subnet-a.zone
      subnet_id = yandex_vpc_subnet.subnet-a.id
    }

    security_group_ids = [
      yandex_vpc_security_group.k8s-main-sg.id,
      yandex_vpc_security_group.k8s-master-whitelist.id
    ]

    public_ip = true 
  }
  service_account_id = var.service_account_id
  node_service_account_id = var.service_account_id
  depends_on = [
    yandex_resourcemanager_folder_iam_binding.editor,
    yandex_resourcemanager_folder_iam_binding.images-puller
  ]
}

resource "yandex_kubernetes_node_group" "k8s-node-group" {
  name = "k8s-node-group"
  cluster_id = yandex_kubernetes_cluster.k8s-cluster.id
  version = var.ver

  scale_policy {
    fixed_scale {
      size = 1
    }
  }

  allocation_policy {
    location {
      zone = yandex_vpc_subnet.subnet-a.zone
    }
  }

  instance_template {
    platform_id = "standard-v3"

    network_interface {
      nat = true
      subnet_ids = [yandex_vpc_subnet.subnet-a.id]
      security_group_ids = [
        yandex_vpc_security_group.k8s-main-sg.id,
        yandex_vpc_security_group.k8s-nodes-ssh-access.id,
        yandex_vpc_security_group.k8s-public-services.id
      ]
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





resource "yandex_vpc_address" "addr" {
  name = "static-ip"
  external_ipv4_address {
    zone_id = "ru-central1-a"
  }
}

resource "yandex_dns_zone" "zone" {
  name = "public-zone"
  zone = "kyn07c0.ru."
  public = true
}

resource "yandex_dns_recordset" "rs1" {
  zone_id = yandex_dns_zone.zone.id
  name    = "kyn07c0.ru."
  type    = "A"
  ttl     = 200
  data    = [yandex_vpc_address.addr.external_ipv4_address[0].address]
}
