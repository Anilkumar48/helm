# TODO: register schema as [topic-name]-value. Create topic to schema assignment and if it doesn't exist register with filename
# Setup schema registry environment for kafka
terraform {
  required_providers {
    restapi = {
      source  = "fmontezuma/restapi"
      version = ">= 1.14.1"
    }
  }
}

variable kafka_schema_registry_url {} 
variable kafka_schema_registry_rest_auth {}
variable kafka_topic_prefix {}

provider "restapi" {
  uri = var.kafka_schema_registry_url
  write_returns_object = true
  insecure = true
  headers = {
      Authorization = var.kafka_schema_registry_rest_auth
  }
}

locals {
  clean_up = "///.*|\ufeff|\r\n|\n|\t/"
  proto_path = "Tap-GoldenGate-Models/protos"
  prefix = var.kafka_topic_prefix
}

# regex is magical! :) clean up files
# setup dependencies
resource "restapi_object" "timestamp_proto" {
  path = "/subjects/google%2Fprotobuf%2Ftimestamp.proto/versions"
  data = jsonencode({ 
    schema: replace(data.local_file.timestamp_proto.content, local.clean_up, " "), 
    schemaType: "PROTOBUF" 
  })
  read_path = "/subjects/google%2Fprotobuf%2Ftimestamp.proto/versions/latest"
}

resource "restapi_object" "audit_proto" {
  path = "/subjects/audit.proto/versions"
  data = jsonencode({ 
    schema: replace(data.local_file.audit_proto.content, local.clean_up, " "), 
    schemaType: "PROTOBUF",
    references: [
      { 
        name: "google/protobuf/timestamp.proto", 
        subject: lookup(jsondecode(data.http.timestamp_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.timestamp_proto_latest.body), "version")
      }
    ]
  })
  read_path = "/subjects/audit.proto/versions/latest"
  depends_on = [
    data.http.timestamp_proto_latest
  ]
}

resource "restapi_object" "netpayinput_proto" {
  path = "/subjects/netpayinput.proto/versions"
  data = jsonencode({
    schema: replace(data.local_file.netpayinput_proto.content, local.clean_up, " "),
    schemaType: "PROTOBUF",
    references: [
      { 
        name: "google/protobuf/timestamp.proto", 
        subject: lookup(jsondecode(data.http.timestamp_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.timestamp_proto_latest.body), "version")
      }
    ]
  })
  read_path = "/subjects/netpayinput.proto/versions/latest"
  depends_on = [
    data.http.timestamp_proto_latest
  ]
}

resource "restapi_object" "taxinput_proto" {
  path = "/subjects/taxinput.proto/versions"
  data = jsonencode({ 
    schema: replace(data.local_file.taxinput_proto.content, local.clean_up, " "),
    schemaType: "PROTOBUF"
  })
  read_path = "/subjects/taxinput.proto/versions/latest"
}

resource "restapi_object" "wadinput_proto" {
  path = "/subjects/wadinput.proto/versions"
  data = jsonencode({ 
    schema: replace(data.local_file.wadinput_proto.content, local.clean_up, " "), 
    schemaType: "PROTOBUF" 
  })
  read_path = "/subjects/wadinput.proto/versions/latest"
}

resource "restapi_object" "payroll_proto" {
  path = "/subjects/payroll.proto/versions"
  data = jsonencode({ 
    schema: replace(data.local_file.payroll_proto.content, local.clean_up, " "),
    schemaType: "PROTOBUF",
    references: [
      { 
        name: "google/protobuf/timestamp.proto", 
        subject: lookup(jsondecode(data.http.timestamp_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.timestamp_proto_latest.body), "version")
      }
    ]
  })
  read_path = "/subjects/payroll.proto/versions/latest"
  depends_on = [
    data.http.timestamp_proto_latest
  ]
}

resource "restapi_object" "legalentity_proto" {
  path = "/subjects/legalentity.proto/versions"
  data = jsonencode({ 
    schema: replace(data.local_file.legalentity_proto.content, local.clean_up, " "),
    schemaType: "PROTOBUF"
  })
  read_path = "/subjects/legalentity.proto/versions/latest"
}

resource "restapi_object" "employee_proto" {
  path = "/subjects/employee.proto/versions"
  data = jsonencode({
    schema: replace(data.local_file.employee_proto.content, local.clean_up, " "), 
    schemaType: "PROTOBUF" 
  })
  read_path = "/subjects/employee.proto/versions/latest"
}

