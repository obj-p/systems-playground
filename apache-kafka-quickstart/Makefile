KAFKA_VERSION ?= 3.7.0
SCALA_VERSION ?= 2.13
TOPIC_NAME    ?= quickstart-events
TOPIC_PORT    ?= 9092

kafka_artifact = kafka_$(SCALA_VERSION)-$(KAFKA_VERSION)

.PHONY: all
all: clean
	@$(MAKE) kafka

.PHONY: clean
clean:
	@rm -rf kafka

## Get Kafka

kafka:
	@curl -O \
		"https://dlcdn.apache.org/kafka/$(KAFKA_VERSION)/$(kafka_artifact).tgz"
	@tar -xzf $(kafka_artifact).tgz
	@mv $(kafka_artifact) kafka
	@rm $(kafka_artifact).tgz

## Start the Kafka environment

.PHONY: start-kafka
start-kafka:
	@sh scripts/start-kafka.sh

## Topics

### Create a topic to store your events

.PHONY: create-topic
create-topic:
	 @kafka/bin/kafka-topics.sh --create --topic $(TOPIC_NAME) --bootstrap-server localhost:$(TOPIC_PORT)

.PHONY: describe-topic
describe-topic:
	@kafka/bin/kafka-topics.sh --describe --topic $(TOPIC_NAME) --bootstrap-server localhost:$(TOPIC_PORT)

### Read/write events to topic

.PHONY: read-topic
read-topic:
	@kafka/bin/kafka-console-consumer.sh --topic $(TOPIC_NAME) --bootstrap-server localhost:$(TOPIC_PORT) || true

.PHONY: write-topic
write-topic:
	@kafka/bin/kafka-console-producer.sh --topic $(TOPIC_NAME) --bootstrap-server localhost:$(TOPIC_PORT) || true
