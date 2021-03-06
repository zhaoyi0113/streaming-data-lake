import logging
from api.alpha_vantage import AlphaVantage
from utils.utils import get_alpha_vantage_key, get_raw_s3_bucket, upload_json_to_s3
import boto3
import json
import os

logger = logging.getLogger()
logger.setLevel(logging.DEBUG)

def handler(event, context):
    logger.info('receive event')
    logger.info(event)
    cryptos = event['cryptos']
    # bucket = get_raw_s3_bucket()
    api = AlphaVantage(get_alpha_vantage_key())
    rates = []
    for crypto in cryptos:
        rate = api.request_currency_exchange_rate(crypto)
        rates.append(rate)
    # upload_json_to_s3(bucket, 'crypto', rates)
    send_to_stream(os.environ['stream_name'], rates)
    return rates

def send_to_stream(name, data):
    client = boto3.client('kinesis')
    try:
        data = json.dumps(data).encode()
        logging.info('send to stream ')
        logging.info(data)
        return client.put_record(StreamName=name, Data=data, PartitionKey='123')
    except Exception as e:
        logging.error(e)
    return None