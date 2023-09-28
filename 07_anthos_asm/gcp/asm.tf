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
