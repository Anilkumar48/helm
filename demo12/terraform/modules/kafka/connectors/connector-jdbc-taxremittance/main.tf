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

resource "restapi_object" "tap-kafka-connect-jdbc-cnettaxremittance_TPG-test" {
  path         = "/connectors/tap-kafka-connect-jdbc-cnettaxremittance_TPG-test/config"
  debug        = true
  id_attribute = "name"
  create_method = "put"
  read_path = "/connectors/tap-kafka-connect-jdbc-cnettaxremittance_TPG-test"
  destroy_path = "/connectors/tap-kafka-connect-jdbc-cnettaxremittance_TPG-test"
  data = jsonencode({
      "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
        "timestamp.column.name": "LASTMODIFIEDDATETIME",
        "topic.creation.default.partitions": "10",
        "connection.password": var.connection_password,
        "basic.auth.credentials.source": "USER_INFO",
        "query": "SELECT * from (SELECT TO_DATE(LAST_UPD_DATE || ' ' || SUBSTR(LPAD(LIABILITY_HDR.LAST_UPD_TIME,6, '0'),1,2) || ':'|| SUBSTR(LPAD(LIABILITY_HDR.LAST_UPD_TIME,4,'0'),LENGTH(LIABILITY_HDR.LAST_UPD_TIME)-3,2) || ':'|| SUBSTR(LIABILITY_HDR.LAST_UPD_TIME,LENGTH(LIABILITY_HDR.LAST_UPD_TIME)-1,2), 'DD-MON-YY HH24:MI:SS') as LASTMODIFIEDDATETIME, LIABILITY_HDR.TAX_CODE_AND_ID,LIABILITY_HDR.VOUCHER_NO,LIABILITY_HDR.CHECK_TRANS_NO, LIABILITY_HDR.LIABILITY_DATE,LIABILITY_HDR.PAY_TAX_CODE,LIABILITY_HDR.CLIENT_ID,CLIENT.PR_COLL_ID, CLIENT.PR_COLL_CLIENTID, LIABILITY_HDR.VOUCHER_TYPE,LIABILITY_HDR.CONSOL_AMOUNT,LIABILITY_HDR.TOTAL_AMOUNT,LIABILITY_HDR.AMOUNT as TotalAmount, LIABILITY_HDR.STATUS_FLAG, LIABILITY_DET.TAX_CODE,LIABILITY_DET.AMOUNT as DetailAmount FROM LIABILITY_HDR, LIABILITY_DET, CLIENT  WHERE LIABILITY_HDR.VOUCHER_NO = LIABILITY_DET.VOUCHER_NO AND LIABILITY_HDR.client_id = LIABILITY_DET.client_id and CLIENT.Client_ID = LIABILITY_DET.CLient_ID AND LIABILITY_HDR.liability_date = LIABILITY_DET.liability_date ) A",
        "batch.max.rows": "10",
        "value.converter.basic.auth.credentials.source": "USER_INFO",
        "mode": "timestamp",
        "schema.registry.url": var.kafka_schema_registry_url,
        "value.converter.schema.registry.url": var.kafka_schema_registry_url,
        "topic.prefix":  var.topic_prefix,
        "basic.auth.user.info": var.basic_auth_user_info,
        "value.converter.basic.auth.user.info": var.value_converter_basic_auth_user_info,
        "connection.user": var.connection_user,
        "poll.interval.ms": "5000",
        "topic.creation.default.replication.factor": "-1",
        "name": "tap-kafka-connect-jdbc-cnettaxremittance_TPG-test",
        "numeric.mapping": "best_fit",
        "connection.url": var.connection_url,
        "value.converter": "io.confluent.connect.protobuf.ProtobufConverter",
        "key.converter": "org.apache.kafka.connect.storage.StringConverter"
    }
  )
}


