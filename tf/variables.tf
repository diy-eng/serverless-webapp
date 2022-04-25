variable "domain_name" {
  type    = string
  default = "auto-call-webapp-333.example.com"
}

variable "frontend_path" {
  type    = string
  default = "../src/frontend"
}

variable "backend_path" {
  type    = string
  default = "../src/backend"
}