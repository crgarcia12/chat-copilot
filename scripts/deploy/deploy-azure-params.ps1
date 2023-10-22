$params = @{
    DeploymentName      = "crgar-copilot"
    ResourceGroup       = "crgar-copilot-rg"
    Region              = "westEurope"
    Subscription        = "14506188-80f8-4dc6-9b28-250051fc4ee4"
    AIService           = "AzureOpenAI"
    AIApiKey            = "9e109b9266b0496d990f194144a4fad4"
    AIEndpoint          = "https://crgar-openai-openai.openai.azure.com/"
    SqlAdminPassword    = ConvertTo-SecureString -AsPlainText "P@ssword123123" -Force
    ApplicationClientId = "03b21685-be01-45ad-a13d-56db43b86f2f"
}

$env:AIService = "AzureOpenAI"
$env:AIApiKey = "9e109b9266b0496d990f194144a4fad4"
$env:AIEndpoint = "https//crgar-openai-openai.openai.azure.com/"
$env:ClientId = "03b21685-be01-45ad-a13d-56db43b86f2f"

.\Configure.ps1 -AIService $env:AIService -APIKey $env:AIApiKey -Endpoint $env:AIEndpoint -ClientId $env:ClientId
.\Start.ps1

###### NOTICE THAT PROBABLY ONLY LOCALHOST:3000 will work. 127.0.0.1 not because it is not a redirect url (it requires SSL)

./deploy-azure.ps1 @params -DebugDeployment

./package-webapi.ps1 -BuildConfiguration Debug
./deploy-webapi.ps1 `
    -Subscription $params.Subscription `
    -ResourceGroupName $params.ResourceGroup `
    -DeploymentName $params.DeploymentName

./deploy-webapp.ps1 `
    -Subscription $params.Subscription `
    -ResourceGroupName $params.ResourceGroup `
    -DeploymentName $params.DeploymentName `
    -ApplicationClientId $params.ApplicationClientId