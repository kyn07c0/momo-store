resource "yandex_dns_zone" "domain" {
  name = replace(var.domain, ".", "-")
  zone = join("", [var.domain, "."])
  public = true
  private_networks = [var.network_id]
}

resource "yandex_dns_recordset" "dns_domain_record" {
  zone_id = yandex_dns_zone.domain.id
  name = join("", [var.domain, "."])
  type = "A"
  ttl = 200
  data = [var.external_ipv4_address]
}

resource "yandex_dns_recordset" "dns_domain_record_momitoring" {
  zone_id = yandex_dns_zone.domain.id
  name = join("", ["monitoring.",var.domain, "."])
  type = "A"
  ttl = 200
  data = [var.external_ipv4_address]
}

resource "yandex_dns_recordset" "dns_domain_record_grafana" {
  zone_id = yandex_dns_zone.domain.id
  name = join("", ["grafana.",var.domain, "."])
  type = "A"
  ttl = 200
  data = [var.external_ipv4_address]
}

resource "yandex_cm_certificate" "le-certificate" {
  name    = "momo-cert"
  domains = ["kyn07c0.ru"]

  managed {
    challenge_type = "DNS_CNAME"
  }
}

resource "yandex_dns_recordset" "validation-record" {
  zone_id = yandex_dns_zone.domain.id
  name = yandex_cm_certificate.le-certificate.challenges[0].dns_name
  type = yandex_cm_certificate.le-certificate.challenges[0].dns_type
  data = [yandex_cm_certificate.le-certificate.challenges[0].dns_value]
  ttl = 200
}

data "yandex_cm_certificate" "example" {
  depends_on = [yandex_dns_recordset.validation-record]
  certificate_id = yandex_cm_certificate.le-certificate.id
  wait_validation = true
}
