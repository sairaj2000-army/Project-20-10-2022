project_id = "us-gcp-ame-its-23a8a-sbx-1"


cluster_name = "anthos_Proj_cluster1_test5"


region_name = "us-central1"

zone_name = "us-central1-c"


#network and Firewall
network_name = "anthos_proj_network_test5"

subnet_name = "anthos_proj_subnet_test5"

firewall_name = "allow-all-intra-test5"

pod_subnet_name = "anthos-proj-pod-subnet-test5"

pod_svc_subnet_name = "anthos-proj-pod-svc-subnet-test5"



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
