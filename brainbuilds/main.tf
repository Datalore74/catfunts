provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "www.brainbuilds.com.au"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_policy" "my_bucket_policy" {
  depends_on = [aws_s3_bucket.my_bucket, aws_s3_bucket_public_access_block.my_bucket_public_access_block]
  bucket = aws_s3_bucket.my_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = ["s3:GetObject"]
        Effect    = "Allow"
        Resource  = ["${aws_s3_bucket.my_bucket.arn}/*"]
        Principal = "*"
      }
    ]
  })
}

resource "aws_s3_bucket_public_access_block" "my_bucket_public_access_block" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_s3_bucket" "new_bucket" {
  bucket = "new-bucket-name"

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