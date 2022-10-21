
resource "google_gke_hub_membership" "cluster2_membership" {
  membership_id = "${var.project_id}-${var.cluster2_name}"
  endpoint {
    gke_cluster {
      resource_link = "//container.googleapis.com/${module.cluster2.cluster_id}"
    }
  }
  authority {
    issuer = "https://container.googleapis.com/v1/${module.cluster2.cluster_id}"
  }
  provider = google-beta
  depends_on = [module.cluster2]
}


#install ASM with managed control plane
locals {
  cluster2_hub_mesh_update_command = "gcloud alpha container hub mesh update --control-plane automatic --membership ${var.project_id}-${var.cluster2_name} --project=${var.project_id}"
}
resource "null_resource" "cluster2_hub_mesh_update" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = local.cluster2_hub_mesh_update_command
  }
  triggers = {
    command_sha = sha1(local.cluster2_hub_mesh_update_command)
  }
  depends_on = [google_gke_hub_membership.cluster2_membership]
}



locals{
   down_asm2 = "curl https://storage.googleapis.com/csm-artifacts/asm/asmcli_1.13 > asmcli"
}
resource "null_resource" "down_asmcli2" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = local.down_asm2
  }
  depends_on = [google_gke_hub_membership.cluster2_membership]
}


locals{
   prem2 = "chmod +x asmcli"
}
resource "null_resource" "change_prem2" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = local.prem2
  }
  depends_on = [google_gke_hub_membership.cluster2_membership, null_resource.down_asmcli2]
}

  
  
  
locals{
   install_service_mesh2 = "./asmcli install --project_id ${var.project_id} --cluster_name ${var.cluster2_name} --cluster_location ${var.region2_name} --fleet_id ${var.project_id} --output_dir ${"./asm-dir-${var.cluster2_name}"} --managed --enable_all --ca mesh_ca"
}
resource "null_resource" "istio_ins2" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = local.install_service_mesh2 
  }
  depends_on = [google_gke_hub_membership.cluster2_membership, null_resource.change_prem2]
}



resource "null_resource" "script_for_istio2" {

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
  depends_on = [null_resource.istio_ins2, null_resource.getting_Cred2] 
}


locals{
   cred2 = "gcloud container clusters get-credentials ${var.cluster2_name} --project ${var.project_id} --zone ${var.region2_name}"
}
resource "null_resource" "getting_Cred2" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = local.cred2
  }
  depends_on = [google_gke_hub_membership.cluster2_membership, null_resource.istio_ins2,]
}


locals{
  apply_m2 = "kubectl apply -k manifests/ --context=gke_${var.project_id}_${var.region2_name}_${var.cluster2_name}"
}
resource "null_resource" "apply_menifest" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = local.apply_m2
  }
  depends_on = [google_gke_hub_membership.cluster2_membership, null_resource.istio_ins2, null_resource.script_for_istio2, null_resource.getting_Cred2]
}

