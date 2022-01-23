terraform {
  required_providers {
    kind = {
      source = "unicell/kind"
      version = "0.0.2-u2"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.7.1"
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

