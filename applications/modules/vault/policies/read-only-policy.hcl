# Read system health check
path "sys/health"
{
  capabilities = ["read"]
}

# List existing policies
path "sys/policies/acl"
{
  capabilities = ["list"]
}

# Read ACL policies
path "sys/policies/acl/*"
{
  capabilities = ["read", "list"]
}

# Allow creating child tokens
path "auth/token/create" {  
  capabilities = ["create", "update", "sudo"]  
}

# Read auth methods broadly across Vault
path "auth/*"
{
  capabilities = ["read", "list"]
}

# List auth methods
path "sys/auth"
{
  capabilities = ["read"]
}

# Enable and manage the key/value secrets engine at `secret/` path

# List key/value secrets
path "secret/*"
{
  capabilities = ["read", "list"]
}

# Read secrets engines
path "sys/mounts/*"
{
  capabilities = ["read", "list"]
}

# List existing secrets engines.
path "sys/mounts"
{
  capabilities = ["read"]
}

# Read pki secrets engine
path "pki*" {
  capabilities = [ "read", "list" ]
}