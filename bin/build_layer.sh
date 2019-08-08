BUILD_DIR=dist
rm -fr $BUILD_DIR
mkdir -p $BUILD_DIR/python
cp requirements.txt build/python
cd $BUILD_DIR/python
docker run -v $(pwd):/outputs -it --rm lambci/lambda:build-python3.7 pip install -r /outputs/requirements.txt -t /outputs/
cd ..
zip -r lambda_layer.zip *
aws s3 cp lambda_layer.zip s3://${TF_VAR_S3_STREAMING_DATA}/lambdas/
cd ..