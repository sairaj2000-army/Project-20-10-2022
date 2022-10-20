
module "gke" {
  source     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version    = "19.0.0"
  project_id = var.project_id
  name       = var.cluster_name
  regional   = false
  #region     = var.region
  zones      = ["us-central1-c"]
  
  #network    = var.network_name
  #subnetwork = module.network.subnets_names[0]
  
  network           = module.network.network_name
  subnetwork        = var.subnet_name
  ip_range_pods     = var.pod_subnet_name
  ip_range_services = var.pod_svc_subnet_name
  

  identity_namespace = "enabled"

  cluster_resource_labels = { "mesh_id" : "${var.cluster_name}-${var.project_id}" } #for asm module 5

  node_pools = [
    {
      name           = "node-pool"
      machine_type   = "e2-standard-4"
      node_locations = "us-central1-c"
      min_count      = var.minnode
      max_count      = var.maxnode
      disk_size_gb   = var.disksize
      preemptible    = false
      auto_repair    = true
      auto_upgrade   = true
    },
  ]
}
