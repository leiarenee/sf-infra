resource "random_pet" "this" {
  length = 3
}

output "random_pet" {
  value = random_pet.this.id
}

