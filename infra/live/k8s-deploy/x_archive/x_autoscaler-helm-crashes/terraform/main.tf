provider "helm" {
  kubernetes {
    config_path = ".kubeconfig"
  }
}

resource "helm_release" "cluster_autoscaler" {
  name       = "cluster-autoscaler"

  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"

  set {
    name  = "cloudProvider"
    value = "aws"
  }

  set {
    name  = "autoDiscovery.enabled"
    value = "true"
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = var.cluster_id
  }

  set {
    name  = "awsRegion"
    # value = "${data.aws_region.current_region.name}"
    value = var.region
  }

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "sslCertPath"
    value = "/etc/ssl/certs/ca-bundle.crt"
  }

  
}