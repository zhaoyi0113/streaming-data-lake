resource "aws_sqs_queue" "finance_streaming_queue" {
  name                        = "finance_streaming"
  fifo_queue                  = false
  visibility_timeout_seconds = 30
}

resource "aws_sqs_queue_policy" "allow_cloudwatch_rule_trigger" {
  queue_url = "${aws_sqs_queue.finance_streaming_queue.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.finance_streaming_queue.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_cloudwatch_event_rule.crawler_state_change.arn}"
        }
      }
    }
  ]
}
POLICY
}