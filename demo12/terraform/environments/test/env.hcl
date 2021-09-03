locals {
    cluster_api_key = "UXH34HJ26OVY5GJR"
    cluster_api_secret = "xl4gkJfTScgBQPHlYGUnr3EdqpwZBPQS5jFKFvx1BqcMOAAw21a8gDzH9ivBn2q7"
    schema_registry_api_key = "CXXUIYFGHDW76B2H"
    schema_registry_api_secret = "PATuuHKjKUqa/Mgv3pKZIMK+OkDeVi8tlmlU165ZrO1aep+ESnmzIaXxskIdv+F9"
    cluster_id = "lkc-pvw6y"
    cnet_connector_url = "https://app501-tpg-connector1.app501-tps-ase01.ceridian.com"
    schema_registry_url = "https://psrc-pg3n2.westus2.azure.confluent.cloud"
    bootstrap_server = "pkc-epwny.eastus.azure.confluent.cloud:9092"
    cluster_url = "https://pkac-4x6qq.eastus.azure.confluent.cloud"
    ase_uri = "https://app501-tpg-connector1.app501-tps-ase01.ceridian.com"
}

inputs = {
    k8_replicas = 1
    k8_namespace = "tpg-terra"
    cnet_connector_url = local.cnet_connector_url
    kafka_topic_prefix = "dev2"
    kafka_cluster_rest_auth = join(" ", ["Basic", base64encode(join(":", [local.cluster_api_key, local.cluster_api_secret]))])
    kafka_cluster_rest_url = local.cluster_url
    kafka_bootstrap_servers = local.bootstrap_server
    kafka_schema_registry_url = local.schema_registry_url
    kafka_schema_registry_rest_auth = join(" ", ["Basic", base64encode(join(":", [local.schema_registry_api_key, local.schema_registry_api_secret]))])
    kafka_cluster_id = "${local.cluster_id}"
    kafka_security_protocol = "SASL_SSL"
    kafka_sasl_jaas_config = "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"${local.cluster_api_key}\" password=\"${local.cluster_api_secret}\";"
    kafka_ssl_endpoint_identification_algorithm = "https"
    kafka_sasl_mechanism = "PLAIN"
    kafka_client_bootstrap_servers = local.bootstrap_server
    kafka_client_security_protocol = "SASL_SSL"
    kafka_client_sasl_jaas_config = "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"${local.cluster_api_key}\" password=\"${local.cluster_api_secret}\";"
    kafka_client_ssl_endpoint_identification_algorithm = "https"
    kafka_client_sasl_mechanism = "PLAIN"
    kafka_client_basic_auth_credentials_source = "USER_INFO"
    kafka_client_basic_auth_user_info = "${local.cluster_api_key}:${local.cluster_api_secret}"
    ase_uri = local.ase_uri
}