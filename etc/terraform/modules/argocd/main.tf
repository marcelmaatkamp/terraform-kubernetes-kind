# https://github.com/argoproj/argo-helm/blob/master/charts/argo-cd/values.yaml

resource "helm_release" "argocd" {
  name       = "argocd" 
  namespace  = "argocd"
  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"

  # https://charts.helm.sh/stable

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

  # https://runatlantis.github.io/helm-charts

  set {
    name = "configs.repositories[1].name"
    value = "runatlantis"
  }
  set {
    name = "configs.repositories[1].url"
    value = "https://runatlantis.github.io/helm-charts"
  }
  set {
    name = "configs.repositories[1].type"
    value = "helm"
  }

  # repoURL

  set {
    name = "server.additionalApplications[0].name"
    value = var.name
  }
  set {
    name = "server.additionalApplications[0].project"
    value = var.projectName
  }
  set {
    name = "server.additionalApplications[0].source.repoURL"
    value = var.repoUrl
  }
  set {
    name = "server.additionalApplications[0].source.path"
    value = var.repoPath
  }
  set {
    name = "server.additionalApplications[0].source.targetRevision"
    value = var.repoTargetRevision
  }
  set {
    name = "server.additionalApplications[0].destination.server"
    value = "https://kubernetes.default.svc"
  }
  set {
    name = "server.additionalApplications[0].destination.namespace"
    value = var.destinationNamespace
  }
  set {
    name = "server.additionalApplications[0].destination.namespace"
    value = var.destinationNamespace
  }
  set {
    name = "server.additionalApplications[0].syncPolicy.automated.prune"
    value = true
  }
  set {
    name = "server.additionalApplications[0].syncPolicy.automated.selfHeal"
    value = true
  }
  set {
    name = "server.additionalApplications[0].directory.recurse"
    value = true
  }
  set {
    name = "server.additionalApplications[0].syncPolicy.syncOptions"
    value = ["CreateNamespace=true"]
  }

}
