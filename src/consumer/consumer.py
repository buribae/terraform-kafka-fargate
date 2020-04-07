from confluent_kafka import Consumer, TopicPartition
import certifi
import boto3
import os

BOOTSTRAP_SERVERS = os.environ["KAFKA_BOOTSTRAP_SERVERS"]

c = Consumer({
        'bootstrap.servers': BOOTSTRAP_SERVERS,
        'ssl.ca.location': certifi.where(),
        'security.protocol': 'ssl',
        'group.id': 'kafka', 
        'auto.offset.reset': 'earliest'
    })

c.subscribe(['ExampleTopic'])

while True:
    msg = c.poll(1.0)

    if msg is None:
        continue
    if msg.error():
        print("Consumer error: {}".format(msg.error()))
        continue
    m = msg.value().decode('utf-8')
    print('Received message: {}'.format(m))
    break

c.close()
