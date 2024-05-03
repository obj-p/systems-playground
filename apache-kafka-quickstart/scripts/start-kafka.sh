#!/usr/bin/env sh

set -eu

KAFKA_PORT="${KAFKA_PORT:-9092}"
ZOOKEEPER_PORT="${ZOOKEEPER_PORT:-2181}"

if lsof -Pi :"$ZOOKEEPER_PORT" -sTCP:LISTEN -t >/dev/null; then
  echo "Port $ZOOKEEPER_PORT is already in use"
  exit 1
fi

if lsof -Pi :"$KAFKA_PORT" -sTCP:LISTEN -t >/dev/null; then
  echo "Port $KAFKA_PORT is already in use"
  exit 1
fi

cd kafka

# start zookeeper in background
bin/zookeeper-server-start.sh config/zookeeper.properties & zookeeper_pid=$!
echo "ZooKeeper started at PID: $zookeeper_pid"

# start kafka
bin/kafka-server-start.sh config/server.properties || true

echo "Terminating ZooKeeper at PID: $zookeeper_pid"
kill -0 "$zookeeper_pid" && kill "$zookeeper_pid"
wait "$zookeeper_pid" || true
