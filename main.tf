provider "google" {
  project = var.project_id
}
provider "google-beta" {
  project = var.project_id
}

provider "kubernetes" {
  #config_context_auth_info = "ops2"
  config_context_cluster = var.cluster1_name
  alias                  = "mycluster1"
  host                   = "https://${module.cluster1.endpoint}"
  token                  = data.google_client_config.current.access_token
  cluster_ca_certificate = base64decode(module.cluster1.ca_certificate)
  version                = "2.0"
}

provider "kubernetes" {
  #config_context_auth_info = "ops1"
  config_context_cluster = var.cluster2_name
  alias                  = "mycluster2"
  host                   = "https://${module.cluster2.endpoint}"
  token                  = data.google_client_config.current.access_token
  cluster_ca_certificate = base64decode(module.cluster2.ca_certificate)
  version                = "2.0"
}

data "google_client_config" "current" {}

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

output "cluster1_name" {
  description = "Cluster1 name"
  value       = module.cluster1.name
}

output "cluster2_name" {
  description = "Cluster2 name"
  value       = module.cluster2.name
}
