# Infrastructure for Presentium

Infrastructure for deploying the Presentium API and dashboard on the cloud.

## Contexts

There are three contexts defined in this infrastructure, each deployed on separate terms.
They are defined in independent directories, as follows:

- `infrastructure`: The base infrastructure code defined using Terraform, it is the foundation for the other contexts.
  It manages the Cloudflare settings, AWS VPC, AWS EKS, AWS IAM, etc. It also deploys ArgoCD
  on the cluster.
- `kubernetes`: Kubernetes resource management on the cluster, this is the base directory used by ArgoCD for deploying
  the resources.
- `applications`: Terraform modules for configuring specific application of the infrastructure, such as Authentik for
  the SSO page and authentication providers, and Hashicorp Vault for the reader device PKI exchange.

`infrastructure` and `applications` are continuously delivered using GitHub Actions, using the `production` branch as
the target for deployment. They are separate contexts since applications configuration might depend on resources created
by other contexts and could require manual intervention (for example, setting up API tokens).

`kubernetes` is entirely managed by ArgoCD, usually tracking the `HEAD` branch.

## Variables and secrets

The infrastructure depends on several variables and secrets that are stored in the context for GitHub Actions.
You'll find below a list of them and their purpose.

| Name         | Description                                               |
|--------------|-----------------------------------------------------------|
| `AWS_REGION` | The AWS region where the infrastructure will be deployed. |
| `AWS_ARN`    | The ARN that should be assumed when deploying changes.    |

## Continuous Delivery

The infrastructure is deployed using GitHub Actions. The workflow is defined in `.github/workflows/terraform-apply.yml`.

The `production` branch is the one that will be applied when modified.

The default branch therefore is `main`, and the `production` branch is protected.
When an infrastructure change is ready to be deployed, a pull request should be made from `main` to `production`.

## Contributing

Please refer to the [Contributing Guide][contributing] before making a pull request.

[contributing]: https://github.com/presentium/meta/blob/main/CONTRIBUTING.md
