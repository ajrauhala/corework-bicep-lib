
var magicString = '87u234'
var appServicePlanName = 'myapp-appserviceplan'
var storageAccountName = 'myappstorage${magicString}'
var functionAppName = 'myapp-function-${magicString}'

module appServicePlanModule 'br:acrdevopscore2024.azurecr.io/bicep/modules/app-service-plan:v1' = {
  name: 'appServicePlanModule'
  params: {
    name: appServicePlanName
    os: 'linux'
  }
}

module storageModule 'br:acrdevopscore2024.azurecr.io/bicep/modules/storage-account:v1' = {
  name: 'storageModule'
  params: {
    name: storageAccountName
    sku: 'Standard_LRS'
  }
}

module functionAppModule 'br:acrdevopscore2024.azurecr.io/bicep/modules/function-app:v1' = {
  dependsOn: [
    appServicePlanModule
    storageModule
  ]
  name: 'functionAppModule'
  params: {
    name: functionAppName
    appServicePlanName: appServicePlanName
    storageAccountName: storageAccountName
  }
}
