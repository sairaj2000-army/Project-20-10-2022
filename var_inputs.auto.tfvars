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

sync_repo2   = "https://github.com/sairaj2000-army/Project-20-10-2022.git"
sync_branch2 = "single_cluster_buti_test1"
policy_dir2 = "./config-root"

# Node pools
minnode  = 4
maxnode  = 5
disksize = 15
