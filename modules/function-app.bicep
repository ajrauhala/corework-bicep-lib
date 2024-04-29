param name string
param location string = resourceGroup().location
@description('Function app language worker runtime. Defaults to dotnet.')
@allowed([
  'dotnet'
  'dotnet-isolated'
  'java'
  'node'
  'powershell'
  'python'
  'custom'
])
param functionAppRuntime string = 'dotnet'
@description('name of the storage account to be used as function app storage.')
param storageAccountName string
@description('Name of the hosting plan hosting the function app.')
param appServicePlanName string

resource storageAccountObject 'Microsoft.Storage/storageAccounts@2022-09-01' existing = {
  name: storageAccountName
}

resource appServicePlanObject 'Microsoft.Web/serverfarms@2022-09-01' existing  = {
  name: appServicePlanName
}

var storageConnStr = 'DefaultEndpointsProtocol=https;AccountName=${storageAccountObject.name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${storageAccountObject.listKeys().keys[0].value}'
resource functionApp 'Microsoft.Web/sites@2023-01-01' = {
  identity: {
    type: 'SystemAssigned'
  }
  kind: 'functionapp'
  location: location
  name: name
  properties: {
    httpsOnly: true
    serverFarmId: appServicePlanObject.id
    siteConfig: {
      alwaysOn: true
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: storageConnStr
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: functionAppRuntime
        }
      ]
      ftpsState: 'FtpsOnly'
      minTlsVersion: '1.2'
      netFrameworkVersion: '8'
      publicNetworkAccess: 'Enabled'
      vnetRouteAllEnabled: true
    }
    vnetContentShareEnabled: false
  }
}



output functionApp object = functionApp
