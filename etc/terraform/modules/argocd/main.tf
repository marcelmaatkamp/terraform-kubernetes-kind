resource "helm_release" "argocd" {
  name       = "argocd" 
  namespace  = "argocd"
  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"

  set { 
    name = "repositories[0].name"
    value = "helm-charts-stable"
  }
  set {
    name = "repositories[0].url"
    value = "https://charts.helm.sh/stable"
  }
  set {
    name = "repositories[0].type"
    value = "helm"
  }

  # additionalApplications: 
  # - name: guestbook
  #   namespace: argocd
  #   additionalLabels: {}
  #   additionalAnnotations: {}
  #   finalizers:
  #   - resources-finalizer.argocd.argoproj.io
  #   project: guestbook
  #   source:
  #     repoURL: https://github.com/argoproj/argocd-example-apps.git
  #     targetRevision: HEAD
  #     path: guestbook
  #     directory:
  #       recurse: true
  #   destination:
  #     server: https://kubernetes.default.svc
  #     namespace: guestbook
  #   syncPolicy:
  #     automated:
  #       prune: false
  #       selfHeal: false
  #   ignoreDifferences:
  #   - group: apps
  #     kind: Deployment
  #     jsonPointers:
  #     - /spec/replicas
  #   info:
  #   - name: url
  #     value: https://argoproj.github.io/
}

