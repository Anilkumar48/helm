dependency "environment" {
  config_path = "../environment"
  skip_outputs = true
}

include {
  path = find_in_parent_folders()
}

terraform {
    source = "../../../..//modules/kubernetes/kafka-rest"
}

dependencies {
  paths = ["../environment"]
}