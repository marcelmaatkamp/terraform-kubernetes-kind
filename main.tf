terraform {
  required_providers {
    kind = {
      source = "kyma-incubator/kind"
      version = "0.0.11"
    }
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

locals {
  k8s_config_path = pathexpand(".kube/config")
}

provider "kind" {

}

resource "kind_cluster" "default" {
  name = "new-cluster"
  kubeconfig_path = local.k8s_config_path
  wait_for_ready = true
  kind_config {
    kind = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"
    }

    node {
      role = "worker"
    }

    node {
      role = "worker"
    }
  }
}

provider "kubernetes" {
  config_path = ".kube/config"
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

provider "kubectl" {
  config_path = ".kube/config"
}


data "kubectl_file_documents" "argocd" {
    content = file("etc/argo-cd/v2.2.3/manifests/install.yaml")
}

resource "kubectl_manifest" "argocd" {
    count     = length(data.kubectl_file_documents.argocd.documents)
    yaml_body = element(data.kubectl_file_documents.argocd.documents, count.index)
    override_namespace = "argocd"
}

provider "argocd" {
  server_addr = "argocd-server.argocd:443" # env ARGOCD_SERVER
  auth_token  = "1234..."          # env ARGOCD_AUTH_TOKEN
  # username  = "admin"            # env ARGOCD_AUTH_USERNAME
  # password  = "foo"              # env ARGOCD_AUTH_PASSWORD
  insecure    = false              # env ARGOCD_INSECURE
  kubernetes { 
    config_path = local.k8s_config_path
  }
}

resource "argocd_cluster" "kubernetes" {
  server = "https://argocd-server.argocd:443"

  config {
    tls_client_config {
      # ca_data = base64encode(file("path/to/ca.pem"))
      # insecure = true
    }
  }
}

resource "argocd_application" "kustomize" {

  metadata {
    name      = "kustomize-app"
    namespace = "argocd"
    labels = {
      test = "true"
    }
  }

  spec {
    project = "myproject"

    source {
      repo_url        = "https://github.com/kubernetes-sigs/kustomize"
      path            = "examples/helloWorld"
      target_revision = "master"
      kustomize {
        name_prefix = "foo-"
        name_suffix = "-bar"
        images      = ["hashicorp/terraform:light"]
        common_labels = {
          "this.is.a.common" = "la-bel"
          "another.io/one"   = "true"
        }
      }
    }

    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "foo"
    }

    sync_policy {
      automated = {
        prune       = true
        self_heal   = true
        allow_empty = true
      }
      # Only available from ArgoCD 1.5.0 onwards
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

    ignore_difference {
      group         = "apps"
      kind          = "Deployment"
      json_pointers = ["/spec/replicas"]
    }

    ignore_difference {
      group         = "apps"
      kind          = "StatefulSet"
      name          = "someStatefulSet"
      json_pointers = [
        "/spec/replicas",
        "/spec/template/spec/metadata/labels/bar",
      ]
    }
  }
}

resource "argocd_repository" "public_nginx_helm" {
  repo = "https://helm.nginx.com/stable"
  name = "nginx-stable"
  type = "helm"
}

