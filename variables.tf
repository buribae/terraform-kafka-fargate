variable "prefix" {
  description = "Prefix"
  default     = "msk-fargate-example"
}

variable "ingress_cidr" {
  default = [
    "0.0.0.0/0",
  ]

  type = list(string)
}
