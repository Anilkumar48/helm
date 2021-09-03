resource "azurerm_app_service" "myappservicecontainer" {
 name                    =  var.app_service
 location                =  var.location_dev
 resource_group_name     =  var.rg_dev
 app_service_plan_id     =  var.asp_id
 https_only              = true
 client_affinity_enabled = false
 site_config {
   scm_type             = "None"
   always_on            = "true"
   linux_fx_version     = "DOCKER|app505deploycr.azurecr.io/deb_connectors:latest" #define the image to use 
 } 
 app_settings = {
    DOCKER_REGISTRY_SERVER_URL                = var.acr_url
    DOCKER_REGISTRY_SERVER_USERNAME           = var.acr_username
    DOCKER_REGISTRY_SERVER_PASSWORD           = var.acr_password
    CONNECT_BASIC_AUTH_CREDENTIALS_SOURCE     = var.connect_basic_auth_credentials_source
    CONNECT_BASIC_AUTH_USER_INFO              = var.connect_basic_auth_user_info
    CONNECT_BOOTSTRAP_SERVERS                 = var.connect_bootstrap_servers
    CONNECT_CONFIG_STORAGE_TOPIC              = var.connect_config_storage_topic
    CONNECT_CONSUMER_SASL_JAAS_CONFIG         = var.connect_consumer_sasl_jaas_config
    CONNECT_CONSUMER_SASL_MECHANISM           = var.connect_consumer_sasl_mechanism
    CONNECT_CONSUMER_SASL_PASSWORD            = var.connect_consumer_sasl_password
    CONNECT_CONSUMER_SASL_USERNAME            = var.connect_consumer_sasl_username
    CONNECT_CONSUMER_SECURITY_PROTOCOL        = var.connect_consumer_security_protocol
    CONNECT_GROUP_ID                          = var.connect_group_id
    CONNECT_KEY_CONVERTER                     = var.connect_key_converter
    CONNECT_OFFSET_STORAGE_TOPIC              = var.connect_offset_storage_topic
    CONNECT_PLUGIN_PATH                       = var.connect_plugin_path
    CONNECT_PRODUCER_SASL_JAAS_CONFIG         = var.connect_producer_sasl_jaas_config
    CONNECT_PRODUCER_SASL_MECHANISM           = var.connect_producer_sasl_mechanism
    CONNECT_PRODUCER_SASL_PASSWORD            = var.connect_producer_sasl_password
    CONNECT_PRODUCER_SASL_USERNAME            = var.connect_producer_sasl_username
    CONNECT_PRODUCER_SECURITY_PROTOCOL        = var.connect_producer_security_protocol
    CONNECT_REST_ADVERTISED_HOST_NAME         = var.connect_rest_advertised_host_name
    CONNECT_SASL_JAAS_CONFIG                  = var.connect_sasl_jaas_config
    CONNECT_SASL_MECHANISM                    = var.connect_sasl_mechanism
    CONNECT_SASL_PASSWORD                     = var.connect_sasl_password
    CONNECT_SASL_USERNAME                     = var.connect_sasl_username
    CONNECT_SCHEMA_REGISTRY_URL               = var.connect_schema_registry_url
    CONNECT_SECURITY_PROTOCOL                 = var.connect_security_protocol
    CONNECT_STATUS_STORAGE_TOPIC              = var.connect_status_storage_topic
    CONNECT_VALUE_CONVERTER                   = var.connect_value_converter
    WEBSITE_HTTPLOGGING_RETENTION_DAYS        = var.website_httplogging_retention_days
    WEBSITES_ENABLE_APP_SERVICE_STORAGE       = var.websites_enable_app_service_storage
 }
}