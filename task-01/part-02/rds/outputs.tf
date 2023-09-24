
output "rds_endpoint" {
  value     = "postgresql://${aws_db_instance.example.username}:${aws_db_instance.example.password}@${aws_db_instance.example.endpoint}/${aws_db_instance.example.db_name}"
  sensitive = true
}
# security group
# output "vpc_security_group_id" {
#   value = aws_security_group.dev-sg.id
# }
#subnet id

output "subnet_id" {
  value = aws_subnet.subnet-1.id

}

output "vpc_id" {
  value = aws_vpc.dev-vpc.id
}
