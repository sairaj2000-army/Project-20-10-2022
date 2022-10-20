
project_id = "us-gcp-ame-its-23a8a-sbx-1"

common_name_for_hash = "anthos_test1"

cluster1_name = "anthos_Proj_cluster1_test1"
cluster2_name = "anthos_Proj_cluster1_test1"

region1_name = "us-east1"
region2_name = "us-west1"


#network and Firewall
network_name = "anthosprojnetworktest1"

subnet1_name = "anthos_proj_subnet1_test1"
subnet2_name = "anthos_proj_subnet2_test1"

pod_subnet1_name = "anthos_proj_pod_subnet1_test1"
pod_subnet2_name = "anthos_proj_pod_subnet2_test1"

pod_svc_subnet1_name = "anthos_proj_pod_svc_subnet1_test1"
pod_svc_subnet2_name = "anthos_proj_pod_svc_subnet2_test1"

firewall_name = "allow-all-intra"


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
