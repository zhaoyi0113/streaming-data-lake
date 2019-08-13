resource "aws_s3_bucket" "s3_streaming_pipeline_bucket" {
  bucket = "${var.S3_STREAMING_DATA}"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = "${aws_s3_bucket.s3_streaming_pipeline_bucket.id}"

  lambda_function {
    lambda_function_arn = "${aws_lambda_function.trigger_glue_crawler.arn}"
    events = ["s3:ObjectCreated:*"]
    filter_prefix = "raw/"
  }
}