
resource "google_gke_hub_membership" "cluster1_membership" {
  membership_id = "${var.gcp_project_id}-cluster1"
  endpoint {
    gke_cluster {
      resource_link = "//container.googleapis.com/${module.cluster1.cluster_id}"
    }
  }
  authority {
    issuer = "https://container.googleapis.com/v1/${module.cluster1.cluster_id}"
  }
  provider = google-beta
  depends_on = [module.cluster1]
}

resource "google_gke_hub_feature_membership" "feature_member-cluster1" {
  provider   = google-beta
  location   = "global"
  feature    = "configmanagement"
  membership = google_gke_hub_membership.cluster1_membership.membership_id
      
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
