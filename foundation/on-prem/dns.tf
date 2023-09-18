resource "google_dns_managed_zone" "psc" {
  project    = module.vpc.project_id
  name       = "psc-zone"
  dns_name   = "cloudfunctions.net."
  visibility = "private"
  private_visibility_config {
    networks {
      network_url = module.vpc.network_self_link
    }
  }
}

resource "google_dns_record_set" "cloud-static-records" {
  project      = module.vpc.project_id
  managed_zone = google_dns_managed_zone.psc.name
  name         = "pscrecord"
  type         = "A"
  ttl          = 300
  rrdatas      = ["10.255.255.1"]
  depends_on = [
    google_dns_managed_zone.psc
  ]
}
