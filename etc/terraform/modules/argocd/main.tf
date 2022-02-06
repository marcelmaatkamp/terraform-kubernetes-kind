resource "kubernetes_namespace" "argocd" {
  metadata {
    annotations = {
      name = "argocd"
    }

    labels = {
      mylabel = "argocd"
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
