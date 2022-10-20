module "network" {
  source       = "terraform-google-modules/network/google"
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
      { range_name = "${pod_subnet_name}", ip_cidr_range = "10.10.16.0/20" }, # 4094 usable ips for pods
      { range_name = "${pod_svc_subnet_name}", ip_cidr_range = "10.10.8.0/21" }    # 2046 usable ips for services
    ],
  }


}

module "firewall_rules" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  project_id   = var.project_id
  network_name = var.network_name

  rules = [{
    name      = "allow-ssh-ingress"
    direction = "INGRESS"
    ranges    = ["10.10.0.0/18"]
    allow = [{
      protocol = "tcp"
      ports    = ["22"]
    }]
    }, {
    name      = "Allow Pod to Pod connectivity"
    direction = "INGRESS"
    ranges    = ["10.10.0.0/18"]
    allow = [{
      protocol = "tcp"
      ports    = ["0-65535"]
    }]
    }, {
    name    = "allow-sidecar"
    network = var.network_name
    allow = [{
      protocol = "tcp"
      ports    = ["443", "15017"]
    }]
  }]
}
