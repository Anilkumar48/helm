# Teragrunt automate script to create/remove Confluent Kafka Topics
# TODO: add sleep for delay create usage for rest api concurrent status update issue

terraform {
  required_providers {
    restapi = {
      source  = "fmontezuma/restapi"
      version = ">= 1.14.1"
    }
  }
}

variable kafka_cluster_rest_url {} 
variable kafka_cluster_rest_auth {}
variable kafka_cluster_id {}
variable kafka_topics_names {
  type = set(string)
  default = [ "tpg.output", 
              "tpg.input", 
              "tpg.wad.input.stage", 
              "tpg.tax.input.stage", 
              "tpg.input.stage", 
              "tpg.odppyment.input.stage", 
              "tpg.netpay.output", 
              "tpg.netpay.output.stage", 
              "tpg.wad.output", 
              "tpg.wad.output.stage", 
              "tpg.tax.output", 
              "tpg.taxload.output.stage", 
              "tpg.taxremittance.output.stage", 
              "tpg.taxledger.output.stage",
              "tpg.funding.output", 
              "tpg.funding.output.stage", 
              "tpg.wadfunding.output.stage"]
}
variable kafka_topic_prefix {}
variable num_partitions {
  default = 6
}
variable replication_factor {
  default = 3
}

locals {
  kafka_root_path = "/2.0/kafka/${var.kafka_cluster_id}/topics/"
  kafka_prefix_names =  { for n in var.kafka_topics_names : n => "${var.kafka_topic_prefix}.${n}" }
}

provider "restapi" {
  uri = var.kafka_cluster_rest_url
  write_returns_object = false
  create_method = "PUT"
  update_method = "PUT"
  insecure = true
  headers = {
      Authorization = var.kafka_cluster_rest_auth
  }
}


resource "restapi_object" "tpg_kafka_topic" {  

  # cycle through topic names list
  for_each = local.kafka_prefix_names

  path = "${local.kafka_root_path}?validate=false"
  object_id = each.key
  read_path = "${local.kafka_root_path}${each.value}"
  destroy_path = "${local.kafka_root_path}${each.value}"
  data = jsonencode({ 
    name: "${each.value}"
    numPartitions: var.num_partitions
    replicationFactor: var.replication_factor
    configs: {}
  })
  
}


