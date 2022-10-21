
project_id = "us-gcp-ame-its-23a8a-sbx-1"

common_name_for_hash = "anthos-final-multi-t1"

cluster1_name = "anthos-proj-cluster1-final-multi-t1"
cluster2_name = "anthos-proj-cluster2-final-multi-t1"

region1_name = "us-west1"
region2_name = "us-east1"


#network and Firewall

network_name = "anthos-proj-network-final-multi-t1"

subnet1_name = "anthos-proj-subnet1-final-multi-t1"
subnet2_name = "anthos-proj-subnet2-final-multi-t1"

pod_subnet1_name = "anthos-proj-pod-sub1-final-multi-t1"
pod_subnet2_name = "anthos-proj-pod-sub2-final-multi-t1"

pod_svc_subnet1_name = "anthos-proj-pod-svc-sub1-t1"
pod_svc_subnet2_name = "anthos-proj-pod-svc-sub2-t1"

#network_name = "anthosprojnetworktest1"

#subnet1_name = "c1-nodes-subnet"
#subnet2_name = "c2-nodes-subnet"

#pod_subnet1_name = "c1-pods-range"
#pod_subnet2_name = "c2-pods-range"

#pod_svc_subnet1_name = "c1-svc-range"
#pod_svc_subnet2_name = "c2-svc-range"

firewall_name = "allow-all-intra-conn-final-multi-t1"


#ASM
asm_version = "1.10"


#ACM
sync_repo   = "https://github.com/GoogleCloudPlatform/gcp-getting-started-lab-jp/tree/master/anthos/k8s-manifest/bookinfo"
sync_branch = "master"
policy_dir  = "dev-kubernetes-manifests/"

# Node pools
minnode  = 4
maxnode  = 5
disksize = 15
