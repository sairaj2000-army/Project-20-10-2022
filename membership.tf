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
  cluster_hub_mesh_update_command = "gcloud alpha container hub mesh update --control-plane automatic --membership ${var.project_id}-${var.cluster_name} --project=${var.project_id}"
}
resource "null_resource" "cluster1_hub_mesh_update" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = local.cluster_hub_mesh_update_command
  }
  triggers = {
    command_sha = sha1(local.cluster_hub_mesh_update_command)
  }
  depends_on = [google_gke_hub_membership.gke_membership]
}



locals{
   down_asm = "curl https://storage.googleapis.com/csm-artifacts/asm/asmcli_1.13 > asmcli"
}
resource "null_resource" "down_asmcli" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = local.down_asm
  }
  depends_on = [google_gke_hub_membership.gke_membership]
}


locals{
   prem = "chmod +x asmcli"
}
resource "null_resource" "change_prem" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = local.prem
  }
  depends_on = [google_gke_hub_membership.gke_membership, null_resource.down_asmcli]
}

  
  
  
locals{
   install_service_mesh = "./asmcli install --project_id ${var.project_id} --cluster_name ${var.cluster_name} --cluster_location ${var.zone_name} --fleet_id ${var.project_id} --output_dir ${"./asm-dir-${var.cluster_name}"} --managed --enable_all --ca mesh_ca"
}
resource "null_resource" "istio_ins" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = local.install_service_mesh 
  }
  depends_on = [google_gke_hub_membership.gke_membership, null_resource.change_prem]
}



resource "null_resource" "script_for_istio" {

 provisioner "local-exec" {
    command = <<-EOT
    cat <<EOF | kubectl apply -f -
    apiVersion: v1
    data:
      mesh: |-
        defaultConfig:
          tracing:
            stackdriver: {}
    kind: ConfigMap
    metadata:
      name: istio-asm-managed
      namespace: istio-system
    EOF


    kubectl label namespace default istio.io/rev=asm-managed --overwrite

    kubectl annotate --overwrite namespace default \
      mesh.cloud.google.com/proxy='{"managed":"true"}'
    EOT
 }
  depends_on = [null_resource.istio_ins, null_resource.getting_Cred] 
}


locals{
   cred = "gcloud container clusters get-credentials ${var.cluster_name} --project ${var.project_id} --zone ${var.zone_name}"
}
resource "null_resource" "getting_Cred" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = local.cred
  }
  depends_on = [google_gke_hub_membership.gke_membership, null_resource.istio_ins,]
}


locals{
  apply_m = "kubectl apply -k manifests/ --context=gke_${var.project_id}_${var.zone_name}_${var.cluster_name}"
}
resource "null_resource" "apply_menifest" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = local.apply_m
  }
  depends_on = [google_gke_hub_membership.gke_membership, null_resource.istio_ins, null_resource.script_for_istio, null_resource.getting_Cred]
}

# apply policies
locals{
  apply_policies = "kubectl apply -k policies/ "
}
resource "null_resource" "apply_pol" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = local.apply_policies
  }
  depends_on = [null_resource.apply_menifest]
}


