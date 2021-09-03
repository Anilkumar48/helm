include {
  path = find_in_parent_folders()
}

terraform {
    source = "../../../..//modules/kafka/schema-registry"
}

inputs = {
}