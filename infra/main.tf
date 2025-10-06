data "aws_iam_role" "lambda_exec" {
  name = "fastfood-lambda-github-role"
}

resource "aws_lambda_function" "fastfood_lambda" {
  function_name = "fastfood-lambda"
  role          = data.aws_iam_role.lambda_exec.arn
  handler       = "handler.main"
  runtime       = "python3.13"

  filename         = "${path.module}/deploy.zip"
  source_code_hash = filebase64sha256("${path.module}/deploy.zip")

  timeout     = 15
  memory_size = 128
}
