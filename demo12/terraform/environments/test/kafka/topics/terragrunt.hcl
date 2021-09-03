include {
  path = find_in_parent_folders()
}

terraform {
    source = "../../../..//modules/kafka/topics"
}

inputs = {
  # kafka_topics_names = toset( ["tpg.input", "tpg.wad.input.stage"] ) # No need to override here, it will come from modules
  # num_partitions = 6  # default is 6, uncomment same to override
  # replication_factor = 3 # default is 3, uncomment same to override
}