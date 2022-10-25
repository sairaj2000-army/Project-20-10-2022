locals {
  mesh_id       = "proj-${var.project_id}"
  workload_pool = "${var.project_id}.svc.id.goog"
}

variable "cluster_name" {}

variable "zone_name" {}

variable "region_name" {}

variable "project_id" {}

variable "network_name" {}

variable "subnet_name" {}
variable "pod_subnet_name" {}
variable "pod_svc_subnet_name" {}

variable "minnode" {}
variable "maxnode" {}
variable "disksize" {}

variable "firewall_name" {}

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

variable "sync_repo2" {
  type        = string
  description = "git URL for the repo which will be sync'ed into the cluster via Config Management"
}

variable "sync_branch2" {
  type        = string
  description = "the git branch in the repo to sync"
}

variable "policy_dir2" {
  type        = string
  description = "the root directory in the repo branch that contains the resources."
}
