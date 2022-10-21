project_id = "us-gcp-ame-its-23a8a-sbx-1"


cluster_name = "anthos-proj-cluster-final-testing1"


region_name = "us-central1"

zone_name = "us-central1-c"


#network and Firewall
network_name = "anthos-proj-network-final-testing1"

subnet_name = "anthos-proj-subnet-final-testing1"

firewall_name = "allow-all-intra-final-testing1"

pod_subnet_name = "anthos-proj-pod-subnet-final-testing1"

pod_svc_subnet_name = "anthos-proj-pod-svc-subnet-final-testing1"



#ASM
asm_version = "1.10"


#ACM
sync_repo   = "https://github.com/GoogleCloudPlatform/bank-of-anthos.git"
sync_branch = "release/v0.5.7"
policy_dir  = "dev-kubernetes-manifests/"

# Node pools
minnode  = 4
maxnode  = 5
disksize = 15
