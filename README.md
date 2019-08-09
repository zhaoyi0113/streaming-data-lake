# streaming-data-lake

Build a streaming data pipeline on AWS.


## Environment Variables

    - TF_VAR_S3_RAW_DATA
    - TF_VAR_S3_TARGET_DATA
    - TF_VAR_S3_STREAMING_DATA

## Build

`tarraform`, `pipenv`, `python 3.7`, `docker` are required to build the application.

    - run `sh bin/build_layer.sh` to build lambda layer including all lambda dependencies. During building process, a docker image `lambci/lambda` is pulled in order to build a lambda compatible version.
