import boto3
import logging
import os
from datetime import datetime
import time
import json

client = boto3.client('ssm')
paramBasePath = '/' + os.environ['project_name'] + '/' + os.environ['env']

def get_parameter(param, decryption=False):
    try:
        return client.get_parameter(Name = paramBasePath + '/' + param, WithDecryption=decryption)['Parameter']['Value']
    except Exception as e:
        logging.error(e)
    return None

def get_alpha_vantage_key():
    return get_parameter('alpha_vantage_api_key', True)

def get_raw_s3_bucket():
    return get_parameter('raw_s3_bucket')

def upload_json_to_s3(bucket, path, data):
    s3_resource = boto3.resource('s3')
    file_name = 'finance-' + datetime.now().strftime("%Y-%m-%d %H:%M:%S")+'.json'
    s3_resource.Object(bucket, path + '/' +
                       file_name).put(Body=json.dumps(data))
    print('upload file ' + file_name + ' to s3 bucket ' + bucket + '/' + path)