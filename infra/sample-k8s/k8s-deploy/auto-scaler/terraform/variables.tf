variable "module_enabled" {
  description = "Enable/disable module"
  type        = bool
  default     = true
}


variable "kubernetes_resources_labels" {
  type = map(string)
  default = {}
  description = "Additional labels for kubernetes resources."
}

variable "worker_iam_role_name" {
  type        = string
  description = "IAM role name of the Worker Nodes "
  default      = ""
}