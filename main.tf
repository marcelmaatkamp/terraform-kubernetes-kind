locals {
  config_path = pathexpand(".kube/config")
}

provider "kind" {

}

provider "kubernetes" {
  config_path = local.config_path
}

provider "kubectl" {
  config_path = local.config_path
}

module "kind" {
  source = "./modules/kind"
  config_path = local.config_path
}

module "argocd" {
  source = "./modules/argocd"
  config_path = local.config_path
}
