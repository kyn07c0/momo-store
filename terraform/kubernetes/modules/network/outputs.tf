output "network_id" {
  value = yandex_vpc_network.momo-network.id
}

output "subnet-a_zone" {
  value = yandex_vpc_subnet.subnet-a.zone
}

output "subnet-a_id" {
  value = yandex_vpc_subnet.subnet-a.id
}

output "external_ipv4_address" {
  value = yandex_vpc_address.addr.external_ipv4_address[0].address
}
