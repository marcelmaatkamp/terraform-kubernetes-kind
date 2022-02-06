# resource "argocd_repository" "repository_grafana_operator" {
#   repo = "https://github.com/grafana-operator/grafana-operator"
# }

resource "argocd_application" "grafana_operator" {
  metadata {
    name      = "grafana-operator-system"
    namespace = "grafana-operator-system"
    labels = {
      test = "true"
    }
  }

  spec {
    project = "grafana-operator"

    source {
      repo_url        = "https://github.com/grafana-operator/grafana-operator"
      path            = "grafana-operator/deploy/manifests"
      target_revision = "master"
      kustomize {
        common_labels = {
          "this.is.a.common" = "la-bel"
          "another.io/one"   = "true" 
        }
      }
    }

    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "grafana-operator-system"
    }

    sync_policy {
      automated = {
        prune       = true
        self_heal   = true
        allow_empty = true
      }
      sync_options = ["Validate=false"]
      retry {
        limit   = "5"
        backoff = {
          duration     = "30s"
          max_duration = "2m"
          factor       = "2"
        }
      }
    }
  }
}
