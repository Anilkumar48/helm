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

variable ase_uri {}
variable connection_password {}
variable kafka_schema_registry_url {}
variable topic_prefix {}
variable basic_auth_user_info {}
variable value_converter_basic_auth_user_info {}
variable connection_user {}
variable connection_url {}


provider "restapi" {
  uri                  = var.ase_uri
  write_returns_object = true
  insecure             = true
  headers = {
  Content-Type = "application/json"
  }
}

resource "restapi_object" "tap-kafka-connect-jdbc-cnettaxledger_TPG-test" {
  path         = "/connectors/tap-kafka-connect-jdbc-cnettaxledger_TPG-test/config"
  debug        = true
  id_attribute = "name"
  create_method = "put"
  read_path = "/connectors/tap-kafka-connect-jdbc-cnettaxledger_TPG-test"
  destroy_path = "/connectors/tap-kafka-connect-jdbc-cnettaxledger_TPG-test"
  data = jsonencode({
      "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
      "incrementing.column.name": "CLIENT_LEDGER_SEQ_NO",
      "topic.creation.default.partitions": "10",
      "connection.password": var.connection_password,
      "basic.auth.credentials.source": "USER_INFO",
      "query": "Select CAST(CLIENT_LEDGER_SEQ_NO as NUMBER(12,0)) as CLIENT_LEDGER_SEQ_NO, CLIENT_ID,PR_COLL_ID,PR_COLL_CLIENTID, CLIENT_TAX_CODE,TAX_ID,CONSOL_TAX_CODE,LIABILITY_DATE, POST_DATE,TRANSACTION_CODE,SOURCE,AMOUNT,REASON_CODE,CHECK_DATE, LEDGER_FLAGS,CREATE_PGM_CODE, ENTRY_ID, FEE_PRICING_FLAG, EXTRA_DATA, DEP_ID_AND_SEQ from (SELECT  CLIENT_LEDGER_SEQ_NO, CLIENT_LEDGER.CLIENT_ID,CLIENT.PR_COLL_ID, CLIENT.PR_COLL_CLIENTID, CLIENT_TAX_CODE,TAX_ID,CONSOL_TAX_CODE,LIABILITY_DATE, POST_DATE,TRANSACTION_CODE,SOURCE,AMOUNT,REASON_CODE,CHECK_DATE, LEDGER_FLAGS,CREATE_PGM_CODE, ENTRY_ID, FEE_PRICING_FLAG, EXTRA_DATA, DEP_ID_AND_SEQ FROM CLIENT_LEDGER, CLIENT WHERE CLIENT_LEDGER.CLIENT_ID = CLIENT.CLIENT_ID ) A",
      "batch.max.rows": "10",
      "value.converter.basic.auth.credentials.source": "USER_INFO",
      "mode": "incrementing",
      "schema.registry.url": var.kafka_schema_registry_url,
      "value.converter.schema.registry.url": var.kafka_schema_registry_url,
      "topic.prefix": var.topic_prefix,
      "basic.auth.user.info": var.basic_auth_user_info,
      "value.converter.basic.auth.user.info": var.value_converter_basic_auth_user_info,
      "connection.user": var.connection_user,
      "poll.interval.ms": "5000",
      "topic.creation.default.replication.factor": "-1",
      "numeric.mapping": "best_fit",
      "connection.url": var.connection_url,
      "value.converter": "io.confluent.connect.protobuf.ProtobufConverter",
      "key.converter": "org.apache.kafka.connect.storage.StringConverter"
    }
  )
}


