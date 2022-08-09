
resource "random_password" "this" {
  length  = 24
  special = false
}

output "password" {
  value     = random_password.this.result
  sensitive = true
}
