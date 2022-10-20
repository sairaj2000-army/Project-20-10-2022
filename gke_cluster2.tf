module "cluster2" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "19.0.0"

  project_id = var.project_id
  name       = var.cluster2_name

  region = var.region2_name

  network           = module.network.network_name
  subnetwork        = var.subnet2_name
  ip_range_pods     = var.pod_subnet2_name
  ip_range_services = var.pod_svc_subnet2_name


  remove_default_node_pool = true


  cluster_resource_labels = {
    mesh_id = local.mesh_id
  }

  identity_namespace = local.workload_pool

  node_pools = [
    {
      name         = "general-pool"
      machine_type = "e2-standard-4"
      min_count    = var.minnode
      max_count    = var.maxnode
      disk_size_gb = var.disksize
      disk_type    = "pd-standard"
      preemptible  = false
    },
  ]
  
  depends_on = [module.network]
}
