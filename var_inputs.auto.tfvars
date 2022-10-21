project_id = "us-gcp-ame-its-23a8a-sbx-1"


cluster_name = "anthos-proj-cluster-final-testing2"


region_name = "us-central1"

zone_name = "us-central1-c"


#network and Firewall
network_name = "anthos-proj-network-final-testing2"

subnet_name = "anthos-proj-subnet-final-testing2"

firewall_name = "allow-all-intra-final-testing2"

pod_subnet_name = "anthos-proj-pod-subnet-final-testing2"

pod_svc_subnet_name = "anthos-proj-pod-svc-subnet-final-testing2"



#ASM
asm_version = "1.10"


#ACM
sync_repo   = "https://github.com/GoogleCloudPlatform/bank-of-anthos.git"
sync_branch = "main"
policy_dir  = "./kubernetes-manifests"

# Node pools
minnode  = 4
maxnode  = 5
disksize = 15
