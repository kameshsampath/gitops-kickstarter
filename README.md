# GitOps Go Hello World

Demo resources to show how to deploy [go-helloworld](https://github.com/kameshsampath/go-hello-world) applying GitOps principles.

## Pre-requisites

- [terraform](https://terraform.build)
- [helm](https://helm.sh)
- [kustomize](https://kustomize.io)

## Kubernetes Cluster

> **NOTE**: If you already have a Kubernetes Cluster then you can skip this section. 

Running the following terraform script will setup a GKE cluster,

```shell
make init apply
```

### ArgoCD Deployment

The ArgoCD details can be obtained as shown,

#### Admin Password

```shell
terraform output -raw argocd_admin_password
```

#### ArgoCD Application URL

```shell
```

## Completed Solution

The completed Harness Pipelines is available in [.harness](./harness) folder. The folder has the following resources,

- [Pipeline](./harness/../.harness/Build_Gitops_Greeter.yaml) - the Pipeline to build and push the application image to container registry of your choice
- [Input Set::Default](.harness/Default_GitHub_Dev_Builds.yaml) - the Pipeline input set that could be used with Triggers when need to build images on every push to main branch
- [Input Set::Tags](.harness/Default_GitHub.yaml) - the Pipeline input set that could be used with Triggers when need to build images on every tag

> IMPORTANT: You may need to update few settings like project, secret, connector names as per your settings or create resources with same name

## Harness Documentation References

- [Webhook Triggers Reference](https://developer.harness.io/docs/platform/pipelines/w_pipeline-steps-reference/triggers-reference/)
- [Built-in CI Codebase Variables](https://developer.harness.io/docs/continuous-integration/ci-technical-reference/built-in-cie-codebase-variables-reference/)
