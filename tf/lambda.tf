variable "lambda_timeout" {
  default = 180
}
variable "lambda_runtime" {
  default = "python3.7"
}

resource "aws_lambda_function" "finance_data_producer" {
  s3_bucket     = "${var.S3_STREAMING_DATA}"
  s3_key        = "${local.lambda_finance_producer_file}"
  function_name = "finance_data_producer"
  role          = "${aws_iam_role.lambda_role.arn}"
  handler       = "lambdas.finance_data-producer.handler"
  runtime       = "${var.lambda_runtime}"
  timeout       = "${var.lambda_timeout}"
  memory_size   = "512"
  depends_on = [aws_s3_bucket.s3_streaming_pipeline_bucket]
  #   layers           = ["${aws_lambda_layer_version.lambda_python_deps_layer.arn}"]
  environment {
    variables = {
      env          = "${var.env}"
      project_name = "${var.project_name}"
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "aws-lambda-role"
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
