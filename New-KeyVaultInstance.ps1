# Use ARM Template, but some specifics to KeyVault to capture - ie. Register KeyVault

Register-AzResourceProvider -ProviderNamespace 'Microsoft.KeyVault'

New-AzResourceGroup -Name ExampleGroup -Location centralus
New-AzKeyVault `
  -VaultName ExampleVault `
  -resourceGroupName ExampleGroup `
  -Location centralus `
  -EnabledForTemplateDeployment
  
$secretvalue = ConvertTo-SecureString 'redacted' -AsPlainText -Force
$secret = Set-AzKeyVaultSecret -VaultName ExampleVault -Name 'ExamplePassword' -SecretValue $secretvalue