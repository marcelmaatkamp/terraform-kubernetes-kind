# https://github.com/argoproj/argo-helm/blob/master/charts/argo-cd/values.yaml

resource "helm_release" "argocd" {
  name       = "argocd" 
  namespace  = "argocd"
  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"

  set { 
    name = "configs.repositories[0].name"
    value = "helm-charts-stable"
  }
  set {
    name = "configs.repositories[0].url"
    value = "https://charts.helm.sh/stable"
  }
  set {
    name = "configs.repositories[0].type"
    value = "helm"
  }

  set {
    name = "configs.additionalApplications[0].name"
    value = "project"
  }
  set {
    name = "configs.additionalApplications[0].project"
    value = "project"
  }
  set {
    name = "configs.additionalApplications[0].source.repoURL"
    value = var.repoURL
  }
  set {
    name = "configs.additionalApplications[0].source.path"
    value = var.repoPath
  }
  set {
    name = "configs.additionalApplications[0].source.targetRevision"
    value = var.repoTargetRevision
  }

}

