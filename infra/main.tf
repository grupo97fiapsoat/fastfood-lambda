provider "aws" {
  region = "sa-east-1"
}

resource "aws_iam_role" "lambda_exec" {
  name = "fastfood-lambda-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "fastfood_lambda" {
  function_name = "fastfood-lambda"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "handler.main" # arquivo handler.py e função main
  runtime       = "python3.13"

  filename      = "${path.module}/deploy.zip" # o ZIP que vamos criar
  source_code_hash = filebase64sha256("${path.module}/deploy.zip")
}