resource "restapi_object" "tpginput_proto_stage" {
  path = "/subjects/${local.prefix}tpg.input.stage-value/versions"
  data = jsonencode({ 
    schema: replace(data.local_file.tpginput_proto.content, local.clean_up, " "), 
    schemaType: "PROTOBUF",
    references: [
      {
        name = "netpayinput.proto"
        subject: lookup(jsondecode(data.http.netpayinput_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.netpayinput_proto_latest.body), "version")
      },
      {
        name = "taxinput.proto"
        subject: lookup(jsondecode(data.http.taxinput_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.taxinput_proto_latest.body), "version")
      },
      {
        name = "wadinput.proto"
        subject: lookup(jsondecode(data.http.wadinput_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.wadinput_proto_latest.body), "version")
      },
      {
        name = "payroll.proto"
        subject: lookup(jsondecode(data.http.payroll_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.payroll_proto_latest.body), "version")
      },
      {
        name = "legalentity.proto"
        subject: lookup(jsondecode(data.http.legalentity_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.legalentity_proto_latest.body), "version")
      },
      {
        name = "employee.proto"
        subject: lookup(jsondecode(data.http.employee_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.employee_proto_latest.body), "version")
      },
      {
        name = "audit.proto"
        subject: lookup(jsondecode(data.http.audit_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.audit_proto_latest.body), "version")
      }
    ]
  })
  read_path = "/subjects/${local.prefix}tpg.input.stage-value/versions/latest"
  depends_on = [
    data.http.audit_proto_latest,
    data.http.netpayinput_proto_latest,
    data.http.taxinput_proto_latest,
    data.http.wadinput_proto_latest,
    data.http.payroll_proto_latest,
    data.http.legalentity_proto_latest,
    data.http.employee_proto_latest
  ]
}

resource "restapi_object" "tpginput_proto" {
  path = "/subjects/${local.prefix}tpg.input-value/versions"
  data = jsonencode({ 
    schema: replace(data.local_file.tpginput_proto.content, local.clean_up, " "), 
    schemaType: "PROTOBUF",
    references: [
      {
        name = "netpayinput.proto"
        subject: lookup(jsondecode(data.http.netpayinput_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.netpayinput_proto_latest.body), "version")
      },
      {
        name = "taxinput.proto"
        subject: lookup(jsondecode(data.http.taxinput_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.taxinput_proto_latest.body), "version")
      },
      {
        name = "wadinput.proto"
        subject: lookup(jsondecode(data.http.wadinput_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.wadinput_proto_latest.body), "version")
      },
      {
        name = "payroll.proto"
        subject: lookup(jsondecode(data.http.payroll_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.payroll_proto_latest.body), "version")
      },
      {
        name = "legalentity.proto"
        subject: lookup(jsondecode(data.http.legalentity_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.legalentity_proto_latest.body), "version")
      },
      {
        name = "employee.proto"
        subject: lookup(jsondecode(data.http.employee_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.employee_proto_latest.body), "version")
      },
      {
        name = "audit.proto"
        subject: lookup(jsondecode(data.http.audit_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.audit_proto_latest.body), "version")
      }
    ]
  })
  read_path = "/subjects/${local.prefix}tpg.input-value/versions/latest"
  depends_on = [
    data.http.audit_proto_latest,
    data.http.netpayinput_proto_latest,
    data.http.taxinput_proto_latest,
    data.http.wadinput_proto_latest,
    data.http.payroll_proto_latest,
    data.http.legalentity_proto_latest,
    data.http.employee_proto_latest
  ]
}

# output
resource "restapi_object" "processingstatus_proto" {
  path = "/subjects/processingstatus.proto/versions"
  data = jsonencode({ 
    schema: replace(data.local_file.processingstatus_proto.content, local.clean_up, " "), 
    schemaType: "PROTOBUF" 
  })
  read_path = "/subjects/processingstatus.proto/versions/latest"
}

resource "restapi_object" "netpayoutput_proto" {
  path = "/subjects/${local.prefix}tpg.netpay.output-value/versions"
  data = jsonencode({ 
    schema: replace(data.local_file.netpayoutput_proto.content, local.clean_up, " "), 
    schemaType: "PROTOBUF",
    references: [
      {
        name = "audit.proto"
        subject: lookup(jsondecode(data.http.audit_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.audit_proto_latest.body), "version")
      },
      {
        name = "processingstatus.proto"
        subject: lookup(jsondecode(data.http.processingstatus_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.processingstatus_proto_latest.body), "version")
      }
    ]
  })
  read_path = "/subjects/${local.prefix}netpay.output-value/versions/latest"
  depends_on = [
    data.http.audit_proto_latest,
    data.http.processingstatus_proto_latest
  ]
}

