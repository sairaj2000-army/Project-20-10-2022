module "network" {
  source       = "./terraform-google-network-master"
  version      = "5.0.0"
  network_name = var.network_name
  project_id   = var.project_id #module.project.project_id
  subnets = [
    {
      subnet_name           = "${var.subnet_name}"
      subnet_ip             = "10.10.0.0/21" # 2046 usable ips for nodes
      subnet_region         = var.region_name
      subnet_private_access = "true"
    },
  ]
  secondary_ranges = {
    "${var.subnet_name}" : [
      { range_name = "${var.pod_subnet_name}", ip_cidr_range = "10.10.16.0/20" }, # 4094 usable ips for pods
      { range_name = "${var.pod_svc_subnet_name}", ip_cidr_range = "10.10.8.0/21" }    # 2046 usable ips for services
    ],
  }
  
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
