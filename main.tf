locals {
  config_path = pathexpand(".kube/config")
  app_url = "https://github.com/marcelmaatkamp/argocd-data-processing-superset"
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
  name = var.name
  projectName = var.projectName
  repoUrl = var.repoUrl
  repoPath = var.repoPath
  repoTargetRevision = var.repoTargetRevision
  destinationNamespace = var.destinationNamespace
  depends_on = [
    module.kind
  ]
}
