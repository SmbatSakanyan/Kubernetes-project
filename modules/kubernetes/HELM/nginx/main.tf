# provider "aws" {
#   region = var.region
# }

provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    cluster_ca_certificate = base64decode(var.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.cluster_name, "--region", "us-east-2", "--output", "json"]
      command     = "aws"
    }
    # config_path = "~/.kube/config"
  }
}
# resource "aws_ecr_repository" "week4_ecr" {
#   name = "dimple-app"
#   image_scanning_configuration {
#     scan_on_push = true
#   }
# }


resource "helm_release" "nginx" {
  name       = "nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "default"
  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }
}


resource "helm_release" "argocd" {
  #   depends_on       = [module.nginx-controller]
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
}

resource "helm_release" "app" {
  #   depends_on       = [module.nginx-controller]
  name             = "argocd-app"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argocd-apps"
  namespace        = "argocd"
  create_namespace = true
  values = [
    "${file("values.yaml")}"
  ]
}

# resource "helm_release" "image-updater" {
#   #   depends_on       = [module.nginx-controller]
#   name             = "argocd-image-updater"
#   repository       = "https://argoproj.github.io/argo-helm"
#   chart            = "argocd-image-updater"
#   namespace        = "argocd"
#   create_namespace = true
#   values = [
#     "${file("values1.yaml")}"
#   ]
# }
