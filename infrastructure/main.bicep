@description('Location for all resources.')
param location string = resourceGroup().location

module api 'api/main.bicep' = {
  name: 'api'
  params: {
    workload: 'h4api'
    location: location
  }
}

// module notifier 'notifier/main.bicep' = {
//   name: 'notifier'
//   params: {
//     workload: 'notifier'
//     location: location
//     apiUrl: 'todo' //api.outputs.url
//   }
// }

module batcher 'batcher/main.bicep' = {
  name: 'batcher'
  params: {
    workload: 'batcher'
    location: location
  }
}

