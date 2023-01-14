provider "helm" {
  kubernetes {
    config_path = "${path.module}/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "${path.module}/.kube/config"
}

resource "random_password" "argocd_admin_password" {
  length      = 16
  min_lower   = 1
  min_upper   = 1
  min_special = 1
  min_numeric = 1
  special     = true
}

resource "helm_release" "argocd" {
  depends_on = [
    google_container_cluster.primary,
    local_file.kubeconfig
  ]
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  wait             = true
  create_namespace = true

  values = [
    templatefile("${path.module}/templates/argocd_install_values.tfpl", {
      # ArgoCD password should bcrypt hashes
      argocdAdminPassword = random_password.argocd_admin_password.bcrypt_hash
    })
  ]
}


data "kubernetes_service" "argocd" {
  metadata {
    name      = "argocd-server"
    namespace = "argocd"
  }
}
