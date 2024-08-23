#!/bin/bash
# You should source this file 'source ./env-vars-vault-client-dev.sh' so that 
# the enivonment variables set here, stick in the original shell
export VAULT_ADDR="http://127.0.0.1:8200"

# Init vault
export KEYS_FILE="key-shares.json"
vault operator init \
    -format=json \
    -key-shares=6 \
    -key-threshold=2 \
    > $KEYS_FILE

# Unlocking the vault and getting the root token
export ROOT_TOKEN=$(cat $KEYS_FILE | jq -r '.root_token')
export KEY_SHARE_1=$(cat $KEYS_FILE | jq -r '.unseal_keys_b64[0]')
export KEY_SHARE_2=$(cat $KEYS_FILE | jq -r '.unseal_keys_b64[1]')
vault operator unseal $KEY_SHARE_1
vault operator unseal $KEY_SHARE_2

# Login to vault with the root token
vault login -address=$VAULT_ADDR $ROOT_TOKEN

# Export root token to .root-token file
echo $ROOT_TOKEN > .root-token