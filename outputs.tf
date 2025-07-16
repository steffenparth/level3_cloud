# output "instance_name" {
#   description = "Name of the created instance"
#   value       = openstack_compute_instance_v2.vm.name
# }

# output "instance_private_ip" {
#   description = "Private IP address of the instance"
#   value       = openstack_compute_instance_v2.vm.access_ip_v4
# }

# output "instance_IPs" {
#   value = [for vm in openstack_compute_instance_v2.vm : vm.access_ip_v4]
# }

# output "floating_ip" {
#   description = "Floating IP address assigned to the instance"
#   value       = openstack_networking_floatingip_v2.fip.address
# }

# output "floating_IPs" {
#   value = [for fip in openstack_networking_floatingip_v2.fips : fip.address]
# }

# output "network_id" {
#   description = "ID of the created network"
#   value       = openstack_networking_network_v2.private_net.id
# }

# output "subnet_id" {
#   description = "ID of the created subnet"
#   value       = openstack_networking_subnet_v2.private_subnet.id
# }

# output "security_group_id" {
#   description = "ID of the created security group"
#   value       = openstack_networking_secgroup_v2.secgroup.id
#   # value = openstack_networking_secgroup_v2
# }
