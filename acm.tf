resource "google_gke_hub_membership" "gke_membership" {
  membership_id = "${var.project_id}-${var.cluster_name}"
  endpoint {
    gke_cluster {
      resource_link = "//container.googleapis.com/${module.gke.cluster_id}"
    }
  }
  authority {
    issuer = "https://container.googleapis.com/v1/${module.gke.cluster_id}"
  }
  provider = google-beta
  depends_on = [module.gke]
}

resource "google_gke_hub_feature_membership" "feature_member_gke" {
  provider   = google-beta
  location   = "global"
  feature    = "configmanagement"
  membership = google_gke_hub_membership.gke_membership.membership_id
      
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

}
