module "acm" {
  source           = "terraform-google-modules/kubernetes-engine/google//modules/acm"
  version          = "18.0"
  project_id       = var.project_id
  cluster_name     = var.cluster_name
  location         = module.gke.location
  cluster_endpoint = module.gke.endpoint

  sync_repo   = var.sync_repo
  sync_branch = var.sync_branch
  policy_dir  = var.policy_dir
}