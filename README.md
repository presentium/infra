# Infrastructure for Presentium

Infrastructure for deploying the Presentium API and dashboard on the cloud.

## Continuous Delivery

The infrastructure is deployed using GitHub Actions. The workflow is defined in `.github/workflows/terraform-apply.yml`.

The `production` branch is the one that will be applied when modified.

The default branch therefore is `main`, and the `production` branch is protected.
When an infrastructure change is ready to be deployed, a pull request should be made from `main` to `production`.

## Contributing

Please refer to the [Contributing Guide][contributing] before making a pull request.

[contributing]: https://github.com/presentium/meta/blob/main/CONTRIBUTING.md
