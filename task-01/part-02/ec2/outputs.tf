# i want to output the main_server public ip
output "main_server_public_ip" {
  value = aws_instance.myec2.public_ip
}
