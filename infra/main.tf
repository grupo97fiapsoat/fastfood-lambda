# Role usado pela Lambda para execução
resource "aws_iam_role" "lambda_exec" {
  name = "fastfood-lambda-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Anexa a policy básica (logs etc.)
resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Criação (ou atualização) da função Lambda
resource "aws_lambda_function" "fastfood_lambda" {
  function_name = "fastfood-lambda"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "handler.main"
  runtime       = "python3.13"

  filename         = "${path.module}/deploy.zip"
  source_code_hash = filebase64sha256("${path.module}/deploy.zip")

  timeout     = 15
  memory_size = 128
}
