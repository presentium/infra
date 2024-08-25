# Vault PKI Setup

## Start local dev vault
```bash
sudo ./run-server-dev.sh
```

## Initialize vault
```bash
cd bootstrap && source ./bootstrap-dev.sh && cd ..
```

This will init the vault and login the current shell to the vault. The root token is stored in `./bootstrap/.root-token` and printed to the console.

## Terraform
In the `terraform` directory, run the following commands to create the PKI infrastructure:

```bash
tf init
tf apply
```

You need to have the `VAULT_ADDR` environment variable set to the address of the vault server and the current shell logged in to the vault.