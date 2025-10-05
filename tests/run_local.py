import json
from src import handler

# Ler o evento de teste
with open("tests/test_event.json") as f:
    event = json.load(f)

# Simular contexto vazio
context = {}

# Chamar a Lambda
result = handler.main(event, context)

print("Resultado da execução:")
print(json.dumps(result, indent=2))
