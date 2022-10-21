#register this cluster as a member of the fleet
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


#install ASM with managed control plane
locals {
  cluster_hub_mesh_update_command = "gcloud alpha container hub mesh update --control-plane automatic --membership "${var.project_id}-${var.cluster_name}" --project=${var.project_id}"
}
resource "null_resource" "cluster1_hub_mesh_update" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = local.cluster_hub_mesh_update_command
  }
  triggers = {
    command_sha = sha1(local.cluster1_hub_mesh_update_command)
  }
  depends_on = [google_gke_hub_membership.gke_membership]
}





resource "null_resource" "script_for_istio" {

 provisioner "local-exec" {
    
    command = "/bin/bash script.sh"
  }
  depends_on = [google_gke_hub_membership.gke_membership] 
}
