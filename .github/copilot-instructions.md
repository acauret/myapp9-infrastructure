# GitHub Copilot Instructions - ' + $ProjectName + ' Infrastructure

## Project Overview
This repository contains Azure infrastructure as code for ' + $ProjectName + ' using Bicep and Azure Developer CLI (azd).

## Key Principles
1. **Always use Azure Verified Modules (AVM)** from https://aka.ms/avm
2. **Never hardcode secrets** - use Key Vault references
3. **Use managed identities** instead of connection strings where possible
4. **Enable private endpoints** for production environments
5. **Include diagnostic settings** for all resources

## Project Structure
- /infra/main.bicep - Main infrastructure entry point
- /infra/modules/ - Custom Bicep modules
- /environments/ - Environment-specific parameters
- /.github/workflows/ - CI/CD pipelines

## Naming Conventions
- Resource Groups: rg-{project}-{environment}
- Key Vaults: kv-{project}-{env}-{unique}
- Storage Accounts: st{project}{env}{unique}
- Container Apps: ca-{component}-{project}-{env}

## When Implementing Infrastructure

### Adding a New Service
1. Check for existing AVM module at https://aka.ms/avm
2. Create module in /infra/modules/ if custom logic needed
3. Add to main.bicep with proper dependencies
4. Update parameter files
5. Configure RBAC assignments
6. Add diagnostic settings
7. Document outputs

### Example Module Structure
```bicep
// Use descriptive parameters
@description(''The name of the resource'')
param name string

@description(''The location of the resource'')  
param location string

@description(''Resource tags'')
param tags object = {}

// Use AVM
module resourceName ''br/public:avm/res/{provider}/{type}:{version}'' = {
  name: ''deploy-{resourceType}''
  params: {
    name: name
    location: location
    tags: tags
  }
}

// Always output key values
output resourceId string = resourceName.outputs.resourceId
output name string = resourceName.outputs.name
```

## Common AVM Modules
- Resource Group: br/public:avm/res/resources/resource-group:0.4.0
- Storage Account: br/public:avm/res/storage/storage-account:0.15.0
- Key Vault: br/public:avm/res/key-vault/vault:0.11.0
- Container Registry: br/public:avm/res/container-registry/registry:0.6.0

## Security Requirements
- Enable diagnostic logs for all resources
- Use private endpoints for data services
- Implement least-privilege RBAC
- Enable soft delete for Key Vault
- Use customer-managed keys where applicable

## Cost Optimization
- Use appropriate SKUs per environment
- Implement auto-shutdown for non-production
- Enable lifecycle policies for storage
- Right-size compute resources
- Use reserved instances for production
