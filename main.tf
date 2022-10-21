provider "google" {
  project = var.project_id
  region  = var.region_name
}

provider "google-beta" {
  project = var.project_id
  region  = var.region_name
}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.current.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

data "google_client_config" "current" {}

output "cluster_name" {
  description = "Cluster name"
  value       = module.gke.name
}
  
#Enable the hub mesh in the fleet project
locals {
  hub_mesh_enable_command = "gcloud beta container hub mesh enable --project=${var.project_id}"
}
resource "null_resource" "exec_gke1_mesh" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = local.hub_mesh_enable_command
  }
  triggers = {
    command_sha = sha1(local.hub_mesh_enable_command)
  }
}
