
output "rds_endpoint" {
  value     = "postgresql://${aws_db_instance.example.username}:${aws_db_instance.example.password}@${aws_db_instance.example.endpoint}/${aws_db_instance.example.db_name}"
  sensitive = true
}
output "aurora-endpoint" {
  # value = aws_rds_cluster.example-1.endpoint
  value     = "postgresql://${aws_rds_cluster.example-1.master_username}:${aws_rds_cluster.example-1.master_password}@${aws_rds_cluster.example-1.endpoint}/${aws_rds_cluster.example-1.database_name}"
  sensitive = true
}

