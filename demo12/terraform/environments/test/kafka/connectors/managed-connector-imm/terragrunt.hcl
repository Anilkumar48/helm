include {
  path = find_in_parent_folders()
}

terraform {
    source = "../../../../..//modules/kafka/connectors/managed-connector-imm"
}

inputs = {

      authorization = "Basic SlJORDZHRFZJTFYzTkhHSjpBOTUzNjVNVG5saUs4U3UzM1BRQUZDWTJiNWFZQVJZUUl6ZmZPUFVDRUVZd1RQeG9aNlI1ZDc4NHR6Z2hzd0tp"
      cc_uri = "https://api.confluent.cloud/connect/v1/environments/env-p3nk2/clusters/lkc-pvw6y"
      connector_name = "imm_test"
      topic_prefix = "dev."
      connection_host = "app501-tps-sqlg.database.windows.net"
      connection_port = "1433"
      connection_user = "IMMUser"
      db_name = "app501-imm-qa8-db-IMM"
      connection_password =  ""
      kafka_api_key = "WPPI5MSQPOKDNLG6",
      kafka_api_secret = "mXLcIAzG6plskAgAwXJEJTecZFI36vnGp0FGN9O9x0+Kw80e6TxsvF3tUvCSqmu+"

}