#!/usr/bin/env bash

set -eu

cd kafka

# start zookeeper in background
bin/zookeeper-server-start.sh config/zookeeper.properties & zookeeper_pid=$!
echo "ZooKeeper started at PID: $zookeeper_pid"

# start kafka
bin/kafka-server-start.sh config/server.properties || true

echo "Terminating ZooKeeper at PID: $zookeeper_pid"
kill -2 "$zookeeper_pid"
