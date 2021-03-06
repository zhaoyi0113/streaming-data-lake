BUILD_DIR=dist
rm -fr $BUILD_DIR
mkdir -p $BUILD_DIR/python
pipenv lock -r > $BUILD_DIR/python/requirements.txt
cd $BUILD_DIR/python
docker run -v $(pwd):/outputs -it --rm lambci/lambda:build-python3.7 pipenv run pip install -r /outputs/requirements.txt -t /outputs/
cd ..
zip -r library_layer.zip *
aws s3 cp library_layer.zip s3://${TF_VAR_S3_STREAMING_DATA}/lambdas/
cd ..