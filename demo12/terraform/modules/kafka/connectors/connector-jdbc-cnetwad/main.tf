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

resource "restapi_object" "tap-kafka-connect-jdbc-cnetwad-stage_test" {
  path         = "/connectors/tap-kafka-connect-jdbc-cnetwad-stage_test"
  debug        = true
  id_attribute = "name"
  create_method = "put"
  read_path = "/connectors/tap-kafka-connect-jdbc-cnetwad-stage_test"
  destroy_path = "/connectors/tap-kafka-connect-jdbc-cnetwad-stage_test"
  data = jsonencode({
      "connector.class" : "io.confluent.connect.jdbc.JdbcSourceConnector",
      "timestamp.column.name" : "LU_TS",
      "incrementing.column.name" : "DETAIL_KEY",
      "topic.creation.default.partitions" : "6",
      "connection.password" : var.connection_password,
      "basic.auth.credentials.source" : "USER_INFO",
      "query" : "select * from (SELECT DETAIL_KEY, WAD_PAYROLL.LU_TS, WAD_PAYROLL.PAYROLL_KEY as Payroll__Key, TO_CHAR(WAD_PAYROLL.LU_TS,'YYYY-MM-DD\"T\"HH24:MI:SS') as WADCreatedDate, WAD_PAYROLL.client_id as CNETClientID,SUBSTR(WAD_PAYROLL.Coll_Client_Key,1,6) as CollectorID, SUBSTR(WAD_PAYROLL.Coll_Client_Key,7,(LENGTH(WAD_PAYROLL.Coll_Client_Key)-6)) as PSID, TO_CHAR(WAD_PAYROLL.PAYCHECK_DATE,'YYYY-MM-DD\"T\"HH24:MI:SS') as PayDate, WAD_PAYROLL.INCOMING_FILE_NAME as IncomingFileName, TO_CHAR(WAD_PAYROLL.LOADED_TS,'YYYY-MM-DD\"T\"HH24:MI:SS') as IncomingFileLoadTimestamp, WAD_PAYROLL.PAYROLL_AMOUNT as WADTotal, TO_CHAR(WAD_PAYROLL.FUNDS_COLLECTION_TS,'YYYY-MM-DD\"T\"HH24:MI:SS') as FundsCollectionTimestamp, WAD_PAYROLL.FUNDS_COLLECTION_IND as FundsCollectionIndicator, TO_CHAR(WAD_DETAIL.DISBURSEMENT_CHECK_DT,'YYYY-MM-DD\"T\"HH24:MI:SS') as DisbursementCheckDate, WAD_DETAIL.DISBURSEMENT_CHECK_NO as DisbursementCheckNum, WAD_DETAIL.DISBURSEMENT_IND as DisbursementIndicatior, TO_CHAR(WAD_DETAIL.DISBURSEMENT_ACH_DATE,'YYYY-MM-DD\"T\"HH24:MI:SS') as DisbursementACHDate, WAD_DETAIL.DISBURSEMENT_ACH_IND as DisbursementACHIndicator, TO_CHAR(WAD_PAYROLL.FILE_CREATION_TS,'YYYY-MM-DD\"T\"HH24:MI:SS') as FundsCollectionFileCreated,  TO_CHAR(WAD_PAYROLL.FILE_RECEIPT_TS,'YYYY-MM-DD\"T\"HH24:MI:SS') as FileReceiptCreated, WAD_DETAIL.EMPLOYEE_ID as EMPNumber, WAD_DETAIL.EXPECTED_STATE_FEE_AMT as ExpectedStateFeeAmount, WAD_DETAIL.EXPECTED_WAGE_ORD_AMT as ExpectedWageOrderAmount, WAD_DETAIL.WAGE_ORDER_AMOUNT as WageOrderAmount, WAD_DETAIL.VOID_IND as VoidIndicator, WAD_DETAIL.ACH_ENTRY_DETAIL_KEY as ACHEntryDetailKey, WAD_DETAIL.ACH_REISSUE_IND AS ReIssueIndicator, WAD_DETAIL.CONTROL_NUMBER as ControlNumber, WAD_DETAIL.ATTACHMENT_ID as AttachmentID, TO_CHAR(WAD_DETAIL.POST_TO_SAGE_DATE,'YYYY-MM-DD\"T\"HH24:MI:SS') as PostToSageDate, TO_CHAR(WAD_DETAIL.DUE_DATE,'YYYY-MM-DD\"T\"HH24:MI:SS') as DueDate FROM WAD_PAYROLL, WAD_DETAIL WHERE WAD_PAYROLL.payroll_key = WAD_DETAIL.payroll_key and  WAD_PAYROLL.LU_TS > '03-JUN-21' and ROWNUM <=100)a",
      "value.converter.basic.auth.credentials.source" : "USER_INFO",
      "mode" : "timestamp+incrementing",
      "schema.registry.url" : "https://psrc-gq7pv.westus2.azure.confluent.cloud",
      "value.converter.schema.registry.url" : "https://psrc-gq7pv.westus2.azure.confluent.cloud",
      "topic.prefix" : var.topic_prefix,
      "basic.auth.user.info" : var.basic_auth_user_info,
      "value.converter.basic.auth.user.info" : var.value_converter_basic_auth_user_info,
      "connection.user" : var.connection_user,
      "poll.interval.ms" : "1000",
      "topic.creation.default.replication.factor" : "-1",
      "numeric.mapping" : "best_fit",
      "connection.url" : var.connection_url,
      "value.converter" : "io.confluent.connect.protobuf.ProtobufConverter",
      "key.converter" : "org.apache.kafka.connect.storage.StringConverter"
    }
  )
}


