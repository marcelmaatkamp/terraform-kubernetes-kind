terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.7.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
    argocd = {
      source = "oboukili/argocd"
      version = "2.1.0"
    }
  }
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    annotations = {
      name = "example-annotation"
    }

    labels = {
      mylabel = "label-value"
    }
    name = "argocd"
  }
}

data "kubectl_file_documents" "argocd" {
  content = file("etc/argocd/argo-cd/v2.2.3/manifests/install.yaml")
}

resource "kubectl_manifest" "argocd" {
  count     = length(data.kubectl_file_documents.argocd.documents)
  yaml_body = element(data.kubectl_file_documents.argocd.documents, count.index)
  override_namespace = "argocd"
}
