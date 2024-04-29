param location string = resourceGroup().location
param name string
@allowed([
  'windows'
  'linux'
])
param os string = 'linux'
param sku object = {
  name: 'S2'
  tier: 'Standard'
}
param zoneRedundant bool = false

resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  kind:os
  location: location
  name: name
  properties: {
    zoneRedundant: zoneRedundant
    reserved: os == 'linux'
  }
  sku: {
    name: sku.name
    tier: sku.tier
  }

}

output appServicePlan object = appServicePlan
