## S3 BACKEND OUTPUT ##
output "s3_bucket_id" {
  value       = "${aws_s3_bucket.this[*].id}"
  description = "The name of the bucket"
}

output "s3_bucket_arn" {
  value       = "${aws_s3_bucket.this[*].arn}"
  description = "The ARN of the bucket"
}

output "s3_bucket_domain_name" {
  value       = "${aws_s3_bucket.this[*].bucket_domain_name}"
  description = "The bucket domain name"
}

output "s3_bucket_regional_domain_name" {
  value       = "${aws_s3_bucket.this[*].bucket_regional_domain_name}"
  description = "The bucket region-specific domain name"
}

output "s3_bucket_hosted_zone_id" {
  value       = "${aws_s3_bucket.this[*].hosted_zone_id}"
  description = "The Route 53 Hosted Zone ID for this bucket's region"
}

output "s3_bucket_website_endpoint" {
  value       = "${aws_s3_bucket.this[*].website_endpoint}"
  description = "The website endpoint, if the bucket is configured with a website"
}

output "s3_bucket_website_domain" {
  value       = "${aws_s3_bucket.this[*].website_domain}"
  description = "The domain of the website endpoint, if the bucket is configured with a website"
}
