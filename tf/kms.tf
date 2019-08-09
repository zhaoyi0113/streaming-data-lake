resource "aws_kms_key" "alpha_vantage_api_key" {
  description = "Alpha Vantage API Key"
}

resource "aws_kms_alias" "alpha_vantage_api_key" {
  name = "alias/alpha_vantage_api_key"
  target_key_id = "${aws_kms_key.alpha_vantage_api_key.key_id}"
}

resource "aws_ssm_parameter" "alpha_vantage_api_key" {
  name  = "/${var.project_name}/${var.env}/alpha_vantage_api_key"
  type  = "SecureString"
  value = "${var.ALPHA_VANTAGE_API_KEY}"
  key_id = "${aws_kms_key.alpha_vantage_api_key.key_id}"
}