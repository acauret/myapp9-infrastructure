# Setup Instructions for myapp9 Infrastructure

## Next Steps

### 1. Install Prerequisites

#### Azure CLI

Windows (PowerShell as Administrator):

    # Download and install
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi
    Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'
    Remove-Item .\AzureCLI.msi

Or using winget:

    winget install -e --id Microsoft.AzureCLI

#### Azure Developer CLI (azd)

Windows (PowerShell as Administrator):

    powershell -ex AllSigned -c "Invoke-RestMethod 'https://aka.ms/install-azd.ps1' | Invoke-Expression"

Or using winget:

    winget install microsoft.azd

#### GitHub CLI (optional but recommended)

Windows:

    winget install --id GitHub.cli

Or download from https://cli.github.com/

### 2. Azure Setup

#### Login to Azure

    az login
    az account list --output table
    az account set --subscription "YOUR-SUBSCRIPTION-NAME"

#### Create Service Principal

    # Set variables
    $subscriptionId = az account show --query id -o tsv
    $spName = "sp-myapp9-github"

    # Create SP with Contributor role
    $sp = az ad sp create-for-rbac `
        --name $spName `
        --role contributor `
        --scopes /subscriptions/$subscriptionId `
        --sdk-auth

    # Display the output
    Write-Host $sp -ForegroundColor Yellow
    Write-Host "Save this JSON output for GitHub Secrets!" -ForegroundColor Red

### 3. GitHub Repository Setup

#### Create and Push Repository

    # Initialize git
    git init
    git add .
    git commit -m "Initial infrastructure setup"

    # Create GitHub repo (using gh CLI)
    gh repo create acauret/myapp9-infrastructure --public --source=. --remote=origin --push

    # Or manually create on GitHub and push
    git remote add origin https://github.com/acauret/myapp9-infrastructure.git
    git branch -M main
    git push -u origin main

#### Configure GitHub Secrets

1. Go to: https://github.com/acauret/myapp9-infrastructure/settings/secrets/actions
2. Add these secrets:
   - AZURE_CLIENT_ID: From service principal output
   - AZURE_TENANT_ID: From service principal output
   - AZURE_SUBSCRIPTION_ID: From az account show --query id -o tsv

### 4. Local Development Setup

#### Configure Azure Developer CLI

    # Login to Azure
    azd auth login

    # Initialize environment
    azd env new development
    azd env set AZURE_LOCATION eastus
    azd env set AZURE_SUBSCRIPTION_ID (az account show --query id -o tsv)

### 5. Create Infrastructure Issues

#### Using GitHub CLI

    # Create your first infrastructure issue
    gh issue create `
        --title "[INFRA] Add Container Registry" `
        --label "infrastructure,copilot-workspace" `
        --body "See issue template for details"

#### Or use the web interface

1. Go to: https://github.com/acauret/myapp9-infrastructure/issues/new/choose
2. Select "Infrastructure Request"
3. Fill in the details

### 6. Deploy Infrastructure

#### Using GitHub Actions

    # Push to main branch triggers deployment
    git push origin main

#### Using Azure Developer CLI

    # Deploy to development
    azd up --environment development

    # Preview changes
    azd provision --preview --environment development

## Resources

- [Azure Verified Modules](https://aka.ms/avm)
- [Bicep Documentation](https://learn.microsoft.com/azure/azure-resource-manager/bicep/)
- [Azure Developer CLI](https://learn.microsoft.com/azure/developer/azure-developer-cli/)
- [GitHub Actions for Azure](https://github.com/Azure/actions)

## Troubleshooting

Run the setup checklist:

    .\scripts\setup-checklist.ps1

This will verify all prerequisites are installed and configured correctly.