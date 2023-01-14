resource "local_file" "app_of_apps_values" {
  depends_on = [
    helm_release.argocd
  ]
  content = templatefile("${path.module}/templates/app_of_apps_values.tfpl", {
    gitOpsRepoURL      = "${var.gitops_repo}"
    gitopsRepoRevision = "${var.gitops_repo_revision}"
  })
  filename             = "${path.module}/helm_vars/app-of-apps/values.yaml"
  file_permission      = 0600
  directory_permission = 0600
}

resource "kubernetes_manifest" "argo_app_of_apps" {
  depends_on = [
    helm_release.argocd
  ]
  manifest = yamldecode(templatefile("${path.module}/templates/app.tfpl", {
    argoAppName        = "${var.argocd_app_name}"
    gitOpsRepoURL      = "${var.gitops_repo}"
    gitopsRepoRevision = "${var.gitops_repo_revision}"
  }))
}