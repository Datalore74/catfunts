provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_s3_bucket" "new_bucket" {
  bucket = "danieldevicona"

  tags = {
    Name        = "New bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_policy" "new_bucket_policy" {
  depends_on = [aws_s3_bucket.new_bucket, aws_s3_bucket_public_access_block.new_bucket_public_access_block]
  bucket = aws_s3_bucket.new_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = ["s3:GetObject"]
        Effect    = "Allow"
        Resource  = ["${aws_s3_bucket.new_bucket.arn}/*"]
        Principal = "*"
      }
    ]
  })
}

resource "aws_s3_bucket_public_access_block" "new_bucket_public_access_block" {
  bucket = aws_s3_bucket.new_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
resource "aws_s3_object" "index_file" {
  bucket = aws_s3_bucket.new_bucket.bucket
  key    = "index.html"
  #source = "C:\\Users\\John\\PycharmProjects\\DanielTest\\daniledevicona\\index.html"
  content = "Hello, World!"
  content_type = "text/html"
  }
resource "aws_s3_bucket_website_configuration" "new_bucket_website" {
  bucket = aws_s3_bucket.new_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket" "bucket_that_is_not_public" {
}