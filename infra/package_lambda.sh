#!/bin/bash
set -e

# Caminho relativo para src a partir de infra
ZIP_PATH="../infra/deploy.zip"

# Limpa zip antigo
rm -f "$ZIP_PATH"

# Vai para a pasta src (um nível acima de infra)
cd ../src

# Cria o zip
zip -r "$ZIP_PATH" *

# Volta para infra
cd ../infra

echo "Lambda package criado em $ZIP_PATH"
