resource "aws_s3_bucket" "s3_streaming_pipeline_bucket" {
  bucket = "${var.S3_STREAMING_DATA}"
}
