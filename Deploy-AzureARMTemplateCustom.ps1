# PreReq: Install-Module -Name Az -AllowClobber -Scope CurrentUser
# Deploy-AzureARMTemplate - Quick boiler plate for deploying a pre-existing template on an existing resource group using interactive logon

[CmdletBinding()]
param (
    [Parameter()]
    [String]
    $ResourceGroupName,
    [Parameter()]
    [String]
    $TemplateFilePath,
    [Parameter()]
    [String]
    $ParameterFilePath,
    [Parameter()]
    [String]
    $location = "westus2",
    [Parameter()]
    [String]
    $ComputerName

)

#Connect interactively to subscription
$ARMContext =    Get-AzContext -ErrorAction Continue
if (-not $ARMContext){
    Connect-AzAccount
} else {
    Write-Output $ARMContext
}

$networkInterfaceName = "$ComputerName-NIC"
$publicIpAddressName = "$ComputerName-IP"
$networkSecurityGroupName = "$ComputerName-NSG"
$diagnosticsStorageAccountName = $ResourceGroupName.ToLower() + "sa"
$diagnosticsStorageAccountId = "Microsoft.Storage/storageAccounts/$diagnosticsStorageAccountName"

New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateFile $TemplateFilePath -TemplateParameterFile $ParameterFilePath `
 -networkInterfaceName $networkInterfaceName -networkSecurityGroupName $networkSecurityGroupName -publicIPAddressName $publicIpAddressName `
 -virtualMachineName $ComputerName -diagnosticsStorageAccountName $diagnosticsStorageAccountName -diagnosticsStorageAccountId $diagnosticsStorageAccountId -DeploymentDebugLogLevel All