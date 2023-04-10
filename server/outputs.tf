output "server_public_ip" {
  value       = aws_instance.us2204.public_ip
  description = "The public IP address of the web server"
}

