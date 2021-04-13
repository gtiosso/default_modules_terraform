## S3 BACKEND RESOURCE ##
resource "aws_s3_bucket" "this" {
  count         = "${local.s3_count}"
  bucket        = lookup(element(var.s3_options, count.index), "name")
  acl           = lookup(element(var.s3_options, count.index), "acl")
  force_destroy = lookup(element(var.s3_options, count.index), "force_destroy")

  versioning {
    enabled = lookup(element(var.s3_options, count.index), "versioning")
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = lookup(element(var.s3_options, count.index), "sse_algorithm")
      }
    }
  }

  tags = merge(
    {
      Name = lookup(element(var.s3_options, count.index), "name"),
    },
    "${local.default_tags}",
    lookup(element(var.s3_options, count.index), "extraTags")
  )
}

