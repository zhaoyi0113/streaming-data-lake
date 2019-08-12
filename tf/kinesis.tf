resource "aws_kinesis_stream" "finance_stream" {
  name             = "${var.project_name}-stream"
  shard_count      = 1
  retention_period = 24
  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
    "IteratorAgeMilliseconds",
    "OutgoingBytes",
    "OutgoingRecords",
    "ReadProvisionedThroughputExceeded",
    "WriteProvisionedThroughputExceeded"
  ]
}

resource "aws_iam_role" "firehose_source_stream_role" {
  name = "firehose_source_stream_role"

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

resource "aws_iam_policy" "firehose_source_stream_policy" {
  name        = "${var.project_name}-firehose-source-stream"
  description = "IAM Policy"
    policy    = <<EOF
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

resource "aws_iam_role_policy_attachment" "firehose-source-stream-policy-attach" {
  role = "${aws_iam_role.firehose_source_stream_role.name}"
  policy_arn = "${aws_iam_policy.firehose_source_stream_policy.arn}"
}

resource "aws_iam_role" "firehose-target-stream-role" {
  name = "firehose_target_s3_role"

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

resource "aws_iam_policy" "firehose_target_stream_policy" {
  name        = "${var.project_name}-firehose-target-stream"
  description = "IAM Policy"
    policy    = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": "*"
        }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "firehose-target-stream-policy-attach" {
  role = "${aws_iam_role.firehose-target-stream-role.name}"
  policy_arn = "${aws_iam_policy.firehose_target_stream_policy.arn}"
}

resource "aws_kinesis_firehose_delivery_stream" "finance_firehose" {
  name        = "${var.project_name}-finance-stream"
  destination = "extended_s3"

  kinesis_source_configuration {
    kinesis_stream_arn = "${aws_kinesis_stream.finance_stream.arn}"
    role_arn           = "${aws_iam_role.firehose_source_stream_role.arn}"
  }
  extended_s3_configuration {
    prefix              = "raw/"
    error_output_prefix = "firehose_error/"
    role_arn            = "${aws_iam_role.firehose-target-stream-role.arn}"
    bucket_arn          = "${aws_s3_bucket.s3_streaming_pipeline_bucket.arn}"
    cloudwatch_logging_options {
      enabled         = "true"
      log_group_name  = "${aws_cloudwatch_log_group.firehose_log.name}"
      log_stream_name = "${aws_cloudwatch_log_stream.firehose_log_stream.name}"
    }
  }
}

resource "aws_cloudwatch_log_group" "firehose_log" {
  name = "${var.project_name}/${var.env}/finance-log"
}

resource "aws_cloudwatch_log_stream" "firehose_log_stream" {
  name           = "${var.project_name}/${var.env}/finance-log-stream"
  log_group_name = "${aws_cloudwatch_log_group.firehose_log.name}"
}
