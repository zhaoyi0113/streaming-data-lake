import logging
import json

def handler(event, context):
    logging.info('receive a event:' + json.dumps(event))