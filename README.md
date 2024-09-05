# Infrastructure for Presentium

Infrastructure for deploying the Presentium API and dashboard on the cloud.

## Contexts

There are three contexts defined in this infrastructure, each deployed on separate terms.
They are defined in independent directories, as follows:

- `infrastructure`: The base infrastructure code defined using Terraform, it is the foundation for the other contexts.
  It manages the Cloudflare settings, AWS VPC, AWS EKS, AWS IAM, etc. It also deploys ArgoCD
  on the cluster. Continuously delivered using GitHub Actions from the `production` branch.
- `applications`: Terraform modules for configuring specific application of the infrastructure, such as Authentik for
  the SSO page and authentication providers, and Hashicorp Vault for the reader device PKI exchange. Delivered
  automatically using GitHub Actions from the `production` branch, triggered by ArgoCD after deployments.
- `dockerfiles`: Dockerfiles for the applications that are deployed on the cluster. These are built and pushed to the
  GitHub Container Registry using GitHub Actions. The images are then deployed using ArgoCD. The `production` branch
  is the one that is packaged.

## Variables and secrets

#### Infrastructure

The infrastructure depends on several variables and secrets that are stored in the context for GitHub Actions.
You'll find below a list of them and their purpose.

| Name         | Description                                               |
| ------------ | --------------------------------------------------------- |
| `AWS_REGION` | The AWS region where the infrastructure will be deployed. |
| `AWS_ARN`    | The ARN that should be assumed when deploying changes.    |

| Variable             | Description                                               |
| -------------------- | --------------------------------------------------------- |
| `aws_region`         | The AWS region where the infrastructure will be deployed. |
| `aws_arn`            | The ARN that should be assumed when deploying changes.    |
| `cloudflare_api_key` | The Cloudflare API key for changes                        |
| `dkim_public_key`    | The public key for the mail DKIM signature                |
| `dkim_private_key`   | The private key for the mail DKIM signature               |

#### Applications

The applications context depends on several variables and secrets that are stored in the context for GitHub Actions.

| Variable                   | Description                                          |
| -------------------------- | ---------------------------------------------------- |
| `authentik_url`            | The URL of the Authentik instance to configure       |
| `authentik_api_key`        | The API key for Authentik                            |
| `vault_oidc_client_id`     | The client ID for the OIDC proxy to GitHub OAuth     |
| `vault_oidc_client_secret` | The client secret for the OIDC proxy to GitHub OAuth |

## Continuous Delivery

The infrastructure is deployed using GitHub Actions. The workflow is defined in `.github/workflows/terraform-apply.yml`.

The `production` branch is the one that will be applied when modified.

The default branch therefore is `main`, and the `production` branch is protected.
When an infrastructure change is ready to be deployed, a pull request should be made from `main` to `production`.

## Contributing

Please refer to the [Contributing Guide][contributing] before making a pull request.

[contributing]: https://github.com/presentium/meta/blob/main/CONTRIBUTING.md
