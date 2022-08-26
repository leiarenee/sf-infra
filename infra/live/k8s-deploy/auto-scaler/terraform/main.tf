# data "aws_iam_role" "kubernetes_worker_node" {
#   name = "kube-clb-main-wg-primary"
# }

module "cluster_autoscaler" {
  source = "cookielab/cluster-autoscaler-aws/kubernetes"
  version = "0.11.4"

  aws_iam_role_for_policy = var.worker_iam_role_name # data.aws_iam_role.kubernetes_worker_node.name
  
  # additional_kubernetes_cluster_roles = [
  #   {
  #     api_groups = ["storage.k8s.io"]
  #     resources = ["csinodes"]
  #     verbs = ["watch", "list", "get"]
  #   }
  # ]

  asg_tags = [
    "k8s.io/cluster-autoscaler/enabled",
    "k8s.io/cluster-autoscaler/${var.cluster_id}",
  ]

  kubernetes_deployment_image_tag = "v1.23.1" 
}