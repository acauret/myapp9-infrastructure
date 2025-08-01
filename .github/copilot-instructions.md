# GitHub Copilot Instructions - myapp9 Infrastructure

## Project Overview
This repository contains Azure infrastructure as code for myapp9 using Bicep and Azure Developer CLI (azd).

## Azure MCP Server Integration

When implementing infrastructure from issues, use the Azure MCP Server to discover existing resources:

### MCP Commands for Infrastructure Discovery

**Basic Discovery:**
- @azure list resources - List all resources in subscription
- @azure find resources type:Microsoft.Storage/storageAccounts - Find specific resource types
- @azure get resource /subscriptions/.../resourceGroups/.../providers/... - Get resource details

**Infrastructure Analysis:**
- @azure analyze infrastructure - Complete infrastructure analysis
- @azure find naming-patterns - Discover naming conventions from existing resources
- @azure get resource-dependencies {resourceId} - Find resource dependencies

**Cost Analysis:**
- @azure costs current month - Get current month costs
- @azure costs by resource-group - Breakdown by resource group
- @azure suggest cost-optimizations - Get optimization recommendations

**Integration Helpers:**
- @azure get connection-string {resourceName} - Get connection strings
- @azure list secrets {keyVaultName} - List Key Vault secrets
- @azure test connectivity {source} {target} - Test connectivity between resources

### Implementation Workflow with MCP

1. **Discover Existing Infrastructure**
   - Use MCP to list all resources
   - Identify naming patterns
   - Find existing resource groups, networks, monitoring

2. **Analyze Before Creating**
   - Check if similar resources exist
   - Understand current architecture
   - Identify integration points

3. **Create Consistent Infrastructure**
   - Follow discovered naming patterns
   - Use same locations and tags
   - Integrate with existing monitoring and networking

4. **Validate Integration**
   - Test connectivity to existing resources
   - Verify RBAC permissions
   - Check monitoring data flow

## Key Principles
1. **Always use Azure Verified Modules (AVM)** from https://aka.ms/avm
2. **Use MCP to discover existing patterns** before creating new resources
3. **Never hardcode secrets** - use Key Vault references
4. **Use managed identities** instead of connection strings where possible
5. **Enable private endpoints** for production environments
6. **Include diagnostic settings** for all resources

## Project Structure
- /infra/main.bicep - Main infrastructure entry point
- /infra/modules/ - Custom Bicep modules
- /environments/ - Environment-specific parameters
- /.github/workflows/ - CI/CD pipelines

## Naming Conventions
Discover from existing resources using: @azure find naming-patterns

Common patterns:
- Resource Groups: rg-{project}-{environment}
- Key Vaults: kv-{project}-{env}-{unique}
- Storage Accounts: st{project}{env}{unique}
- Container Apps: ca-{component}-{project}-{env}

## When Implementing Infrastructure

### Adding a New Service
1. First use MCP to discover: @azure list resources type:{service-type}
2. Check for existing AVM module at https://aka.ms/avm
3. Create module in /infra/modules/ if custom logic needed
4. Add to main.bicep with proper dependencies
5. Update parameter files
6. Configure RBAC assignments
7. Add diagnostic settings
8. Document outputs

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
- Use @azure analyze cost-optimization to find savings
- Use appropriate SKUs per environment
- Implement auto-shutdown for non-production
- Enable lifecycle policies for storage
- Right-size compute resources
- Use reserved instances for production

---
Updated on 2025-08-01 by update-azure-project.ps1
