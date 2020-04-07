#!/bin/bash

# install java -required to run kafka client
case "$OSTYPE" in
  darwin*)  echo "Installing java on OSX" && brew cask install java ;;
  linux*)   echo "Installing java on LINUX"
    if [  -n "$(uname -a | grep Ubuntu)" ]; then
      sudo apt-get install openjdk-8-jdk
    else
      sudo yum install java-1.8.0
    fi
    ;;
  msys*)    echo "WINDOWS not supported" ;;
  *)        echo "unknown: $OSTYPE not supported" ;;
esac

# install kafka
wget https://archive.apache.org/dist/kafka/2.2.1/kafka_2.12-2.2.1.tgz
tar -xzf ../kafka_2.12-2.2.1.tgz
rm kafka_2.12-2.2.1.tgz
