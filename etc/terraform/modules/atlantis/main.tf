resource "argocd_application" "helm" {
  metadata {
    name      = "atlantis"
    namespace = "atlantis"
  }

  wait = true

  spec {
    source {
      repo_url        = "https://runatlantis.github.io/helm-charts"
      chart           = "atlantis"
      target_revision = "3.16.0"
      helm {
        value_files = ["values-test.yml"]
        values      = <<EOT
atlantis:
  atlantisUrl: "https://x.y.z"
EOT
      }
    }

    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "default"
    }
  }
}
