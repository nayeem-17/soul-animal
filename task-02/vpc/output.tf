output "vpc_id" {
  value = aws_vpc.dev-vpc.id
}

output "subnet1_id" {
  value = aws_subnet.subnet-1.id
}
output "subnet2_id" {
  value = aws_subnet.subnet-2.id
}
output "db_subnet_group_id" {
  value = aws_db_subnet_group.db-subnet-group.id
}
output "security_group_id" {
  value = aws_security_group.dev-db-sg.id
}
output "db_security_group_id" {
  value = aws_security_group.postgres_sg.id
}
