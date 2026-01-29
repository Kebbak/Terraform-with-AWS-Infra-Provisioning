# create variables for kafka topic
variable "kafka_topic_name" {
  description = "The name of the Kafka topic"
  type        = string
}
variable "kafka_topic_partitions" {
  description = "The number of partitions for the Kafka topic"
  type        = number
  default     = 1
}

variable "kafka_topic_replication_factor" {
  description = "The replication factor for the Kafka topic"
  type        = number
  default     = 1
}

variable "kafka_producer_user" {
  description = "The Kafka user allowed to produce messages to the topic"
  type        = string
}