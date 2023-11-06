# i want to output the main_server public ip
output "test_server_public_ip" {
  value = aws_instance.test.public_ip
}

output "staging_server_public_ip" {
  value = aws_instance.stage.public_ip
}
