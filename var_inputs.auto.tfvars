project_id = "us-gcp-ame-its-23a8a-sbx-1"


cluster_name = "anthos-proj-cluster-final-bu-t1"


region_name = "us-central1"

zone_name = "us-central1-c"


#network and Firewall
network_name = "anthos-proj-network-final-bu-t1"

subnet_name = "anthos-proj-subnet-final-bu-t1"

firewall_name = "allow-all-intra-final-bu-t1"

pod_subnet_name = "anthos-proj-pod-subnet-final-bu-t1"

pod_svc_subnet_name = "anthos-proj-pod-svc-subnet-final-bu-t1"



#ASM
asm_version = "1.10"


#ACM
sync_repo   = "https://github.com/GoogleCloudPlatform/microservices-demo.git"
sync_branch = "main"
policy_dir  = "./release"

# Node pools
minnode  = 4
maxnode  = 5
disksize = 15
