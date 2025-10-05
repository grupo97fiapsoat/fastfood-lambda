import json
import logging

# Configura logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def main(event, context):
    logger.info("Lambda executando...")
    logger.info(f"Evento recebido: {json.dumps(event)}")

    # Lógica de exemplo
    response = {
        "statusCode": 200,
        "body": json.dumps({"message": "Hello from FastFood Lambda!"})
    }

    logger.info("Lambda finalizou execução com sucesso.")
    return response
