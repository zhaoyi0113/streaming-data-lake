data "aws_iam_policy" "S3FullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

data "aws_iam_policy" "GlueService" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}
