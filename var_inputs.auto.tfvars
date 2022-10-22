project_id = "us-gcp-ame-its-23a8a-sbx-1"


cluster_name = "anthos-proj-cluster-f-book-t1"


region_name = "us-central1"

zone_name = "us-central1-c"


#network and Firewall
network_name = "anthos-proj-network-f-book-t1"

subnet_name = "anthos-proj-subnet-f-book-t1"

firewall_name = "allow-all-intra-f-book-t1"

pod_subnet_name = "anthos-proj-pod-subnet-f-book-t1"

pod_svc_subnet_name = "anthos-proj-pod-svc-subnet-f-book-t1"



#ASM
asm_version = "1.10"


#ACM
sync_repo   = "https://github.com/GoogleCloudPlatform/gcp-getting-started-lab-jp.git"
sync_branch = "master"
policy_dir  = "./anthos/k8s-manifest/bookinfo"

# Node pools
minnode  = 4
maxnode  = 5
disksize = 15
