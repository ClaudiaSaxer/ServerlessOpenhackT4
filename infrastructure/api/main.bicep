@description('Location for all resources.')
param location string = resourceGroup().location

@description('The name of the workload.')
param workload string

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: 'log-${workload}-${uniqueString(resourceGroup().id)}'
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
  }
  tags: {
    workload: workload
  }
}

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: 'appi-${workload}-${uniqueString(resourceGroup().id)}'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: workspace.id
  }
  tags: {
    workload: workload
  }
}

module database 'database.bicep' = {
  name: 'database'
  params: {
    workload: workload
    location: location
  }
}

module functions 'function.bicep' = {
  name: 'function'
  params: {
    workload: workload
    location: location
    databaseAccountName: database.outputs.databaseAccountName
    applicationInsightsName: applicationInsights.name
  }
}

// module management 'management.bicep' = {
//   name: 'management'
//   params: {
//     service_bfyoc_api_04_name: 'apim-${workload}-${uniqueString(resourceGroup().id)}'
//     operations_641b00bf9108c5f28ed7d564_type: 'null'
//     operations_641b010c3649f1e3d4a7d286_type: 'null'
//     operations_641b010cd9e2fc5c0070bb0d_type: 'null'
//     operations_641b010d9d4467e1651b1e5f_type: 'null'
//     operations_641b012e539d950096fc3b8e_type: 'null'
//     operations_get_getrating_type: 'null'
//     operations_get_getratings_type: 'null'
//     operations_get_user_type: 'null'
//     subscriptions_641ad1fff0021e004e070001_displayName: 'null'
//     subscriptions_641ad1fff0021e004e070002_displayName: 'null'
//     subscriptions_641af34a463461148c9450dd_displayName: 'null'
//     subscriptions_641af375463461148c9450e0_displayName: 'null'
//     subscriptions_641af387463461148c9450e3_displayName: 'null'
//     users_1_lastName: 'null'
//     functionAppName: functions.outputs.appName
//     location: location
//   }
// }

output url string = functions.outputs.url
