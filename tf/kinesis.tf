resource "aws_kinesis_stream" "finance_stream" {
  name             = "${var.project_name}-stream"
  shard_count      = 1
  retention_period = 24
}

resource "aws_iam_role" "firehose_role" {
  name = "firehose_finance_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_kinesis_firehose_delivery_stream" "test_stream" {
  name        = "${var.project_name}-finance-stream"
  destination = "s3"

  s3_configuration {
    role_arn   = "${aws_iam_role.firehose_role.arn}"
    bucket_arn = "${aws_s3_bucket.target_bucket.arn}"
  }
}