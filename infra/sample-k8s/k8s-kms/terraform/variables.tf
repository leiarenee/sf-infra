variable "description" {
  default = "EKS Secret Encryption Key"
}

variable "deletion_window_in_days" {
  default = 7
}

variable "enable_key_rotation" {
  default = true
}

variable "tags" {
  default = ""
}