module "enabled_google_apis" {
  source = "./project_services"

  project_id                  = var.project_id
  disable_services_on_destroy = false

  activate_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "gkehub.googleapis.com",
    "anthosconfigmanagement.googleapis.com", # Enabling the anthos config management
    "cloudresourcemanager.googleapis.com",
    "sqladmin.googleapis.com",
    "iam.googleapis.com",
    "anthos.googleapis.com",
    "cloudtrace.googleapis.com",
    "meshca.googleapis.com",
    "meshtelemetry.googleapis.com",
    "meshconfig.googleapis.com",
    "iamcredentials.googleapis.com",
    "gkeconnect.googleapis.com",
    "monitoring.googleapis.com",
    "logging.googleapis.com"
  ]
}

