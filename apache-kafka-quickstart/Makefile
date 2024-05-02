KAFKA_VERSION ?= 3.7.0
SCALA_VERSION ?= 2.13

kafka_artifact = kafka_$(SCALA_VERSION)-$(KAFKA_VERSION)

.PHONY: all
all: clean
	@$(MAKE) kafka

.PHONY: clean
clean:
	@rm -rf kafka

kafka:
	@curl -O \
		"https://dlcdn.apache.org/kafka/$(KAFKA_VERSION)/$(kafka_artifact).tgz"
	@tar -xzf $(kafka_artifact).tgz
	@mv $(kafka_artifact) kafka
	@rm $(kafka_artifact).tgz
