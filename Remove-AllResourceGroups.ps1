# Clean up script
# Remove all Resource Groups from test collection

# Install AzureRM cmdlets

#Connect interactively (check if existing connection)
[CmdletBinding()]
param (
    [Parameter()]
    [String]
    $SubscriptionId
)

$ARMContext =    Get-AzureRmContext -ErrorAction Continue
if (-not $ARMContext){

    Connect-AzureRmAccount
    if ($Subscription){
        Select-AzureRmSubscription $SubscriptionId
    } 
} else {
    Write-Output $ARMContext
}


#Get all resource groups
$ResourceGroups = Get-AzureRmResourceGroup | Select-Object -ExpandProperty ResourceGroupName

#Remove-RMResourceGroup 

foreach ($rg in $ResourceGroups){
    Remove-AzureRmResourceGroup -name $rg
}