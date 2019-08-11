import logging
from api.alpha_vantage import AlphaVantage
from lambdas.secret import get_alpha_vantage_key

logger = logging.getLogger()
logger.setLevel(logging.DEBUG)

def handler(event, context):
    logger.info('receive event')
    logger.info(event)
    cryptos = event['cryptos']
    
    api = AlphaVantage(get_alpha_vantage_key())
    rates = []
    for crypto in cryptos:
        rate = api.request_currency_exchange_rate(crypto)
        rates.append(rate)
    return rates
