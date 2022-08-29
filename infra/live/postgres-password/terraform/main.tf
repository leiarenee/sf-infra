resource "random_password" "this" {
  length  = 24
  special = false
}

resource "aws_secretsmanager_secret" "postgres" {
  name_prefix = "postgres"
}

resource "aws_secretsmanager_secret_version" "postgres" {
  secret_id     = aws_secretsmanager_secret.postgres.id
  secret_string = jsonencode({password=random_password.this.result})
}

output "password" {
  value     = random_password.this.result
  sensitive = true
}

