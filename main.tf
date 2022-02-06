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
  source = "./etc/terraform/modules/kind"
  config_path = local.config_path
}

module "argocd" {
  source = "./etc/terraform/modules/argocd"
  config_path = local.config_path
  depends_on = [
    module.kind
  ]
}

resource "argocd_project_token" "secret" {
  project      = "someproject"
  role         = "foobar"
  description  = "short lived token"
  expires_in   = "1h"
  renew_before = "30m"
}

data "kubernetes_secret" "argocd_admin_password" {
  metadata { 
    namespace = "argocd"
    name = "argocd-secret"
  }
  binary_data = {
    "admin.password" = ""
  }
  depends_on = [
    module.argocd
  ]
}

provider "argocd" {
# namespace = "argocd"
  server_addr = "argocd-server:443"
# auth_token  = resource.argocd_project_token.secret.jwt
  username = "admin"
  password = data.kubernetes_secret.argocd_admin_password.binary_data["admin.password"]
}

module "grafana" {
  source = "./etc/terraform/modules/grafana"
  config_path = local.config_path
  depends_on = [
    module.argocd
  ]
}
