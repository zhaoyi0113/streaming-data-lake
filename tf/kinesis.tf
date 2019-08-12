resource "aws_kinesis_stream" "finance_stream" {
  name             = "${var.project_name}-stream"
  shard_count      = 1
  retention_period = 24
}