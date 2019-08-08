### ENV
variable "env" {
  default = "dev"
}

variable "project_name" {
  default = "streaming_data_pipeline"
}

variable "ALPHA_VANTAGE_API_KEY" {

}

### S3 Bucket Variables
variable "S3_RAW_DATA" {
  default = "streaming_raw_data"
}

variable "S3_TARGET_DATA" {
  default = "streaming_target_data"
}

variable "S3_STREAMING_DATA" {
  default = "streaming_pipeline_resources"
}


variable "alpha_vantage_api_key" {

}

## Build Resources

variable "lambda_package_local_build_folder" {
  default = "dist"
}

variable "lambda_finance_producer_file_name" {
  default = "finance_producer.zip"
}

variable "lambda_library_layer_file_name" {
  default = "library_layer.zip"
}

variable "lambda_package_folder" {
  default = "dist"
}



locals {
  lambda_finance_producer_build_file = "${var.lambda_package_local_build_folder}/${var.lambda_finance_producer_file_name}"
  lambda_library_layer_build_File    = "${var.lambda_package_local_build_folder}/${var.lambda_library_layer_file_name}"
  lambda_finance_producer_file       = "${var.lambda_package_folder}/${var.lambda_finance_producer_file_name}"
  lambad_library_layer_file          = "${var.lambda_package_folder}/${var.lambda_library_layer_file_name}"
}
