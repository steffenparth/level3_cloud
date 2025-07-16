resource "openstack_networking_network_v2" "private_net" {
  name = "private-net"
}

resource "openstack_networking_subnet_v2" "private_subnet" {
  name            = "private-subnet"
  network_id      = openstack_networking_network_v2.private_net.id
  cidr            = "192.168.100.0/24"
  ip_version      = 4
  dns_nameservers = ["8.8.8.8"]
}

resource "openstack_networking_router_v2" "router" {
  name                = "router"
  external_network_id = var.external_network
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
  name            = "my-vm"
  image_name      = "Ubuntu 22.04 Jammy"
  flavor_name     = var.flavor_name
  key_pair        = var.keypair_name
  security_groups = [openstack_networking_secgroup_v2.secgroup.name]

  network {
    uuid = openstack_networking_network_v2.private_net.id
  }
}

resource "openstack_networking_floatingip_v2" "fip" {
  pool = "public"
  description = "Floating IP for my-vm"
}

resource "openstack_networking_port_v2" "port_1" {
  network_id = openstack_compute_instance_v2.vm.network[0].uuid
}

resource "openstack_networking_floatingip_associate_v2" "fip_assoc" {
  floating_ip = openstack_networking_floatingip_v2.fip.address
  # port_id     = openstack_compute_instance_v2.vm.network[0].port
  port_id     = openstack_networking_port_v2.port_1.id
}


# output "instance_ip" {
#   description = "The public IP address of the instance"
#   value       = openstack_networking_floatingip_v2.fip.address
# }

# output "port_id" {
#   description = "The por_id for debug"
#   value = openstack_compute_instance_v2.vm.network[0].port
# }

# output "IPv4" {
#   description = "Test"
#   value = openstack_compute_instance_v2.vm.network[0].uuid
# }
