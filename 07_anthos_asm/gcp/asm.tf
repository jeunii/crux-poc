resource "null_resource" "download_gcloud" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = <<EOT
      curl -LO "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-448.0.0-linux-x86_64.tar.gz"
      tar -zxvf google-cloud-sdk-448.0.0-linux-x86_64.tar.gz
      ./google-cloud-sdk/install.sh
      source /home/tfc-agent/.tfc-agent/component/terraform/runs/run-NG6oqRG9YHEtRhYn/config/07_anthos_asm/gcp/google-cloud-sdk/completion.bash.inc
      source /home/tfc-agent/.tfc-agent/component/terraform/runs/run-NG6oqRG9YHEtRhYn/config/07_anthos_asm/gcp/google-cloud-sdk/path.bash.inc
      gcloud --version
    EOT
  }
}


resource "null_resource" "download_asmcli" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = <<EOT
      curl https://storage.googleapis.com/csm-artifacts/asm/asmcli_1.18 > asmcli
      chmod +x asmcli
      ./asmcli validate --fleet_id svc-gcp-d349 --project_id svc-gcp-d349 --cluster_name svc-demo --output_dir /tmp --cluster_location us-east4
    EOT
  }
  depends_on = [
    null_resource.download_gcloud
  ]
}
