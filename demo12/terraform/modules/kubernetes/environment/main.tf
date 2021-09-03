# Setup kubernetes environment for microservices
terraform {
    required_providers {
        kubernetes = {
            source  = "hashicorp/kubernetes"
            version = ">= 2.0.1"
        }
    }
}

locals {
  namespace = "${var.env_name}-${var.k8_namespace}"
}

provider "kubernetes" {
    config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "tpg" {
    metadata {
        name = local.namespace
    }
}

resource "kubernetes_config_map" "kafka" {
    metadata {
        name = "kafka"
        namespace = local.tpg_k8_namespace
    }

    data = {
        bootstrap_servers = var.kafka_bootstrap_servers
        security_protocol = var.kafka_security_protocol
        sasl_jaas_config = var.kafka_sasl_jaas_config
        ssl_endpoint_identification_algorithm = var.kafka_ssl_endpoint_identification_algorithm
        sasl_mechanism = var.kafka_ssl_endpoint_identification_algorithm
        client_bootstrap_servers = var.kafka_client_bootstrap_servers
        client_security_protocol = var.kafka_client_security_protocol
        client_ssl_endpoint_identification_algorithm = var.kafka_client_ssl_endpoint_identification_algorithm
        client_sasl_mechanism = var.kafka_client_sasl_mechanism
        client_basic_auth_credentials_source = var.kafka_client_basic_auth_credentials_source
        schema_registry_url = var.kafka_schema_registry_url
        topic_prefix = var.kafka_topic_prefix
    }
    
    depends_on = [
        kubernetes_namespace.tpg
    ]
}

resource "kubernetes_secret" "kafka" {
    metadata {
        name = "kafka"
        namespace = local.tpg_k8_namespace
    }

    binary_data = {
        client_sasl_jaas_config = var.kafka_client_sasl_jaas_config
        basic_auth_user_info = "${var.kafka_client_basic_auth_user_info}"
    }

    depends_on = [
        kubernetes_namespace.tpg
    ]
}