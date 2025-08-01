targetScope = 'subscription'

// ========== Parameters ==========
@minLength(1)
@maxLength(64)
@description('Name of the environment')
param environmentName string

@minLength(1)
@description('Primary location for all resources')
param location string

@description('Name of the project')
param projectName string

// ========== Variables ==========
var resourceToken = toLower(uniqueString(subscription().id, environmentName, location))
var tags = {
  'azd-env-name': environmentName
  Project: projectName
  Environment: environmentName
  DeploymentType: 'bicep'
}

// ========== Resources ==========

// Resource Group
module rg 'br/public:avm/res/resources/resource-group:0.4.0' = {
  name: 'resourceGroup'
  params: {
    name: 'rg-${projectName}-${environmentName}'
    location: location
    tags: tags
  }
}

// Add more resources here using Azure Verified Modules (AVM)
// See: https://aka.ms/avm

// ========== Outputs ==========
output resourceGroupName string = rg.outputs.name
output location string = location
output environmentName string = environmentName
