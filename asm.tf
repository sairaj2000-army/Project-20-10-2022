
module "asm-cluster1" {
  source           = "terraform-google-modules/kubernetes-engine/google//modules/asm"
  version          = "19.0.0"
  project_id       = var.project_id
  cluster_name     = module.cluster1.name
  location         = module.cluster1.location
  cluster_endpoint = module.cluster1.endpoint
  enable_all       = true
  outdir           = "./asm1-dir-${module.cluster1.name}"
  asm_version      = var.asm_version
}

module "asm-cluster2" {
  source           = "terraform-google-modules/kubernetes-engine/google//modules/asm"
  version          = "19.0.0"
  project_id       = var.project_id
  cluster_name     = module.cluster2.name
  location         = module.cluster2.location
  cluster_endpoint = module.cluster2.endpoint
  enable_all       = true
  outdir           = "./asm1-dir-${module.cluster2.name}"
  asm_version      = var.asm_version
}


