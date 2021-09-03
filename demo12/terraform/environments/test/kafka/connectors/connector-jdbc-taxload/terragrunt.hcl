include {
  path = find_in_parent_folders()
}

terraform {
    source = "../../../../..//modules/kafka/connectors/connector-jdbc-taxload"
}

inputs = {

    connection_password = "TPGU_qa1"
    topic_prefix = "dev.tpg.taxload.output.stage"
    basic_auth_user_info = "HSQ2SXTUJ3YVARKU:+bsG2mogl1n8Bq6y3slwBz7bKt0EFxR6yW0eIi9ZS9/11wbUIghzw0vaynjiGcXm"
    value_converter_basic_auth_user_info = "HSQ2SXTUJ3YVARKU:+bsG2mogl1n8Bq6y3slwBz7bKt0EFxR6yW0eIi9ZS9/11wbUIghzw0vaynjiGcXm"
    connection_user = "TPG_USER"
    connection_url = "jdbc:oracle:thin:@cnetctsqa.corpadds.com:1521/ctsqa.fvcsts.cescom"

}