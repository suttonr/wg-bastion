resource "digitalocean_droplet" "wg-bastion" {
    image = "ubuntu-22-04-x64"
    name = "wg-bastion"
    region = var.do_region
    size = var.do_size
    ssh_keys = [
      data.digitalocean_ssh_key.terraform.id
    ]

  provisioner "local-exec" {
    command = "( echo '[wg_bastion]' && echo ${self.ipv4_address} ) > inventory"
  }
}

resource "digitalocean_floating_ip_assignment" "bastionip" {
  ip_address = var.float_ip
  droplet_id = digitalocean_droplet.wg-bastion.id
  count=var.use_float_ip?1:0
}

resource "digitalocean_firewall" "wgbastionports" {
  name = "wgbastionports"

  droplet_ids = [digitalocean_droplet.wg-bastion.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = [var.ssh_allowed_network]
  }

  inbound_rule {
    protocol         = "udp"
    port_range       = var.wg_port
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}