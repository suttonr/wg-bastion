# wg-bastion
Terraform and Ansible to provision a wireguard bastion server. Sets up google
domains dynamic dns for clients to use as a consistant endpoint.

# Terraform Input Variables
Some variables you may/should override from their defaults.
## API Key
`TF_VAR_do_token`

Terraform needs a Digital Ocean Personal Access Token for provisioning
resources.  This can be passed into terraform as the `do_token` variable.
If the variable is not set it will be interactively prompted.

## Floating IP
`TF_VAR_use_float_ip`

`TF_VAR_float_ip`

If you have a floating ip to use set `use_float_ip` to true and the floating 
ip in `float_ip`.  The default is not to setup a floating ip

## SSH Key
`TF_VAR_host_ssh_key`

The host key to set on the provisioned host(s). This defaults to a key named 
`terraform`, which is assumed to be already provisioned.

## SSH Firewall
`TF_VAR_ssh_allowed_network`

Network to restrict ssh connections to.  Defaults to empty

## Wireguard Port
`TF_VAR_wg_port`

Port to open for wireguard, this should match the server config in ansible. This isn't currently synced.

# Terraform Example
```
$ terraform plan -var do_token=${DO_PAT}
```

# Ansible Variables
Not an exhaustive list but these are some of the ansible variables that may be
helpful to override from their defaults.
```
# Google Dynamic DNS User
gdns_user: changeme

# Google Dynamic DNS Pass
gdns_pass: changeme
```
```
# Wireguard interface address
wg_address: 192.168.0.1/24

# Wireguard network
wg_network: 192.168.0.0/24

# Wireguard server private key
wg_private_key: changeme

# Wireguard port, this should match the one in the TF config
wg_port: 51820

# List of peer objects
wg_peers:
  - public_key: changeme
    psk: changeme
    ip: changeme
```