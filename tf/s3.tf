resource "aws_s3_bucket" "raw_bucket" {
  bucket = "${var.s3_raw_data}"
}

resource "aws_s3_bucket" "target_bucket" {
  bucket = "${var.s3_target_data}"
}

resource "aws_s3_bucket" "s3_streaming_pipeline_bucket" {
  bucket = "${var.s3_streaming_pipeline}"
}
