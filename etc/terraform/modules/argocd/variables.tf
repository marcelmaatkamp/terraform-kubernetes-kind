variable "config_path" {
}
variable "name" {
  type     = string
  nullable = false
}
variable "projectName" {
  type     = string
  nullable = false
}
variable "repoUrl" {
  type     = string
  nullable = false
}
variable "repoPath" {
  type     = string
  nullable = false
}
variable "repoTargetRevision" {
  type     = string
  nullable = false
}
variable "destinationNamespace" {
  type     = string
  nullable = false
}

variable helm_repositories { 
  type        = map(map(string))
  default = {
     charts_helm_stable = {
      name = "charts-helm-stable"
      url  = "https://charts.helm.sh/stable"
      type = "helm"
    },
    runatlantis = {
      name = "runatlantis"
      url  = "https://runatlantis.github.io/helm-charts"
      type = "helm"
    },
    kong = {
      name = "kong"
      url  = "https://charts.konghq.com"
      type = "helm"
    },
    hashicorp = {
      name = "hashicorp"
      url  = "https://helm.releases.hashicorp.com"
      type = "helm"
    }
  }
}
