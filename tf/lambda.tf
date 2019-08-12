variable "lambda_timeout" {
  default = 180
}
variable "lambda_runtime" {
  default = "python3.7"
}

resource "aws_lambda_function" "finance_data_producer" {
  s3_bucket        = "${var.S3_STREAMING_DATA}"
  s3_key           = "${local.lambda_finance_producer_file}"
  function_name    = "finance_data_producer"
  role             = "${aws_iam_role.lambda_role.arn}"
  handler          = "lambdas.finance_data_producer.handler"
  source_code_hash = "${filebase64sha256("${local.lambda_finance_producer_build_file}")}"
  runtime          = "${var.lambda_runtime}"
  timeout          = "${var.lambda_timeout}"
  memory_size      = "512"
  depends_on       = [aws_s3_bucket.s3_streaming_pipeline_bucket]
  layers           = ["${aws_lambda_layer_version.lambda_python_deps_layer.arn}"]
  environment {
    variables = {
      env          = "${var.env}"
      project_name = "${var.project_name}"
      stream_name = "${var.project_name}-stream"
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "${var.project_name}-lambda-role"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "lambda_policy" {
  name = "${var.project_name}-lambda-policy"
  description = "IAM Policy"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "autoscaling:Describe*",
                "cloudwatch:*",
                "logs:*",
                "sns:*",
                "ssm:DescribeParameters",
                "ssm:GetParameters",
                "ssm:GetParameter",
                "ssm:GetParametersByPath",
                "kms:*",
                "kinesis:*"
            ],
            "Resource": "*"
        }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda-policy-attach" {
  role = "${aws_iam_role.lambda_role.name}"
  policy_arn = "${aws_iam_policy.lambda_policy.arn}"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_finance_producer" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.finance_data_producer.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.finance_producer_scheduler.arn}"
}


resource "aws_lambda_layer_version" "lambda_python_deps_layer" {
  s3_bucket = "${var.S3_STREAMING_DATA}"
  s3_key = "${local.lambad_library_layer_file}"
  layer_name = "python_deps_layer"
  compatible_runtimes = ["${var.lambda_runtime}"]
  depends_on = [aws_s3_bucket.s3_streaming_pipeline_bucket]
}
