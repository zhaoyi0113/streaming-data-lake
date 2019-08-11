import boto3
import logging
import os

client = boto3.client('ssm')
paramBasePath = '/' + os.environ['project_name'] + '/' + os.environ['env']

def get_alpha_vantage_key():
    try:
        return client.get_parameter(Name = paramBasePath + '/alpha_vantage_api_key', WithDecryption=True)['Parameter']['Value']
    except Exception as e:
        logging.error(e)
    return None