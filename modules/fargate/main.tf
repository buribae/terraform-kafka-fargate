# -------------------------
# ECS - FARGATE
# -------------------------
resource "aws_ecs_cluster" "example" {
  name = "${var.prefix}-cluster"
}

data "template_file" "task_def" {
  template = "${file("${path.module}/ecs.json.tpl")}"

  vars = {
    zookeeper_connect_string = var.zookeeper_connect_string
    bootstrap_brokers        = var.bootstrap_brokers
    app_image                = var.app_image
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = "app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory

  container_definitions = data.template_file.task_def.rendered
}

resource "aws_ecs_service" "example" {
  name            = "${var.prefix}-ecs-service"
  cluster         = aws_ecs_cluster.example.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.sg-ecs.id]
    subnets         = var.subnet_ids
  }

}

# -------------------------
# ECS - Security Group
# -------------------------
resource "aws_security_group" "sg-ecs" {
  name        = "${var.prefix}-ecs-sg"
  description = "8080 to 8099 inbound"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 8080
    to_port   = 8099
    protocol  = "TCP"

    cidr_blocks = var.ingress_cidr
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}
