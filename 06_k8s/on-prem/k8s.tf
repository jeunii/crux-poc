resource "google_service_account" "on-prem-k8s-sa" {
  account_id   = "on-prem-k8s-sa"
  display_name = "OnPrem-k8s-SA"
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
    network_ip = "192.168.0.5"
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
      # Let's run them manually once cluster get's created
      # kubeadm init --pod-network-cidr=192.168.8.0/22 --apiserver-advertise-address=192.168.0.5

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