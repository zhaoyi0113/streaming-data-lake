# streaming-data-lake

Build a streaming data pipeline on AWS.


## Environment Variables

    - TF_VAR_S3_RAW_DATA
    - TF_VAR_S3_TARGET_DATA
    - TF_VAR_S3_STREAMING_DATA

## Build

    - run `sh bin/build_layer.sh` to build lambda layer including all lambda dependencies
