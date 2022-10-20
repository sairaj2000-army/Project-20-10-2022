locals {
  mesh_id       = "${var.common_name_for_hash}-${var.project_id}"
  workload_pool = "${var.project_id}.svc.id.goog"
}

variable "cluster1_name" {}
variable "cluster2_name" {}

variable "region1_name" {}
variable "region2_name" {}

variable "project_id" {}

variable "network_name" {}

variable "subnet1_name" {}
variable "subnet2_name" {}

variable "pod_subnet1_name" {}
variable "pod_subnet2_name" {}

variable "pod_svc_subnet1_name" {}
variable "pod_svc_subnet2_name" {}

variable "firewall_name" {}

variable "minnode" {}
variable "maxnode" {}
variable "disksize" {}

variable "common_name_for_hash" {}

#variable "policy_dir" {}

variable "folder_id" {
  default     = ""
  description = "If you have a folder id, add it here. Leave blank for no folder"
}

variable "asm_version" {}


# For ACM
variable "sync_repo" {
  type        = string
  description = "git URL for the repo which will be sync'ed into the cluster via Config Management"
}

variable "sync_branch" {
  type        = string
  description = "the git branch in the repo to sync"
}

variable "policy_dir" {
  type        = string
  description = "the root directory in the repo branch that contains the resources."
}
