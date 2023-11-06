# output the bucket name
output "bucket_name" {
  value = aws_s3_bucket.terraform_state1.bucket_domain_name
}
