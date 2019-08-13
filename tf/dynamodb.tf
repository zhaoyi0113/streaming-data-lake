resource "aws_dynamodb_table" "finance_dynamodb_table" {
    name ="finance_data"
    hash_key = "id"
    range_key = "LastRefreshed"
    billing_mode = "PAY_PER_REQUEST"
    attribute {
        name = "id"
        type = "S"
    }
    attribute {
        name = "LastRefreshed"
        type = "S"
    }
}
