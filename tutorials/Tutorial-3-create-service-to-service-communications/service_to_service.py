import json
import logging
import os
import requests
import sys

SERVICE_URL = os.getenv('SERVICE_URL', 'http://localhost:8080/echo')
ECHO_TEXT = 'Hello'


def get_logger(logger_name):
    logger = logging.getLogger(logger_name)
    logger.setLevel(logging.DEBUG)
    handler = logging.StreamHandler(sys.stdout)
    handler.setLevel(logging.DEBUG)
    handler.setFormatter(
        logging.Formatter(
            '%(name)s [%(asctime)s] [%(levelname)s] %(message)s'))
    logger.addHandler(handler)
    return logger


logger = get_logger('service-to-service')


def call_service(service_url, echo_input):
    logger.info(f'Calling {service_url} with input {echo_input}')

    row_to_send = {"data": [[0, echo_input]]}
    response = requests.post(url=service_url,
                             data=json.dumps(row_to_send),
                             headers={"Content-Type": "application/json"})

    message = response.json()
    if message is None or not message["data"]:
        logger.error('Received empty response from service ' + service_url)

    response_row = message["data"][0]
    if len(response_row) != 2:
        logger.error('Unexpected response format: ' + response_row)

    echo_reponse = response_row[1]
    logger.info(f'Received response from {service_url}: ' + echo_reponse)


if __name__ == '__main__':
    call_service(SERVICE_URL, ECHO_TEXT)

