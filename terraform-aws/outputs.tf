output "instance_id" {
  description = "i-0031eda25d94baf19"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "13.112.167.28"
  value       = aws_instance.app_server.public_ip
}
