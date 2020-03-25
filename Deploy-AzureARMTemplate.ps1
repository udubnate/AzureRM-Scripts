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
    $ParameterFilePath
)

#Connect interactively to subscription
$ARMContext =    Get-AzContext -ErrorAction Continue
if (-not $ARMContext){
    Connect-AzAccount
} else {
    Write-Output $ARMContext
}


New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateFile $TemplateFilePath -TemplateParameterFile $ParameterFilePath  -DeploymentDebugLogLevel All