resource "openstack_networking_network_v2" "private_net" {
  name = "private"
}

resource "openstack_networking_subnet_v2" "private_subnet" {
  name            = "private-subnet"
  network_id      = openstack_networking_network_v2.private_net.id
  cidr            = "192.168.100.0/24"
  ip_version      = 4
  dns_nameservers = ["8.8.8.8"]
}

data "openstack_networking_network_v2" "external_network" {
  name = var.external_network
}

resource "openstack_networking_router_v2" "router" {
  name                = "router"
  external_network_id = data.openstack_networking_network_v2.external_network.id
}

resource "openstack_networking_router_interface_v2" "router_interface" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.private_subnet.id
}

resource "openstack_networking_secgroup_v2" "secgroup" {
  name = "web-secgroup"
}

resource "openstack_networking_secgroup_rule_v2" "ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup.id
}

resource "openstack_networking_secgroup_rule_v2" "icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup.id
}

resource "openstack_compute_instance_v2" "vm" {
  count = var.vm_count
  name            = "my-vm-${count.index + 1}"
  image_name      = "Ubuntu 22.04 Jammy"
  flavor_name     = var.flavor_name
  key_pair        = var.keypair_name
  security_groups = [openstack_networking_secgroup_v2.secgroup.name]

  network {
    uuid = openstack_networking_network_v2.private_net.id
    port = openstack_networking_port_v2.ports[count.index].id
  }
}

resource "openstack_networking_floatingip_v2" "fip" {
  count = var.vm_count
  pool = "public"
  description = "Floating IP for my-vm-${count.index + 1}"
}

resource "openstack_networking_port_v2" "ports" {
  count = var.vm_count
  name = "vm-port-${count.index + 1}"
  network_id = openstack_networking_network_v2.private_net.id
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.private_subnet.id
  }

  security_group_ids = [openstack_networking_secgroup_v2.secgroup.id]
}

resource "openstack_networking_floatingip_associate_v2" "fip_assoc" {
  count = var.vm_count
  floating_ip = openstack_networking_floatingip_v2.fip[count.index].address
  port_id     = openstack_networking_port_v2.ports[count.index].id
}



# curl -sfL https://get.k3s.io | K3S_URL=https://172.24.4.125:6443 K3S_TOKEN=K10528e63b5c9fe3d1844c5574b308191b6f3dc18d57d3f146f83a5fab3f8c84283::server:cd3add876693858b0a56f0a9e2ed8e8b sh -