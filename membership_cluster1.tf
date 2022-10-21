
resource "google_gke_hub_membership" "cluster1_membership" {
  membership_id = "${var.project_id}-${var.cluster1_name}"
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


#install ASM with managed control plane
locals {
  cluster1_hub_mesh_update_command = "gcloud alpha container hub mesh update --control-plane automatic --membership ${var.project_id}-${var.cluster1_name} --project=${var.project_id}"
}
resource "null_resource" "cluster1_hub_mesh_update" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = local.cluster1_hub_mesh_update_command
  }
  triggers = {
    command_sha = sha1(local.cluster1_hub_mesh_update_command)
  }
  depends_on = [google_gke_hub_membership.cluster1_membership]
}



locals{
   down_asm1 = "curl https://storage.googleapis.com/csm-artifacts/asm/asmcli_1.13 > asmcli"
}
resource "null_resource" "down_asmcli1" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = local.down_asm1
  }
  depends_on = [google_gke_hub_membership.cluster1_membership]
}


locals{
   prem1 = "chmod +x asmcli"
}
resource "null_resource" "change_prem2" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = local.prem1
  }
  depends_on = [google_gke_hub_membership.cluster1_membership, null_resource.down_asmcli1]
}

  
  
  
locals{
   install_service_mesh1 = "./asmcli install --project_id ${var.project_id} --cluster_name ${var.cluster1_name} --cluster_location ${var.region1_name} --fleet_id ${var.project_id} --output_dir ${"./asm-dir-${var.cluster1_name}"} --managed --enable_all --ca mesh_ca"
}
resource "null_resource" "istio_ins1" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = local.install_service_mesh1 
  }
  depends_on = [google_gke_hub_membership.cluster1_membership, null_resource.change_prem1]
}



resource "null_resource" "script_for_istio1" {

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
  depends_on = [null_resource.istio_ins1, null_resource.getting_Cred1] 
}


locals{
   cred1 = "gcloud container clusters get-credentials ${var.cluster1_name} --project ${var.project_id} --zone ${var.region1_name}"
}
resource "null_resource" "getting_Cred1" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = local.cred1
  }
  depends_on = [google_gke_hub_membership.cluster1_membership, null_resource.istio_ins1,]
}


locals{
  apply_m1 = "kubectl apply -k manifests/ --context=gke_${var.project_id}_${var.region1_name}_${var.cluster1_name}"
}
resource "null_resource" "apply_menifest1" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = local.apply_m1
  }
  depends_on = [google_gke_hub_membership.cluster1_membership, null_resource.istio_ins1, null_resource.script_for_istio1, null_resource.getting_Cred1]
}

