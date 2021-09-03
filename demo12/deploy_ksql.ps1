
Write-Host "Start to build the docker image"

$KUBERNETES_CLUSTER_NAMES = $env:KUBE_CLUSTER_NAMES.Split(",")
$RESOURCE_GROUPS = $env:RGS.Split(",")
if($KUBERNETES_CLUSTER_NAMES.count -eq $RESOURCE_GROUPS.count)
{
    for ($i=0; $i -lt $RESOURCE_GROUPS.count; $i++)
    {
        $env:CLUSTER_NAME=$KUBERNETES_CLUSTER_NAMES[$i]
        $env:RESOURCE_GROUP=$RESOURCE_GROUPS[$i]
        Write-Output ($env:RESOURCE_GROUP +"----"+ $env:CLUSTER_NAME)
        
        Set-Location $PSScriptRoot
        docker build -f DockerfileKsql -t ksqldeploy . `
            --build-arg SP_USER=$env:SP_USER `
            --build-arg SP_PASS=$env:SP_PASS `
            --build-arg SP_TENANT=$env:SP_TENANT `
            --build-arg SP_SUBSCRIPTION=$env:SP_SUBSCRIPTION `
            --build-arg KAFKA_USER=$env:KAFKA_USER `
            --build-arg RESOURCE_GROUP_NAME=$env:RESOURCE_GROUP `
            --build-arg KUBERNETES_CLUSTER_NAME=$env:CLUSTER_NAME `
            --build-arg NAMESPACE=$env:NAMESPACE `
            --build-arg KSQL_SERVICEID=$env:KSQL_SERVICEID `
            --build-arg SCHEMAREGISTRY_URL=$env:SCHEMAREGISTRY_URL `
            --build-arg KSQL_SECURITY_PROTOCOL=$env:KSQL_SECURITY_PROTOCOL `
            --build-arg BOOTSTRAPSERVERS=$env:BOOTSTRAPSERVERS `
            --build-arg KSQL_QUERIES_CONFIGMAP=$env:KSQL_QUERIES_CONFIGMAP
    }
    $KEY_VALUES="KSQL_SERVICEID=" + $env:KSQL_SERVICEID + ", SCHEMAREGISTRY_URL=" + $env:SCHEMAREGISTRY_URL + ", KSQL_SECURITY_PROTOCOL=" + $env:KSQL_SECURITY_PROTOCOL + ", BOOTSTRAPSERVERS=" + $env:BOOTSTRAPSERVERS + ", KSQL_QUERIES_CONFIGMAP=" + $env:KSQL_QUERIES_CONFIGMAP
    Write-Output $KEY_VALUES
    Write-Host "deploy_ksql.ps1 done"
}
else
{
    Write-Error "Incorrect KUBERNETES_CLUSTER_NAMES and RESOURCE_GROUPS parameter configuration "
}
