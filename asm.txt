

module "asm" {
  source           = "terraform-google-modules/kubernetes-engine/google//modules/asm"
  version          = "19.0.0"
  project_id       = data.google_client_config.current.project
  cluster_name     = module.gke.name
  location         = module.gke.location
  cluster_endpoint = module.gke.endpoint
  enable_all       = true
  outdir           = "./asm-dir-${module.gke.name}"
  asm_version      = var.asm_version
}
