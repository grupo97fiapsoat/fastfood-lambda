# =========================================
# Role IAM para Lambda (GitHub Actions OIDC)
# =========================================
resource "aws_iam_role" "lambda_exec" {
  name = "fastfood-lambda-github-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      # Lambda precisa assumir a role
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      },
      # GitHub Actions via OIDC
      {
        Effect = "Allow",
        Principal = {
          Federated = "arn:aws:iam::939111385333:oidc-provider/token.actions.githubusercontent.com"
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          },
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:grupo97fiapsoat/fastfood-lambda:*"
          }
        }
      }
    ]
  })
}

# ===================================================
# Anexar política básica para Lambda (logs CloudWatch)
# ===================================================
resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# ===================================================
# Política adicional para criar/gerenciar roles via Terraform
# ===================================================
resource "aws_iam_role_policy" "lambda_permissions" {
  name = "fastfood-lambda-permissions"
  role = aws_iam_role.lambda_exec.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "iam:CreateRole",
          "iam:AttachRolePolicy",
          "iam:PassRole"
        ],
        Resource = "arn:aws:iam::939111385333:role/fastfood-lambda-role"
      },
      {
        Effect = "Allow",
        Action = [
          "lambda:*",
          "logs:*",
          "cloudwatch:*",
          "s3:*"
        ],
        Resource = "*"
      }
    ]
  })
}

# ===============================
# Função Lambda
# ===============================
resource "aws_lambda_function" "fastfood_lambda" {
  function_name = "fastfood-lambda"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "handler.main"           # arquivo handler.py e função main
  runtime       = "python3.13"             # confirme se disponível na sua região

  filename         = "${path.module}/deploy.zip"         # ZIP que contém o código
  source_code_hash = filebase64sha256("${path.module}/deploy.zip")
}
