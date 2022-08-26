

variable "namespace" {
  type        = string
  default     = ""
}

variable "application_name" {
  type        = string
  default     = "app"
}

variable "source_folder" {
  type        = string
  default     = "src"
}

variable "host" {
  type        = string
  description = "Host address of the service"
  default     = ""
}

variable "port" {
  type        = number
  description = "Port of the service"
  default     = 80
}

variable "health_check_timeout" {
  type        = number
  description = "Timeout value in seconds, for health check."
  default     = 120
}

variable "health_check_enabled" {
  type        = bool
  description = "If true checks if the host:port is open."
  default     = false
}

variable "cname" {
  type        = string
  description = "Domain name of the service"
  default     = ""
}

variable "expose_external" {
  type        = bool
  description = "Create external load balancer"
  default     = true
}

variable "module_enabled" {
  type        = bool
  description = "Enable/disable deployment"
  default     = true
}

variable "dns_zone_id" {
  type        = string
  description = "Route53 hosted zone id."
  default     = ""
} 

variable "assign_cname" {
  type        = bool
  description = "If true a cname record id created for loadBalancer ingress address"
  default     = false
}

variable "raw_outputs" {
  type = bool
  description = "Show raw outputs"
  default = false
}