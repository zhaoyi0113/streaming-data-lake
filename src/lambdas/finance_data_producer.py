import logging
from api.alpha_vantage import AlphaVantage
from utils.utils import get_alpha_vantage_key, get_raw_s3_bucket, upload_json_to_s3
import boto3
import json

logger = logging.getLogger()
logger.setLevel(logging.DEBUG)

def handler(event, context):
    logger.info('receive event')
    logger.info(event)
    cryptos = event['cryptos']
    bucket = get_raw_s3_bucket()
    api = AlphaVantage(get_alpha_vantage_key())
    rates = []
    for crypto in cryptos:
        rate = api.request_currency_exchange_rate(crypto)
        rates.append(rate)
    upload_json_to_s3(bucket, 'crypto', rates)
    return rates

def send_to_stream(name, data):
    client = boto3.client('kinesis')
    try:
        data = json.dumps(data).encode()
        return client.put_record(StreamName=name, Data=data, PartitionKey='123')
    except Exception as e:
        logging.error(e)
    return None