resource "aws_ssm_parameter" "alpha_vantage_api_key" {
  name  = "/${var.project_name}/${var.env}/alpha_vantage_api_key"
  type  = "SecureString"
  value = "${var.ALPHA_VANTAGE_API_KEY}"
  key_id = "${aws_kms_key.alpha_vantage_api_key.key_id}"
}

resource "aws_ssm_parameter" "raw_s3_bucket" {
  name  = "/${var.project_name}/${var.env}/raw_s3_bucket"
  type  = "String"
  value = "${aws_s3_bucket.s3_streaming_pipeline_bucket.id}"
}

resource "aws_ssm_parameter" "glue_crawler_name" {
  name  = "/${var.project_name}/${var.env}/glue_crawler_name"
  type = "String"
  value = "${var.glue_crawler_name}"
}
