@description('Location for all resources.')
param location string = resourceGroup().location

@description('The name of the workload.')
param workload string

resource storageAccount6 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'sa${workload}${uniqueString(resourceGroup().id)}'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    supportsHttpsTrafficOnly: true
  }
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2021-06-01' = {
  parent: storageAccount6
  name: 'default'
}

resource storageContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  name: 'raw'
  parent: blobService
  properties: {
  }
}
