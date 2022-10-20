module "acm" {
  source           = "terraform-google-modules/kubernetes-engine/google//modules/acm"
  version          = "18.0"
  project_id       = var.project_id
  cluster_name     = var.cluster2_name
  location         = module.cluster2.location
  cluster_endpoint = module.cluster2.endpoint

  sync_repo   = var.sync_repo
  sync_branch = var.sync_branch
  policy_dir  = var.policy_dir
}