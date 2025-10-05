import json
from src import handler

def test_main():
    event = {"test": "data"}
    context = {}

    result = handler.main(event, context)

    assert result["statusCode"] == 200
    body = json.loads(result["body"])
    assert body["message"] == "Hello from FastFood Lambda!"
