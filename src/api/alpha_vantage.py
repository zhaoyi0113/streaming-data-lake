import requests
import logging

class AlphaVantage:
    ALPHA_VANTAGE_BASE_URL = 'https://www.alphavantage.co'
    QUERY_URL = ALPHA_VANTAGE_BASE_URL + '/query'

    def __init__(self, apiKey):
        self.apiKey = apiKey

    def request_digital_currency_daily(self, crypto, currency='AUD'):
        """
        This API returns the daily historical time series for a digital currency (e.g., BTC) traded on a specific market (e.g., CNY/Chinese Yuan), 
        refreshed daily at midnight (UTC). Prices and volumes are quoted in both the market-specific currency and USD.
        """
        params = {'function': 'DIGITAL_CURRENCY_DAILY', 'symbol': crypto, 'market': currency, 'apikey': self.apiKey}
        try:
            url = AlphaVantage.QUERY_URL
            r = requests.get(url, params=params)
            return r.json()
        except Exception as e:
            logging.error(e)
        return None

    def request_currency_exchange_rage(self, crypto, currency = 'AUD'):
        """
        This API returns the realtime exchange rate for any pair of digital currency (e.g., Bitcoin) or physical currency (e.g., USD).
        """
        params = {'function': 'CURRENCY_EXCHANGE_RATE', 'from_currency': crypto, 'to_currency': currency, 'apikey': self.apiKey}
        try:
            r = requests.get(AlphaVantage.QUERY_URL, params=params)
            return r.json()       
        except Exception as e:
            logging.error(e)
        return None
