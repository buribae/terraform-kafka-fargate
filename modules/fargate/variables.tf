variable "prefix" {}
variable "vpc_id" {}
variable "subnet_ids" {}
variable "ingress_cidr" {}
variable "zookeeper_connect_string" {}
variable "bootstrap_brokers" {}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "example/example-docker:latest"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 3000
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 2
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "256"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "512"
}
