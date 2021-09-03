## To do update 
terraform {
  required_providers {
    restapi = {
      source  = "fmontezuma/restapi"
      version = ">= 1.14.1"
    }
  }
}

# variable schema_registry_url {} 
# variable authorization {}


#variable kafka_cluster_rest_url {} 
#variable kafka_cluster_rest_auth {}
#variable kafka_cluster_id {}

variable authorization {}
variable cc_uri{}
variable connector_name {}
variable topic_prefix {}
variable connection_host {}
variable connection_port{}
variable connection_user {}
variable db_name {}
variable connection_password {}
variable kafka_api_key {}
variable kafka_api_secret {}


provider "restapi" {
  uri                  = var.cc_uri 
  write_returns_object = true
  insecure             = true
  headers = {
    Content-Type = "application/json",
    Authorization = var.authorization
  }
}


resource "restapi_object" "imm_test" {
  path         = "/connectors/imm_test/config"
  debug        = true
  id_attribute = "name"
  create_method = "put"
  read_path = "/connectors/imm_test"
  destroy_path = "/connectors/imm_test"
  data = jsonencode({
    "connector.class": "MicrosoftSqlServerSource",
    "name": var.connector_name,
    "topic.prefix": var.topic_prefix ,
    "connection.host": var.connection_host,
    "connection.port": var.connection_port,
    "connection.user": var.connection_user,
    "db.name": var.db_name,
    "connection.password": var.connection_password,
    "kafka.api.key" :  var.kafka_api_key,
    "kafka.api.secret": var.kafka_api_secret,
    "table.whitelist": "tpg.netpay.output.stage",
    "timestamp.column.name": "CreatedTime",
    "incrementing.column.name": "TransactionHistoryId",
    "table.types": "VIEW",
    "output.data.format": "PROTOBUF",
    "tasks.max": "1"
    }
  )
}


