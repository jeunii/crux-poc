resource "google_service_account" "on-prem-k8s-sa" {
  account_id   = "on-prem-k8s-sa"
  display_name = "on-prem-k8s-sa"
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
    }
  }

  network_interface {
    subnetwork = data.tfe_outputs.network-on-prem.values.on_prem_subnets_id[0]
    network_ip = data.tfe_outputs.network-on-prem.values.k8s_master_internal_ip

    access_config {
      nat_ip = data.tfe_outputs.network-on-prem.values.k8s_master_external_ip
    }
  }

  # Metadata for initializing the Kubernetes master
  metadata = {
    startup-script = <<-EOF
      #!/bin/bash
      # Install Docker
      apt-get update
      apt-get install -y docker.io

      # Install Kubernetes components
      curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
      echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list
      apt-get update
      apt-get install -y kubelet kubeadm kubectl

      # Initialize Kubernetes master
      kubeadm init --pod-network-cidr=192.168.4.0/22 --apiserver-advertise-address=${data.tfe_outputs.network-on-prem.values.k8s_master_external_ip}

      # # Copy kubeconfig to a location accessible by other nodes
      # mkdir -p /kube-config
      # cp /etc/kubernetes/admin.conf /kube-config
    EOF
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
    }
  }

  metadata = {
    startup-script = <<-EOF
      #!/bin/bash
      # Install Docker
      apt-get update
      apt-get install -y docker.io

      # Install Kubernetes components
      curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
      echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list
      apt-get update
      apt-get install -y kubelet kubeadm kubectl

      # Join the worker nodes to the Kubernetes master
      <Run kubeadm join command provided by the master here>
    EOF
  }
  service_account {
    email  = google_service_account.on-prem-k8s-sa.email
    scopes = ["cloud-platform"]
  }
}
