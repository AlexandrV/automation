$subscriptionName = "BlueCielo-NextGen-CI"    
$location = "westeurope"

try
{
    Get-AzureRmContext | Out-Null
}
catch
{
    Login-AzureRmAccount | Out-Null
}

$subscription = Select-AzureRmSubscription -SubscriptionName $subscriptionName
Write-Host ("Using subscription '{0}'" -f $subscription.Subscription.SubscriptionName)

$resourceGroupName = "testazurefunctions"
$resourceGroup = New-AzureRmResourceGroup `
                    -Name $resourceGroupName `
                    -Location $location `
                    -Force

Write-Host ("Created resourcegroup '{0}'" -f $resourceGroup.ResourceGroupName)

$TemplateFileName = "deploy.json"
$TemplateFile = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($PSScriptRoot, $TemplateFileName))

$templateParameterObject = @{ 
   
}

$result = New-AzureRmResourceGroupDeployment `
            -Name "master" `
            -ResourceGroupName $resourceGroupName `
            -TemplateFile $TemplateFile `
            -TemplateParameterObject $templateParameterObject `
            -Verbose -Force
