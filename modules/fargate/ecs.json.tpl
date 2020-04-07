[
    {
      "portMappings": [
        {
          "hostPort": 8099,
          "protocol": "tcp",
          "containerPort": 8099
        },
        {
          "hostPort": 8080,
          "protocol": "tcp",
          "containerPort": 8080
        }
      ],
      "environment": [
        {
          "name": "KAFKA_BOOTSTRAP_SERVERS",
          "value": "${bootstrap_brokers}"
        },
        {
          "name": "ZOOKEEPER_CONNECTION_STRING",
          "value": "${zookeeper_connect_string}"
        }
      ],
      "image": "${app_image}",
      "dependsOn": [

      ],
      "name": "example",
      "essential": true
    }
  ]
