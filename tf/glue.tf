variable "glue_raw_catalog_db" {
  default = "raw_finance_catalog"
}

resource "aws_glue_crawler" "glue_crawler" {
  database_name = "${var.glue_raw_catalog_db}"
  name          = "${var.glue_crawler_name}"
  role          = "${aws_iam_role.glue_crawler_role.arn}"
  configuration = <<EOF
{
    "Version": 1.0,
    "Grouping": { "TableGroupingPolicy": "CombineCompatibleSchemas" }
}
EOF
  s3_target {
    path = "s3://${aws_s3_bucket.s3_streaming_pipeline_bucket.id}/raw"
  }
}
resource "aws_iam_role" "glue_crawler_role" {
  name = "crawler_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "glue.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "crawler_glue_policy_attachment" {
  role = "${aws_iam_role.glue_crawler_role.name}"
  policy_arn = "${data.aws_iam_policy.GlueService.arn}"
}

resource "aws_iam_role_policy_attachment" "crawler_s3_policy_attachment" {
  role = "${aws_iam_role.glue_crawler_role.name}"
  policy_arn = "${data.aws_iam_policy.S3FullAccess.arn}"
}

resource "aws_glue_classifier" "finance_classifier" {
  name = "finance_classifier"

  json_classifier {
    json_path = "$.\"1. From_Currency Code\""
  }
}
