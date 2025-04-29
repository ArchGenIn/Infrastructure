terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
    }
  }
}

provider "openstack" {
  application_credential_id = var.auth_data.credential_id
  application_credential_secret = var.auth_data.credential_secret
  auth_url    = var.auth_data.auth_url
  insecure    = true
}

 
resource "openstack_compute_instance_v2" "agi_execute_server" {
  count = 4
  name     = "agi${1 + count.index}"
  flavor_name     = var.agi_execute_server.flavor_name
  key_pair        = "felho"
  security_groups = ["default"]
  user_data       = file("./agi-exec-cloud-init.yaml")
  network {
    name = var.agi_execute_network.name
  }

  block_device {
    uuid                  = var.agi_execute_server.image_id
    source_type           = "image"
    volume_size           = var.agi_execute_server.volume_size
    volume_type           = "SSD_volume"
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }
}

resource "local_file" "agi_exec_inventory" {
  filename = "./agi_exec_inventory"
  content = <<-EOT
[agi_exec]
    %{~ for instance in openstack_compute_instance_v2.agi_execute_server.* ~}
    ${~ instance.name} ansible_host=${instance.access_ip_v4} ansible_user=ubuntu
    %{~ endfor ~}
  EOT
}