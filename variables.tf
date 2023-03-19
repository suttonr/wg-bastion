variable "do_token" {
    type    = string
}
variable "do_ssh_key" {
    type    = string
    default = "terraform"
}
variable "do_region" {
    type    = string
    default = "nyc3"
}
variable "do_size" {
    type    = string
    default = "s-1vcpu-1gb"
}

variable "use_float_ip" {
    type    = bool
    default = false
}
variable "float_ip" {
    type    = string
    default = ""
}
variable "ssh_allowed_network" {
    type    = string
    default = ""
}

variable "wg_port" {
    type    = string
    default = "51820"
}

