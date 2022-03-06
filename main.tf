locals {
  config_path = pathexpand(".kube/config")
}

provider "kind" {

}

module "kind" {
  source = "./etc/terraform/modules/kind"
  config_path = local.config_path
}

provider "kubernetes" {
  config_path = local.config_path
}

provider "kubectl" {
  config_path = local.config_path
}

provider "helm" {
  kubernetes {
    config_path = local.config_path
  }
}

module "argocd" {
  source = "./etc/terraform/modules/argocd"
  config_path = local.config_path
  depends_on = [
    module.kind
  ]
}

module "grafana" {
  source = "./etc/terraform/modules/grafana"
  config_path = local.config_path
  depends_on = [
    module.argocd
  ]
}
