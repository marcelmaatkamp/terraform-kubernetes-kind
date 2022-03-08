terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.7.1"
    }
    argocd = {
      source = "oboukili/argocd"
      version = "2.1.0"
    }
  }
}
