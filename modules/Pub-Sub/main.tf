# create kafka topic
resource "kafka_topic" "my_topic" {
  name               = var.kafka_topic_name
  partitions         = var.kafka_topic_partitions
  replication_factor = var.kafka_topic_replication_factor

  config = {
    "cleanup.policy" = "compact"
  }
}

# create kafka acl to allow producers to write to the topic
resource "kafka_acl" "producer_acl" {
  principal      = "User:${var.kafka_producer_user}"
  host           = "*"
  operation      = "Write"
  permission_type = "Allow"
  resource_type  = "Topic"
  resource_name  = kafka_topic.my_topic.name
}