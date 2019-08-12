resource "aws_kinesis_stream" "finance_stream" {
  name             = "${var.project_name}-stream"
  shard_count      = 1
  retention_period = 24
}

resource "aws_iam_role" "firehose_s3_role" {
  name = "firehose_s3_role"

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

resource "aws_iam_role" "firehose_stream_role" {
  name = "firehose_stream_role"

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

resource "aws_iam_policy" "firehose_stream_policy" {
  name = "${var.project_name}-firehose-stream"
  description = "IAM Policy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
            "Effect": "Allow",
            "Action": [
                "kinesis:*"
            ],
            "Resource": "*"
        }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "firehose-stream-policy-attach" {
  role = "${aws_iam_role.firehose_stream_role.name}"
  policy_arn = "${aws_iam_policy.firehose_stream_policy.arn}"
}

resource "aws_kinesis_firehose_delivery_stream" "finance_firehose" {
  name        = "${var.project_name}-finance-stream"
  destination = "s3"

  kinesis_source_configuration {
      kinesis_stream_arn = "${aws_kinesis_stream.finance_stream.arn}"
      role_arn = "${aws_iam_role.firehose_stream_role.arn}"
  }
  s3_configuration {
    role_arn   = "${aws_iam_role.firehose_s3_role.arn}"
    bucket_arn = "${aws_s3_bucket.s3_streaming_pipeline_bucket.arn}"
    prefix = "raw/"
  }
}
