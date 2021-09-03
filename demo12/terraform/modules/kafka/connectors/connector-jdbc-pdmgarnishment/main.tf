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

resource "restapi_object" "tpg-kafka-connect-pdmgarnishment-jdbc-test" {
  path         = "/connectors/tpg-kafka-connect-pdmgarnishment-jdbc-test/config"
  debug        = true
  id_attribute = "name"
  create_method = "put"
  read_path = "/connectors/tpg-kafka-connect-pdmgarnishment-jdbc-test"
  destroy_path = "/connectors/tpg-kafka-connect-pdmgarnishment-jdbc-test"
  data = jsonencode({
      "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
        "incrementing.column.name": "Wage_Id",
        "connection.password": "Chang3m3S00n",
        "basic.auth.credentials.source": "USER_INFO",
        "query": "SELECT * FROM ( SELECT TR.Transaction_Request_id 'TransactionRequestId', W.Wage_Id, W.Wage_Id as 'MessageId',TR.Collector_Id AS 'CollectorId', TH.Client_Key 'ClientPSID',C.Client_Id 'CNETClientID', CONVERT(datetime2, TH.Check_Date) as 'PayDate', TH.Payroll_Control_Id 'PayrollControlId', E.Employee_Unique_ID 'EmpUniqueId',E.Ssn 'SSN', E.First_Name 'FirstName', E.Last_Name 'LastName', W.Case_Number 'CaseNumber', W.Lien_Type 'LienType', W.Wage_Order_Amt 'WageOrderAmout', W.Is_Medical_Support 'MedicalSupportInd', W.Payroll_Method 'PayrollMethod', W.Payroll_Type 'PayrollType', W.Issuing_Court_State 'IssuingCourtState', W.Obligee_Last_Name 'ObligeeLastName', W.Payee_Code 'PayeeCode', W.Payee_Name 'PayeeName', W.Address1 'Address1', W.Address2 'Address2', W.City 'City', W.[State] 'State', W.Zip_Code 'ZipCode', W.Zip_Ext 'ZipExt', W.EMPLOYER_FEIN 'EmployerFEIN', W.Frequency 'WADFrequency' FROM Transaction_Request TR inner join Transaction_Header TH on TR.Transaction_Request_Id = TH.Transaction_Request_Id and TR.File_Frequency = 'P' and TR.Status_Code_ID in ( 112,117) inner join Wage W on TH.Transaction_Header_Id = W.Transaction_Header_Id inner join Client C on TR.Collector_id = C.pr_coll_id and TH.Client_Key = C.pr_coll_clientid inner join Employee E on W.Employee_Id = E.Employee_Id Order By W.Wage_Id desc ) A",
        "value.converter.basic.auth.credentials.source": "USER_INFO",
        "mode": "incrementing",
        "schema.registry.url": "https://psrc-gq7pv.westus2.azure.confluent.cloud",
        "value.converter.schema.registry.url": "https://psrc-gq7pv.westus2.azure.confluent.cloud",
        "topic.prefix": "dev.tpg.wad.input.stage",
        "basic.auth.user.info": "HSQ2SXTUJ3YVARKU:+bsG2mogl1n8Bq6y3slwBz7bKt0EFxR6yW0eIi9ZS9/11wbUIghzw0vaynjiGcXm",
        "value.converter.basic.auth.user.info": "HSQ2SXTUJ3YVARKU:+bsG2mogl1n8Bq6y3slwBz7bKt0EFxR6yW0eIi9ZS9/11wbUIghzw0vaynjiGcXm",
        "connection.user": "TaxNextGenUser",
        "poll.interval.ms": "5000",
        "name": "tpg-kafka-connect-pdmgarnishment-jdbc-test",
        "numeric.mapping": "best_fit",
        "connection.url": "jdbc:sqlserver://app501-tps-sqlg.database.windows.net;instance=.;databaseName=app501-tng-QARTS-db-NextGen-MDB-1;ApplicationIntent=ReadOnly;selectMethod=cursor;",
        "value.converter": "io.confluent.connect.protobuf.ProtobufConverter",
        "key.converter": "org.apache.kafka.connect.storage.StringConverter"
    }
  )
}


