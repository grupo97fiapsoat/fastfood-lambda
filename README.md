# 🔄 Fastfood Lambda 

Este repositório contém a função Lambda responsável por consultar os dados de um cliente com base no CPF, conforme os requisitos do projeto TechChallenge. A função é exposta via API Gateway e provisionada automaticamente com Terraform e GitHub Actions.

---

## 🧠 Objetivo

- Receber requisições via API Gateway
- Retornar dados simulados do cliente com base no CPF informado
- Utilizar arquitetura serverless para escalabilidade e baixo custo

---

## 🧱 Estrutura

- `lambda_function.py`: código da função Lambda em Python
- `lambda.zip`: pacote gerado para deploy
- `main.tf`: código Terraform que cria a Lambda, API Gateway e permissões
- `.github/workflows/deploy.yml`: workflow CI/CD para empacotar e aplicar o Terraform
- `README.md`: documentação do repositório

---

## 🚀 Como funciona

1. O cliente faz uma requisição para o endpoint do API Gateway:  
   `GET /cliente?cpf=12345678900`

2. A API Gateway dispara a função Lambda

3. A Lambda retorna os dados simulados do cliente com base no CPF

---

## 🔐 Segurança

Este repositório utiliza **GitHub Secrets** para armazenar credenciais sensíveis:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`

As credenciais são usadas apenas pelo workflow para autenticar na AWS e aplicar o Terraform.

---

## 🔄 CI/CD

O deploy automatizado é feito via GitHub Actions:

- Proteção de branch ativa  
- Merge via Pull Request obrigatório  
- Workflow empacota a função e executa `terraform apply` automaticamente  

---

## ✅ Requisitos atendidos

- [x] Função Lambda separada em repositório dedicado  
- [x] Provisionamento via Terraform  
- [x] Deploy automatizado com GitHub Actions  
- [x] Uso de Secrets para segurança  
- [x] Branch protegida com PR obrigatório  
- [x] Integração com API Gateway  

---

## 📎 Referência

Este repositório faz parte da arquitetura do projeto TechChallenge. Para mais detalhes, consulte:

- [Repositório da API](https://github.com/seu-usuario/fastfood-api)  
- [Repositório do EKS](https://github.com/seu-usuario/infra-k8s)  
- [Repositório do RDS](https://github.com/seu-usuario/infra-rds)  
- [Vídeo de apresentação](https://link-do-video.com)  

---
