terraform {
  required_version = ">= 0.13"

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
resource "aws_ecr_repository" "week4_ecr" {
  name = "dimple-app"
  image_scanning_configuration {
    scan_on_push = true
  }
}

module "network" {
  source = "../../MODULES/NETWORK"

  name            = var.name
  azs             = var.azs
  cidr            = var.cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  cluster_name    = var.cluster_name
}

module "cluster" {
  source = "../../MODULES/CLUSTER"
  # depends_on   = [module.network]
  cluster_name = var.cluster_name
  vpc_id       = module.network.vpc_id
  subnet_ids   = module.network.private_subnets
}

resource "null_resource" "configmap" {

  depends_on = [module.cluster]
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --region us-east-2 --name testcluster"
  }

}


module "nginx-controller" {
  source     = "terraform-iaac/nginx-controller/helm"
  depends_on = [null_resource.configmap]
  namespace  = "default"
  additional_set = [
    {
      name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
      value = "nlb"
      type  = "string"
    },
    {
      name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-cross-zone-load-balancing-enabled"
      value = "true"
      type  = "string"
    }
  ]
}

resource "helm_release" "argocd" {
  depends_on       = [module.nginx-controller]
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
}

data "kubectl_path_documents" "docs" {
  pattern = "../../../Argocd/*.yaml"
}

resource "kubectl_manifest" "test" {
  depends_on = [helm_release.argocd]
  count      = length(data.kubectl_path_documents.docs.documents)
  yaml_body  = element(data.kubectl_path_documents.docs.documents, count.index)
}


