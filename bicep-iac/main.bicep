targetScope = 'resourceGroup'

@description('Name of the Azure region')
param location string = resourceGroup().location

@description('Name of the storage account')
param storageAccountName string

@description('Name of the blob container')
param containerName string = 'data'

@description('Storage account SKU')
param storageSku string = 'Standard_LRS'

var storageKind = 'StorageV2'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location

  sku: {
    name: storageSku
  }

  kind: storageKind

  // Tags help identify and manage the resource
  tags: {
    student: 'pes1pg25ca134-mritunjai'
    environment: 'development'
    project: 'bicep-iac'
  }

  properties: {
    accessTier: 'Hot'
  }
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  name: 'default'
  parent: storageAccount
}

resource blobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  name: containerName
  parent: blobService
  properties: {
    publicAccess: 'None'
  }
}

output storageAccountName string = storageAccount.name
output storageAccountLocation string = storageAccount.location
output blobContainerName string = blobContainer.name
output storageAccountNameOutput string = storageAccount.name
output storageAccountId string = storageAccount.id
output containerNameOutput string = blobContainer.name
