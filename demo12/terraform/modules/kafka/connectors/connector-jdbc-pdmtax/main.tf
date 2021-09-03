## To do update 
terraform {
  required_providers {
    restapi = {
      source  = "fmontezuma/restapi"
      version = ">= 1.14.1"
    }
  }
}

# variable schema_registry_url {} 
# variable authorization {}



provider "restapi" {
  uri                  = "http://localhost:8083"
  write_returns_object = true
  insecure             = true
  headers = {
    Content-Type = "application/json"
  }
}

resource "restapi_object" "tpg-kafka-connect-pdmtax-jdbc-test" {
  path         = "/connectors/tpg-kafka-connect-pdmtax-jdbc-test/config"
  debug        = true
  id_attribute = "name"
  create_method = "put"
  read_path = "/connectors/tpg-kafka-connect-pdmtax-jdbc-test"
  destroy_path = "/connectors/tpg-kafka-connect-pdmtax-jdbc-test"
  data = jsonencode({
      "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
        "incrementing.column.name": "Transaction_Periodic_Detail_Id",
        "connection.password": "Chang3m3S00n",
        "basic.auth.credentials.source": "USER_INFO",
        "query": "Select * from (SELECT  TR.Transaction_Request_id AS 'TransactionRequestId', TPD.Transaction_Periodic_Detail_Id, TPD.Transaction_Periodic_Detail_Id as 'MessageId', TR.Collector_Id AS 'CollectorId', TH.Client_Key AS 'ClientPSID', C.Client_Id AS 'CNETClientID', CONVERT(datetime2, TH.Check_Date) as PayDate, TH.Payroll_Control_Id AS 'PayrollControlId', TP.Check_Number as 'CheckNum', E.Employee_Unique_ID as 'EmpUniqueId', E.Ssn as 'SSN', E.First_Name as 'FirstName', E.Last_Name as 'LastName',TPD.Amount_Type_Id as 'AmountType', A.Name as 'AmountTypeDesc',TPD.CTS_Tax_Code as 'CTSTaxCode', TPD.Periodic_Amount as 'PeriodicAmount', TPD.Quarterly_Amount as 'QTDAmount', TPD.Yearly_Amount as 'YTDAmount' FROM Transaction_Request TR inner join Transaction_Header TH on TR.Transaction_Request_Id = TH.Transaction_Request_Id and TR.File_Frequency = 'P' and TR.Status_Code_ID = 112 inner join Transaction_Periodic TP on TH.Transaction_Header_Id = TP.Transaction_Header_Id inner join Transaction_Periodic_Detail TPD on TP.Transaction_Periodic_id = TPD.Transaction_Periodic_Id inner join Client C on TR.Collector_id = C.pr_coll_id and TH.Client_Key = C.pr_coll_clientid inner join Employee E on TP.Employee_Id = E.Employee_Id inner join Amount_Type A on TPD.Amount_Type_Id = A.Amount_Type_Id) A",
        "value.converter.basic.auth.credentials.source": "USER_INFO",
        "mode": "incrementing",
        "schema.registry.url": "https://psrc-gq7pv.westus2.azure.confluent.cloud",
        "value.converter.schema.registry.url": "https://psrc-gq7pv.westus2.azure.confluent.cloud",
        "topic.prefix": "dev.tpg.tax.input.stage",
        "basic.auth.user.info": "HSQ2SXTUJ3YVARKU:+bsG2mogl1n8Bq6y3slwBz7bKt0EFxR6yW0eIi9ZS9/11wbUIghzw0vaynjiGcXm",
        "value.converter.basic.auth.user.info": "HSQ2SXTUJ3YVARKU:+bsG2mogl1n8Bq6y3slwBz7bKt0EFxR6yW0eIi9ZS9/11wbUIghzw0vaynjiGcXm",
        "connection.user": "TaxNextGenUser",
        "poll.interval.ms": "5000",
        "name": "tpg-kafka-connect-pdmtax-jdbc-test",
        "numeric.mapping": "best_fit",
        "connection.url": "jdbc:sqlserver://app501-tps-sqlg.database.windows.net;instance=.;databaseName=app501-tng-QARTS-db-NextGen-MDB-1;ApplicationIntent=ReadOnly;selectMethod=cursor;",
        "value.converter": "io.confluent.connect.protobuf.ProtobufConverter",
        "key.converter": "org.apache.kafka.connect.storage.StringConverter"
    }
  )
}


