# streaming-data-lake

This project is to demo how to build a streaming data serverless pipeline on AWS. It inculdes AWS services such as `kinesis stream`, `kinesis firehose`, `s3`, `lambda`, `KMS`, `System manager` etc.

## How to run

This project is managed by `Terraform` as IaC framework. You will have to install `terraform` on your system. All other code like lambda is implemented in `python`.

## Environment Variables

    - TF_VAR_S3_STREAMING_DATA

## Build

`tarraform`, `pipenv`, `python 3.7`, `docker` are required to build the application.

    - run `sh bin/build_layer.sh` to build lambda layer including all lambda dependencies. During building process, a docker image `lambci/lambda` is pulled in order to build a lambda compatible version.
