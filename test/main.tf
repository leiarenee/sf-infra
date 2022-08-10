resource "random_pet" "this" {
  length = 2
}

output "random_pet" {
  value = random_pet.this.id
}

output "job_resources" {
  value = {
    "Apache_Machine" : "[LINK]https://example.com/apache/sample.php[/LINK]"
  }
}