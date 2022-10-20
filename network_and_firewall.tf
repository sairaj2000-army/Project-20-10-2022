module "network" {
  source       = "terraform-google-modules/network/google"
  version      = "5.0.0"
  network_name = var.network_name
  project_id   = var.project_id #module.project.project_id
  subnets = [
    {
      subnet_name           = "${var.subnet1_name}"
      subnet_ip             = "10.10.0.0/21" # 2046 usable ips for nodes
      subnet_region         = var.region1_name
      subnet_private_access = "true"
    },
    {
      subnet_name           = "${var.subnet2_name}"
      subnet_ip             = "10.10.32.0/21" # 2046 usable ips for nodes
      subnet_region         = var.region2_name
      subnet_private_access = "true"
    },
  ]

  secondary_ranges = {}
  
  firewall_rules = [{
    name        = var.firewall_name
    description = "Allow Pod to Pod connectivity"
    direction   = "INGRESS"
    ranges      = ["10.10.0.0/18"]
    allow = [{
      protocol = "tcp"
      ports    = ["0-65535"]
    }]
  }]

}