resource "restapi_object" "netpayoutput_proto_standalone" {
  path = "/subjects/${local.prefix}netpayoutput.proto/versions"
  data = jsonencode({ 
    schema: replace(data.local_file.netpayoutput_proto.content, local.clean_up, " "), 
    schemaType: "PROTOBUF",
    references: [
      {
        name = "audit.proto"
        subject: lookup(jsondecode(data.http.audit_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.audit_proto_latest.body), "version")
      },
      {
        name = "processingstatus.proto"
        subject: lookup(jsondecode(data.http.processingstatus_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.processingstatus_proto_latest.body), "version")
      }
    ]
  })
  read_path = "/subjects/netpayoutput.proto/versions/latest"
  depends_on = [
    data.http.audit_proto_latest,
    data.http.processingstatus_proto_latest
  ]
}

resource "restapi_object" "taxoutput_proto" {
  path = "/subjects/${local.prefix}tpg.tax.output-value/versions"
  data = jsonencode({ 
    schema: replace(data.local_file.taxoutput_proto.content, local.clean_up, " "), 
    schemaType: "PROTOBUF",
    references: [
      {
        name = "audit.proto"
        subject: lookup(jsondecode(data.http.audit_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.audit_proto_latest.body), "version")
      }
    ]
  })
  read_path = "/subjects/${local.prefix}tax.output-value/versions/latest"
  depends_on = [
    data.http.audit_proto_latest
  ]
}

resource "restapi_object" "taxoutput_proto_standalone" {
  path = "/subjects/taxoutput.proto/versions"
  data = jsonencode({ 
    schema: replace(data.local_file.taxoutput_proto.content, local.clean_up, " "), 
    schemaType: "PROTOBUF",
    references: [
      {
        name = "audit.proto"
        subject: lookup(jsondecode(data.http.audit_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.audit_proto_latest.body), "version")
      }
    ]
  })
  read_path = "/subjects/${local.prefix}taxoutput.proto/versions/latest"
  depends_on = [
    data.http.audit_proto_latest
  ]
}

resource "restapi_object" "wadoutput_proto" {
  path = "/subjects/${local.prefix}tpg.wad.output-value/versions"
  data = jsonencode({
    schema: replace(data.local_file.wadoutput_proto.content, local.clean_up, " "),
    schemaType: "PROTOBUF",
    references: [
      {
        name = "audit.proto"
        subject: lookup(jsondecode(data.http.audit_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.audit_proto_latest.body), "version")
      },
      {
        name = "google/protobuf/timestamp.proto"
        subject: lookup(jsondecode(data.http.timestamp_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.timestamp_proto_latest.body), "version")
      }
    ]
  })
  read_path = "/subjects/${local.prefix}wad.output-value/versions/latest"
  depends_on = [
    data.http.audit_proto_latest,
    data.http.processingstatus_proto_latest
  ]
}

resource "restapi_object" "wadoutput_proto_standalone" {
  path = "/subjects/wadoutput.proto/versions"
  data = jsonencode({
    schema: replace(data.local_file.wadoutput_proto.content, local.clean_up, " "),
    schemaType: "PROTOBUF",
    references: [
      {
        name = "audit.proto"
        subject: lookup(jsondecode(data.http.audit_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.audit_proto_latest.body), "version")
      },
      {
        name = "google/protobuf/timestamp.proto"
        subject: lookup(jsondecode(data.http.timestamp_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.timestamp_proto_latest.body), "version")
      }
    ]
  })
  read_path = "/subjects/${local.prefix}wadoutput.proto/versions/latest"
  depends_on = [
    data.http.audit_proto_latest,
    data.http.timestamp_proto_latest
  ]
}

resource "restapi_object" "tpgoutput_proto" {
  path = "/subjects/${local.prefix}tpg.output-value/versions"
  data = jsonencode({ 
    schema: replace(data.local_file.tpgoutput_proto.content, local.clean_up, " "), 
    schemaType: "PROTOBUF",
    references: [
      {
        name = "netpayoutput.proto"
        subject: lookup(jsondecode(data.http.netpayoutput_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.netpayoutput_proto_latest.body), "version")
      },
      {
        name = "taxoutput.proto"
        subject: lookup(jsondecode(data.http.taxoutput_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.taxoutput_proto_latest.body), "version")
      },
      {
        name = "tpginput.proto"
        subject: lookup(jsondecode(data.http.tpginput_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.tpginput_proto_latest.body), "version")
      },
      {
        name = "wadoutput.proto"
        subject: lookup(jsondecode(data.http.wadoutput_proto_latest.body), "subject"), 
        version: lookup(jsondecode(data.http.wadoutput_proto_latest.body), "version")
      }
    ]
  })
  read_path = "/subjects/${local.prefix}tpg.output-value/versions/latest"
  depends_on = [
    data.http.netpayoutput_proto_latest,
    data.http.taxoutput_proto_latest,
    data.http.wadoutput_proto_latest,
    data.http.tpginput_proto_latest
  ]
}
