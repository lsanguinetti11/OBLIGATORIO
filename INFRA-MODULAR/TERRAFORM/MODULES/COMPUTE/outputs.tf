
output "app_instance_ids" {
  description = "IDs de las instancias de aplicación"
  value       = module.compute.app_instance_ids
}

output "app_instance_private_ips" {
  description = "IPs privadas de las instancias de aplicación"
  value       = module.compute.app_instance_private_ips
}

output "app_instance_public_ips" {
  description = "IPs públicas de las instancias de aplicación"
  value       = module.compute.app_instance_public_ips
}
