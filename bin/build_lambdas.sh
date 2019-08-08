BUILD_DIR=dist
rm -fr $BUILD_DIR
mkdir -p $BUILD_DIR
cp -fr src/lambdas $BUILD_DIR
zip -r finance_producer.zip *
aws s3 cp finance_producer.zip s3://${TF_VAR_S3_STREAMING_DATA}/lambdas/