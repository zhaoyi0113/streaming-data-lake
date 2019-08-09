
class AlphaVantage:
    ALPHA_VANTAGE_BASE_URL = 'https://www.alphavantage.co'
    QUERY_URL = ALPHA_VANTAGE_BASE_URL + '/query'

    def __init__(self, apiKey):
        self.apiKey = apiKey

    def requestDigitalCurrencyDaily(symbol):
        