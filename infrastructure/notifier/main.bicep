@description('Location for all resources.')
param location string = resourceGroup().location

@description('The name of the workload.')
param workload string

param apiUrl string

module logicApp 'logic.bicep' = {
  name: 'logic-app'
  params: {
    workflows_logic_hack4_c5_name: 'logic-${workload}-${uniqueString(resourceGroup().id)}'
    location: location
    api_url: apiUrl
    dynamics_url: '' // TODO
  }
}
