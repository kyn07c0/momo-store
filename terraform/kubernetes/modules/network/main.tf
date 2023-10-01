resource "yandex_vpc_network" "momo-network" {
  description = "Network for the Managed Service for Kubernetes cluster"
  name = "momo-network"
}

resource "yandex_vpc_subnet" "subnet-a" {
  description = "Subnet in ru-central1-a availability zone"
  name = "subnet-a"
  zone = var.zone
  network_id = yandex_vpc_network.momo-network.id
  v4_cidr_blocks = [var.v4_cidr_blocks]
}

resource "yandex_vpc_address" "addr" {
  name = "static-ip"
  external_ipv4_address {
    zone_id = "ru-central1-a"
  }
}

