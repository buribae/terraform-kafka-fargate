resource "aws_kms_key" "kms" {
  description = "example"
}

resource "aws_security_group" "sg-kafka" {
  name        = "${var.prefix}-kafka-sg"
  description = "only 9092-9094, 2181 inbound"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 9092
    to_port     = 9094
    protocol    = "TCP"
    cidr_blocks = var.ingress_cidr
  }


  ingress {
    from_port   = 2181
    to_port     = 2181
    protocol    = "TCP"
    cidr_blocks = var.ingress_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_msk_cluster" "example" {
  cluster_name           = "${var.prefix}-msk"
  kafka_version          = "2.2.1"
  number_of_broker_nodes = 2

  broker_node_group_info {
    instance_type   = "kafka.m5.large"
    ebs_volume_size = "100"

    client_subnets = var.subnet_ids

    security_groups = [aws_security_group.sg-kafka.id]
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = aws_kms_key.kms.arn
  }

}


output "zookeeper_connect_string" {
  value = aws_msk_cluster.example.zookeeper_connect_string
}

output "bootstrap_brokers" {
  description = "Plaintext connection host:port pairs"
  value       = aws_msk_cluster.example.bootstrap_brokers
}

output "bootstrap_brokers_tls" {
  description = "TLS connection host:port pairs"
  value       = aws_msk_cluster.example.bootstrap_brokers_tls
}
