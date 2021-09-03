data "local_file" "timestamp_proto" {
    filename = "${path.module}/${local.proto_path}/timestamp.proto"
}

data "local_file" "audit_proto" {
    filename = "${path.module}/${local.proto_path}/audit.proto"
}

data "local_file" "netpayinput_proto" {
    filename = "${path.module}/${local.proto_path}/netpayinput.proto"
}

data "local_file" "taxinput_proto" {
    filename = "${path.module}/${local.proto_path}/taxinput.proto"
}

data "local_file" "wadinput_proto" {
    filename = "${path.module}/${local.proto_path}/wadinput.proto"
}

data "local_file" "payroll_proto" {
    filename = "${path.module}/${local.proto_path}/payroll.proto"
}

data "local_file" "legalentity_proto" {
    filename = "${path.module}/${local.proto_path}/legalentity.proto"
}

data "local_file" "employee_proto" {
    filename = "${path.module}/${local.proto_path}/employee.proto"
}

data "local_file" "tpginput_proto" {
    filename = "${path.module}/${local.proto_path}/tpginput.proto"
}

data "local_file" "netpayoutput_proto" {
    filename = "${path.module}/${local.proto_path}/netpayoutput.proto"
}

data "local_file" "processingstatus_proto" {
    filename = "${path.module}/${local.proto_path}/processingstatus.proto"
}

data "local_file" "taxoutput_proto" {
    filename = "${path.module}/${local.proto_path}/taxoutput.proto"
}

data "local_file" "wadoutput_proto" {
    filename = "${path.module}/${local.proto_path}/wadoutput.proto"
}

data "local_file" "tpgoutput_proto" {
    filename = "${path.module}/${local.proto_path}/tpgoutput.proto"
}

data "local_file" "timestmap_proto" {
    filename = "${path.module}/${local.proto_path}/timestamp.proto"
}

data "http" "timestamp_proto_latest" {
  url = "${var.kafka_schema_registry_url}/subjects/google%2Fprotobuf%2Ftimestamp.proto/versions/latest"
  request_headers = {
    Authorization = var.kafka_schema_registry_rest_auth
    Accept = "application/json"
  }
  depends_on = [
    restapi_object.timestamp_proto
  ]
}

data "http" "audit_proto_latest" {
  url = "${var.kafka_schema_registry_url}/subjects/audit.proto/versions/latest"

  request_headers = {
    Authorization = var.kafka_schema_registry_rest_auth
    Accept = "application/json"
  }

  depends_on = [
    restapi_object.audit_proto
  ]
}

data "http" "netpayinput_proto_latest" {
  url = "${var.kafka_schema_registry_url}/subjects/netpayinput.proto/versions/latest"

  request_headers = {
    Authorization = var.kafka_schema_registry_rest_auth
    Accept = "application/json"
  }

  depends_on = [
    restapi_object.netpayinput_proto
  ]
}

data "http" "taxinput_proto_latest" {
  url = "${var.kafka_schema_registry_url}/subjects/taxinput.proto/versions/latest"

  request_headers = {
    Authorization = var.kafka_schema_registry_rest_auth
    Accept = "application/json"
  }

  depends_on = [
    restapi_object.taxinput_proto
  ]
}

data "http" "wadinput_proto_latest" {
  url = "${var.kafka_schema_registry_url}/subjects/wadinput.proto/versions/latest"

  request_headers = {
    Authorization = var.kafka_schema_registry_rest_auth
    Accept = "application/json"
  }

  depends_on = [
    restapi_object.wadinput_proto
  ]
}

data "http" "payroll_proto_latest" {
  url = "${var.kafka_schema_registry_url}/subjects/payroll.proto/versions/latest"

  request_headers = {
    Authorization = var.kafka_schema_registry_rest_auth
    Accept = "application/json"
  }

  depends_on = [
    restapi_object.payroll_proto
  ]
}

data "http" "legalentity_proto_latest" {
  url = "${var.kafka_schema_registry_url}/subjects/legalentity.proto/versions/latest"

  request_headers = {
    Authorization = var.kafka_schema_registry_rest_auth
    Accept = "application/json"
  }

  depends_on = [
    restapi_object.legalentity_proto
  ]
}

data "http" "employee_proto_latest" {
  url = "${var.kafka_schema_registry_url}/subjects/employee.proto/versions/latest"

  request_headers = {
    Authorization = var.kafka_schema_registry_rest_auth
    Accept = "application/json"
  }

  depends_on = [
    restapi_object.employee_proto
  ]
}

data "http" "tpginput_proto_latest" {
  url = "${var.kafka_schema_registry_url}/subjects/${local.prefix}tpg.input.stage-value/versions/latest"

  request_headers = {
    Authorization = var.kafka_schema_registry_rest_auth
    Accept = "application/json"
  }

  depends_on = [
    restapi_object.tpginput_proto
  ]
}

data "http" "processingstatus_proto_latest" {
  url = "${var.kafka_schema_registry_url}/subjects/processingstatus.proto/versions/latest"

  request_headers = {
    Authorization = var.kafka_schema_registry_rest_auth
    Accept = "application/json"
  }

  depends_on = [
    restapi_object.processingstatus_proto
  ]
}

data "http" "netpayoutput_proto_latest" {
  url = "${var.kafka_schema_registry_url}/subjects/${local.prefix}tpg.netpay.output-value/versions/latest"

  request_headers = {
    Authorization = var.kafka_schema_registry_rest_auth
    Accept = "application/json"
  }

  depends_on = [
    restapi_object.processingstatus_proto,
    restapi_object.audit_proto,
    restapi_object.netpayoutput_proto
  ]
}

data "http" "taxoutput_proto_latest" {
  url = "${var.kafka_schema_registry_url}/subjects/${local.prefix}tpg.tax.output-value/versions/latest"

  request_headers = {
    Authorization = var.kafka_schema_registry_rest_auth
    Accept = "application/json"
  }

  depends_on = [
    restapi_object.audit_proto,
    restapi_object.taxoutput_proto
  ]
}

data "http" "wadoutput_proto_latest" {
  url = "${var.kafka_schema_registry_url}/subjects/${local.prefix}tpg.wad.output-value/versions/latest"

  request_headers = {
    Authorization = var.kafka_schema_registry_rest_auth
    Accept = "application/json"
  }

  depends_on = [
    restapi_object.processingstatus_proto,
    restapi_object.audit_proto,
    restapi_object.wadoutput_proto
  ]
}