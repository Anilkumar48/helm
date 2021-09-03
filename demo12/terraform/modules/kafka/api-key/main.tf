# Teragrunt automate script to create/remove Confluent Kafka API Key

terraform {
  required_providers {
    restapi = {
      source  = "fmontezuma/restapi"
      version = ">= 1.14.1"
    }
  }
}

provider "restapi" {
  uri = local.kafka_root_path
  write_returns_object = true
  #create_method = "PUT"
  #update_method = "PUT"
  insecure = true
  headers = {
    Authorization = local.kafka_api_key
  }
}

variable kafka_cluster_id {}
variable kafka_cluster_rest_url {} 

locals {
  kafka_root_path = "https://confluent.cloud/api/api_keys/"
  kafka_api_key = "Bearer eyJhbGciOiJSUzI1NiIsImprdSI6Imh0dHBzOi8vYXV0aC1zdGF0aWMuY29uZmx1ZW50LmlvL2p3a3MiLCJraWQiOiIxMjc5ZDg4My1kNjBhLTExZWItOTZlMC0xMjZiOTk2MmM4YjAiLCJ0eXAiOiJKV1QifQ.eyJvcmdhbml6YXRpb25JZCI6NTUzMDUsIm9yZ1Jlc291cmNlSWQiOiI4MmQ5ZWU5ZC1hNDJlLTQ3YzktOWRmNS1hYjczMjI3MWFhN2IiLCJ1c2VySWQiOjI1NjIzNCwidXNlclJlc291cmNlSWQiOiJ1LTR5bjFuayIsImV4cCI6MTYyOTE0NzUyOCwianRpIjoiZWRjNTAwNjgtN2ZiNy00ZjUzLWJjNGEtNTlkMjVkYmRiOGUyIiwiaWF0IjoxNjI5MTQzOTI4LCJpc3MiOiJDb25mbHVlbnQiLCJzdWIiOiJ1LTR5bjFuayJ9.yMIcC2TvWhTSKVde0KuNUNaK41SKvj5PgkuiQWhYWwXEuHyaXbFVQfJS8H46olPpz0MXdH86PJkO28ITZnnJZGmsPElbeWEjcFotoPrsBzQP8bR3fpm9QRXyv2qE5XKW0x1jeSvC53dPbp1H1C6AcDm7KbnnS8TbNcmXlA1XaPZCw3hsaAI05k3mKyItF4kpD1vfD_VUco5_1wCTRs2DAGmGfGPAtc8bOlW_2aX6307KExq9_3cLJ_hhAj5pANy8fpFL27UwLB_q0s5E2tf_Tl_hGFSNtKxDqfXKx57IPT8gizavzMy9AnigFd4Y0FvcQ-ak5mNWLFr3UFDTBcGpDA"
}

resource "restapi_object" "tpg_kafka_apikey" {  

  path = ""
  #object_id = "ayan_test_api_postman"
  read_path = "${local.kafka_root_path}"
  destroy_path = "${local.kafka_root_path}"
  data = jsonencode({ 
    apiKey: {
      description: "ayan_test_api_postman"
      logicalClusters: [
        {
            id: "lkc-pvw6y"
            type: "kafka"
        }]
        accountId: "env-p3nk2"
    }
  })  
}