
logger = logging.getLogger()
logger.setLevel(logging.DEBUG)

def handler(event, context):
    logger.info('receive event')
    logger.info(event)