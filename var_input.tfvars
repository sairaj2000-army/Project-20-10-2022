project_id = "us-gcp-ame-its-23a8a-sbx-1"


cluster_name = "anthos_Proj_cluster1_test1"


region_name = "us-central1"

zone_name = "us-central1-c"


#network and Firewall
network_name = "anthos_proj_network_test1"

subnet1_name = "anthos_proj_subnet1_test1"
subnet2_name = "anthos_proj_subnet2_test1"

firewall_name = "allow-all-intra-test1"


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
