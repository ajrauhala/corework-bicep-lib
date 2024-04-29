param location string = resourceGroup().location
param name string
@allowed([
'Standard_LRS'
'Standard_GRS'
'Standard_RAGRS'
'Standard_ZRS'
'Premium_LRS'
'Premium_ZRS'
'Standard_GZRS'
'Standard_RAGZRS'
])
param sku string = 'Standard_LRS'
 
resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  kind: 'StorageV2'
  location: location
  name: name
  properties: {
    allowBlobPublicAccess: false
    encryption: {
      requireInfrastructureEncryption: true
    }
    isHnsEnabled: false
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }
  sku: {
    name: sku
  }
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  name: 'default'
  parent: storageAccount
}

output storageAccount object = storageAccount
