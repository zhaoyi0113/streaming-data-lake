resource "aws_cloudwatch_event_rule" "finance_producer_scheduler" {
  name                = "finance_data_producer_scheduler"
  description         = "Fires every five minutes"
  schedule_expression = "rate(5 minutes)"
}

resource "aws_cloudwatch_event_target" "fetch_finance_data" {
  rule      = "${aws_cloudwatch_event_rule.finance_producer_scheduler.name}"
  target_id = "finance_producer_cloudwatch"
  arn       = "${aws_lambda_function.finance_data_producer.arn}"
  input     = "{\"topic\": \"movies\"}"
}