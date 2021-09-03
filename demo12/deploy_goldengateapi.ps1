
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
        docker build -f DockerfileGoldenGateApi -t goldengateapideploy . `
            --build-arg SP_USER=$env:SP_USER `
            --build-arg SP_PASS=$env:SP_PASS `
            --build-arg SP_TENANT=$env:SP_TENANT `
            --build-arg SP_SUBSCRIPTION=$env:SP_SUBSCRIPTION `
            --build-arg KAFKA_USER=$env:KAFKA_USER `
            --build-arg RESOURCE_GROUP_NAME=$env:RESOURCE_GROUP `
            --build-arg KUBERNETES_CLUSTER_NAME=$env:CLUSTER_NAME `
            --build-arg ACR=$env:ACR `
            --build-arg NAMESPACE=$env:NAMESPACE `
            --build-arg BUILD_NUMBER=$env:BUILD_NUMBER `
            --build-arg APPINSIGHTSINSTRUMENTATIONKEY=$env:APPINSIGHTSINSTRUMENTATIONKEY `
            --build-arg DEPLOYEMNTENV=$env:DEPLOYEMNTENV `
            --build-arg DNS_LOCATION=$env:DNS_LOCATION `
            --build-arg DNS_NAME=$env:DNS_NAME `
            --build-arg ROUTEPREFIX=$env:ROUTEPREFIX `
            --build-arg DFID_URL=$env:DFID_URL `
            --build-arg TOPICNAME=$env:TOPICNAME `
            --build-arg SCHEMAREGISTRY_URL=$env:SCHEMAREGISTRY_URL `
            --build-arg BOOTSTRAPSERVERS=$env:BOOTSTRAPSERVERS `
            --build-arg KAFKA_SASL_PASSWORD=$env:KAFKA_SASL_PASSWORD `
            --build-arg CONFLUENTCLOUDSECRET=$env:CONFLUENTCLOUDSECRET
    }
    $KEY_VALUES="BUILD_NUMBER=" + $env:BUILD_NUMBER + ", DEPLOYEMNTENV=" + $env:DEPLOYEMNTENV + ", DNS_LOCATION=" + $env:DNS_LOCATION + ", DNS_NAME=" + $env:DNS_NAME + ", DFID_URL=" + $env:DFID_URL + ", CONFLUENTCLOUDSECRET=" + $env:CONFLUENTCLOUDSECRET
    Write-Output $KEY_VALUES
    Write-Host "deploy_goldengateapi.ps1 done"
}
else
{
    Write-Error "Incorrect KUBERNETES_CLUSTER_NAMES and RESOURCE_GROUPS parameter configuration "
}
