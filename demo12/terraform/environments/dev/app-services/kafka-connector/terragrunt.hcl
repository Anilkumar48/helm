include {
  path = find_in_parent_folders()
}

terraform {
    source = "../../../..//modules/app-services/kafka-connector"
}

inputs = {
  app_service = "app505-tpg-connector"
  location_dev = "Central US"
  rg_dev = "app505-aks-sandbox-rg"
  asp_id = "/subscriptions/0f1c414a-a389-47df-aab8-a351876ecd47/resourceGroups/app505-aks-sandbox-rg/providers/Microsoft.Web/serverfarms/app505-aks-sandbox-localization-service"
  acr_url = "https://app505deploycr.azurecr.io"
  acr_username = "app505deploycr"
  acr_password = "pWkFJoN9MF0QokcW4YqyRok2Cx/uTQ6J"
  connect_basic_auth_credentials_source = "USER_INFO"
  connect_basic_auth_user_info = "HSQ2SXTUJ3YVARKU:+bsG2mogl1n8Bq6y3slwBz7bKt0EFxR6yW0eIi9ZS9/11wbUIghzw0vaynjiGcXm"
  connect_bootstrap_servers = "pkc-epwny.eastus.azure.confluent.cloud:9092"
  connect_config_storage_topic = "connect-jdbc-cluster-offsets"
  connect_consumer_sasl_jaas_config = "org.apache.kafka.common.security.plain.PlainLoginModule   required username='JHFBCBPDKNLZIBEH'   password='iXTHgbpZEPUEWeP+gwYaCzJIQuqVXYth1tbwgw3JL+/yxAvJM7uyYY479qtMwl43';"
  connect_consumer_sasl_mechanism = "PLAIN"
  connect_consumer_sasl_password = "8csdf9qv+dYtDSLqFwskrApgR1U5L1GEvV/E/Se8owgFD95tdQcEDTw0C9pFjXmi"
  connect_consumer_sasl_username = "MFHPJFU5CBLWYLCE"
  connect_consumer_security_protocol = "SASL_SSL"
  connect_group_id = "connect-jdbc"
  connect_key_converter = "org.apache.kafka.connect.storage.StringConverter"
  connect_offset_storage_topic = "connect-jdbc-cluster-configs"
  connect_plugin_path = "/opt/kafka/plugins"
  connect_producer_sasl_jaas_config = "org.apache.kafka.common.security.plain.PlainLoginModule   required username='JHFBCBPDKNLZIBEH'   password='iXTHgbpZEPUEWeP+gwYaCzJIQuqVXYth1tbwgw3JL+/yxAvJM7uyYY479qtMwl43';"
  connect_producer_sasl_mechanism = "PLAIN"
  connect_producer_sasl_password = "8csdf9qv+dYtDSLqFwskrApgR1U5L1GEvV/E/Se8owgFD95tdQcEDTw0C9pFjXmi"
  connect_producer_sasl_username = "MFHPJFU5CBLWYLCE"
  connect_producer_security_protocol = "SASL_SSL"
  connect_rest_advertised_host_name = "0.0.0.0"
  connect_sasl_jaas_config = "org.apache.kafka.common.security.plain.PlainLoginModule   required username='JHFBCBPDKNLZIBEH'   password='iXTHgbpZEPUEWeP+gwYaCzJIQuqVXYth1tbwgw3JL+/yxAvJM7uyYY479qtMwl43';"
  connect_sasl_mechanism = "PLAIN"
  connect_sasl_password = "8csdf9qv+dYtDSLqFwskrApgR1U5L1GEvV/E/Se8owgFD95tdQcEDTw0C9pFjXmi"
  connect_sasl_username = "MFHPJFU5CBLWYLCE"
  connect_schema_registry_url = "https://psrc-gq7pv.westus2.azure.confluent.cloud"
  connect_security_protocol = "SASL_SSL"
  connect_status_storage_topic = "connect-jdbc-cluster-status"
  connect_value_converter = "io.confluent.connect.protobuf.ProtobufConverter"
  website_httplogging_retention_days = "3"
  websites_enable_app_service_storage = "false"
}