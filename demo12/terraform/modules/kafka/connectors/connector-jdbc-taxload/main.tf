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

resource "restapi_object" "tap-kafka-connect-jdbc-cnettaxload_TPG-test" {
  path         = "/connectors/tap-kafka-connect-jdbc-cnettaxload_TPG-test/config"
  debug        = true
  id_attribute = "name"
  create_method = "put"
  read_path = "/connectors/tap-kafka-connect-jdbc-cnettaxload_TPG-test"
  destroy_path = "/connectors/tap-kafka-connect-jdbc-cnettaxload_TPG-test"
  data = jsonencode({
        "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
        "incrementing.column.name": "PAYROLL_DETAIL_SEQ_NO",
        "topic.creation.default.partitions": "10",
        "connection.password": var.connection_password,
        "basic.auth.credentials.source": "USER_INFO",
        "query": "Select CAST(PAYROLL_DETAIL_SEQ_NO as NUMBER(12,0)) as PAYROLL_DETAIL_SEQ_NO, A.DATE_ADDCHG , CNETClientID, CollectorID, TSID,  PAYDATE,HOLDORDELETEFLAG, FundsTransferDate, StatusCode,StatusDate, TaxCode, Amount,  DueDate from (select PAYROLL_DETAIL_SEQ_NO as PAYROLL_DETAIL_SEQ_NO, PAYROLL_HEADER.DATE_ADDCHG , PAYROLL_HEADER.CLIENT_ID as CNETClientID,PAYROLL_HEADER.PR_COLL_ID as CollectorID, CLIENT.PR_COLL_CLIENTID as TSID, PAYROLL_HEADER.LIABILITY_DATE as PAYDATE,PAYROLL_HEADER.HOLD_TRX_FLAG as HOLDORDELETEFLAG,PAYROLL_HEADER.FUNDS_XFER_DATE as FundsTransferDate,PAYROLL_HEADER.STATUS_CODE as StatusCode,PAYROLL_HEADER.STATUS_DATE as StatusDate, PAYROLL_DETAIL.TAX_CODE as TaxCode,PAYROLL_DETAIL.AMOUNT as Amount, PAYROLL_DETAIL.DUE_DATE as DueDate from PAYROLL_HEADER, PAYROLL_DETAIL, CLIENT where PAYROLL_HEADER.PRH_ENTRY_NO = PAYROLL_DETAIL.PRD_ENTRY_NO and PAYROLL_HEADER.client_id = PAYROLL_DETAIL.client_id and PAYROLL_DETAIL.client_id = CLIENT.client_id) A",
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
        "name": "tap-kafka-connect-jdbc-cnettaxload_TPG-test",
        "numeric.mapping": "best_fit",
        "connection.url": var.connection_url,
        "value.converter": "io.confluent.connect.protobuf.ProtobufConverter",
        "key.converter": "org.apache.kafka.connect.storage.StringConverter"
    }
  )
}


