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

  # kong

  set {
    name = "configs.repositories[2].name"
    value = "kong"
  }
  set {
    name = "configs.repositories[2].url"
    value = "https://charts.konghq.com"
  }
  set {
    name = "configs.repositories[2].type"
    value = "helm"
  }

  # hashicorp

  set {
    name = "configs.repositories[3].name"
    value = "hashicorp"
  }
  set {
    name = "configs.repositories[3].url"
    value = "https://helm.releases.hashicorp.com"
  }
  set {
    name = "configs.repositories[3].type"
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
    name = "server.additionalApplications[0].syncPolicy.retry.limit"
    value = "-1"
  }
  set {
    name = "server.additionalApplications[0].syncPolicy.retry.backoff.duration"
    value = "5s"
  }
  set {
    name = "server.additionalApplications[0].syncPolicy.retry.backoff.factor"
    value = "2"
  }
  set {
    name = "server.additionalApplications[0].syncPolicy.retry.backoff.maxDuration"
    value = "3m"
  }
  set {
    name = "server.additionalApplications[0].directory.recurse"
    value = true
  }
  set {
    name = "server.additionalApplications[0].syncPolicy.syncOptions[0]"
    value = "CreateNamespace=true"
  }
  set {
    name = "server.additionalApplications[0].syncPolicy.syncOptions[1]"
    value = "Validate=true"
  }
  set {
    name = "server.additionalApplications[0].syncPolicy.syncOptions[2]"
    value = "PrunePropagationPolicy=foreground"
  }
  set {
    name = "server.additionalApplications[0].syncPolicy.syncOptions[3]"
    value = "PruneLast=true"
  }
}
