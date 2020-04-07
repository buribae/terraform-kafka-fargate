# usage: create_topic.sh [zookeeper_connection_string] [topic_name]

kafka_2.12-2.2.1/bin/kafka-topics.sh --create --zookeeper $1 --replication-factor 3 --partitions 1 --topic $2
