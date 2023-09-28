resource "null_resource" "download_asmcli" {

  provisioner "local-exec" {
    command = "curl https://storage.googleapis.com/csm-artifacts/asm/asmcli_1.18 > asmcli"
  }
}

resource "null_resource" "permissions" {

  provisioner "local-exec" {
    command = "chmod +x asmcli"
  }
}

resource "null_resource" "install" {

  provisioner "local-exec" {
    command = "./asmcli validate --fleet_id svc-gcp-d349 --project_id svc-gcp-d349 --cluster_name svc-demo --output_dir /tmp --cluster_location us-east4"
  }
}
