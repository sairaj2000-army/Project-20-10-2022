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