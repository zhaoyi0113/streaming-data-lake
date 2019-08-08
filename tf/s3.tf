resource "aws_s3_bucket" "raw_bucket" {
  bucket = "${var.S3_RAW_DATA}"
}

resource "aws_s3_bucket" "target_bucket" {
  bucket = "${var.S3_TARGET_DATA}"
}

resource "aws_s3_bucket" "s3_streaming_pipeline_bucket" {
  bucket = "${var.S3_STREAMING_DATA}"
}
