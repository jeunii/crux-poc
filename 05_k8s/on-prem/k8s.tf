resource "google_service_account" "on-prem-k8s-sa" {
  account_id   = "on-prem-k8s-sa"
  display_name = "on-prem-k8s-sa"
  project = data.tfe_outputs.svc-project-on-prem.values.svc_proj_id
}


resource "google_compute_address" "k8s-master-internal-ip" {
  name         = "k8s-master-internal-ip"
  project      = data.tfe_outputs.svc-project-on-prem.values.svc_proj_id
  subnetwork   = data.tfe_outputs.network-on-prem.values.on_prem_subnets_id[0]
  address_type = "INTERNAL"
  region       = var.region
}


resource "google_compute_instance" "k8s_master" {
  name         = "${var.cluster_name}-master"
  machine_type = var.machine_type
  zone         = var.zone 
  can_ip_forward = true
  project = data.tfe_outputs.svc-project-on-prem.values.svc_proj_id
  tags = ["on-prem-master", "on-prem"]

  boot_disk {
    initialize_params {
      size = var.disk_size_gb
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = data.tfe_outputs.network-on-prem.values.on_prem_subnets_id[0]
    network_ip = google_compute_address.k8s-master-internal-ip.address

    access_config {
      nat_ip = data.tfe_outputs.network-on-prem.values.k8s_master_external_ip
    }
  }

  metadata = {
  }
  service_account {
    email  = google_service_account.on-prem-k8s-sa.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "k8s_node" {
  count        = var.node_count
  name         = "${var.cluster_name}-node-${count.index}"
  machine_type = var.machine_type
  zone         = var.zone
  can_ip_forward = true
  project = data.tfe_outputs.svc-project-on-prem.values.svc_proj_id
  tags = ["on-prem-worker", "on-prem"]

  network_interface {
    subnetwork = data.tfe_outputs.network-on-prem.values.on_prem_subnets_id[0]
    access_config {
    }
  }

  boot_disk {
    initialize_params {
      size = var.disk_size_gb
      image = "debian-cloud/debian-11"
    }
  }

  metadata = {
  }
  service_account {
    email  = google_service_account.on-prem-k8s-sa.email
    scopes = ["cloud-platform"]
  }
}
