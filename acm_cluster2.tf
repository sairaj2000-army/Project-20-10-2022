

#acm installation 
resource "google_gke_hub_feature_membership" "feature_member_cluster2" {
  provider   = google-beta
  location   = "global"
  feature    = "configmanagement"
  membership = google_gke_hub_membership.cluster2_membership.membership_id
  configmanagement {
    version = "1.13.0"
    config_sync {
      source_format = "unstructured"
      git {
        sync_repo   = var.sync_repo
        sync_branch = var.sync_branch
        policy_dir  = var.policy_dir
        secret_type = "none"
      }
    }
    policy_controller {
      enabled                    = true
      template_library_installed = true
      referential_rules_enabled  = true
    }
  }
  depends_on = [google_gke_hub_membership.cluster2_membership, null_resource.istio_ins2, null_resource.script_for_istio2, null_resource.getting_Cred2, null_resource.apply_menifest2]
}
  
  
