
@description('Location for all resources.')
param location string = resourceGroup().location

param functionAppName string

@secure()
param operations_641b010c3649f1e3d4a7d286_type string

@secure()
param operations_641b010cd9e2fc5c0070bb0d_type string

@secure()
param operations_641b010d9d4467e1651b1e5f_type string

@secure()
param operations_641b012e539d950096fc3b8e_type string

@secure()
param operations_641b00bf9108c5f28ed7d564_type string

@secure()
param operations_get_getrating_type string

@secure()
param operations_get_getratings_type string

@secure()
param operations_get_user_type string

@secure()
param subscriptions_641ad1fff0021e004e070001_displayName string

@secure()
param subscriptions_641ad1fff0021e004e070002_displayName string

@secure()
param subscriptions_641af34a463461148c9450dd_displayName string

@secure()
param subscriptions_641af375463461148c9450e0_displayName string

@secure()
param subscriptions_641af387463461148c9450e3_displayName string

@secure()
param users_1_lastName string
param service_bfyoc_api_04_name string = 'bfyoc-api-04'
param components_appi_bfyoc_04_externalid string = '/subscriptions/c268b76f-4165-4b3b-8e2a-a585b336bcc0/resourceGroups/ServerlessOpenHackRG04-westeurope/providers/microsoft.insights/components/appi-bfyoc-04'

// resource apiManagement 'Microsoft.ApiManagement/service@2022-08-01' = {
//   name: 'apim-${workload}-${uniqueString(resourceGroup().id)}'
//   location: location
//   sku: {
//     capacity: 0
//     name: 'Consumption'
//   }
//   identity: {
//     type: 'SystemAssigned'
//   }
//   properties: {
//     publisherEmail: publisherEmail
//     publisherName: 'OpenHack Team 4'
//   }
// }

// resource applicationInsights 'Microsoft.Insights/components@2020-02-02' existing = {
//   name: applicationInsightsName
// }

// resource apiManagementLogger 'Microsoft.ApiManagement/service/loggers@2020-12-01' = {
//   name: applicationInsightsName
//   parent: apiManagement
//   properties: {
//     loggerType: 'applicationInsights'
//     description: 'Logger resources to APIM'
//     credentials: {
//       instrumentationKey: applicationInsights.properties.InstrumentationKey
//     }
//   }
// }

resource service_bfyoc_api_04_name_resource 'Microsoft.ApiManagement/service@2022-08-01' = {
  name: service_bfyoc_api_04_name
  location: location
  sku: {
    name: 'Consumption'
    capacity: 0
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    publisherEmail: 'info@example.com'
    publisherName: 'BFYOC'
    notificationSenderEmail: 'apimgmt-noreply@mail.windowsazure.com'
    hostnameConfigurations: [
      {
        type: 'Proxy'
        hostName: '${service_bfyoc_api_04_name}.azure-api.net'
        negotiateClientCertificate: false
        defaultSslBinding: true
        certificateSource: 'BuiltIn'
      }
    ]
    virtualNetworkType: 'None'
    disableGateway: false
    natGatewayState: 'Disabled'
    apiVersionConstraint: {}
    publicNetworkAccess: 'Enabled'
  }
}

// resource service_bfyoc_api_04_name_641b010bfe2c001d7fb3fe6f 'Microsoft.ApiManagement/service/apis@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: '641b010bfe2c001d7fb3fe6f'
//   properties: {
//     displayName: 'Internal API'
//     apiRevision: '1'
//     description: 'Import from "func-hack4-c2" Function App'
//     subscriptionRequired: true
//     path: 'internal'
//     protocols: [
//       'https'
//     ]
//     authenticationSettings: {
//       oAuth2AuthenticationSettings: []
//       openidAuthenticationSettings: []
//     }
//     subscriptionKeyParameterNames: {
//       header: 'Ocp-Apim-Subscription-Key'
//       query: 'subscription-key'
//     }
//     isCurrent: true
//   }
// }

// resource service_bfyoc_api_04_name_641b012ccf94bd7109a11fed 'Microsoft.ApiManagement/service/apis@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: '641b012ccf94bd7109a11fed'
//   properties: {
//     displayName: 'External API'
//     apiRevision: '1'
//     description: 'Import from "func-hack4-c2" Function App'
//     subscriptionRequired: true
//     path: 'external'
//     protocols: [
//       'https'
//     ]
//     authenticationSettings: {
//       oAuth2AuthenticationSettings: []
//       openidAuthenticationSettings: []
//     }
//     subscriptionKeyParameterNames: {
//       header: 'Ocp-Apim-Subscription-Key'
//       query: 'subscription-key'
//     }
//     isCurrent: true
//   }
// }

// resource service_bfyoc_api_04_name_func_hack4_c2 'Microsoft.ApiManagement/service/apis@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'func-hack4-c2'
//   properties: {
//     displayName: 'Mobile API'
//     apiRevision: '1'
//     description: 'Import from "func-hack4-c2" Function App'
//     subscriptionRequired: true
//     path: 'mobile'
//     protocols: [
//       'https'
//     ]
//     authenticationSettings: {
//       oAuth2AuthenticationSettings: []
//       openidAuthenticationSettings: []
//     }
//     subscriptionKeyParameterNames: {
//       header: 'Ocp-Apim-Subscription-Key'
//       query: 'subscription-key'
//     }
//     isCurrent: true
//   }
// }

// resource functionApp 'Microsoft.Web/sites@2021-03-01' existing = {
//   name: functionAppName
// }

// resource Microsoft_ApiManagement_service_backends_service_bfyoc_api_04_name_func_hack4_c2 'Microsoft.ApiManagement/service/backends@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: functionApp.name
//   properties: {
//     description: functionApp.name
//     url: 'https://${functionApp.name}.azurewebsites.net/api'
//     protocol: 'http'
//     resourceId: functionApp.id
//     credentials: {
//       header: {
//         'x-functions-key': [
//           '{{${functionApp.name}-key}}'
//         ]
//       }
//     }
//   }
// }

// resource service_bfyoc_api_04_name_administrators 'Microsoft.ApiManagement/service/groups@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'administrators'
//   properties: {
//     displayName: 'Administrators'
//     description: 'Administrators is a built-in group containing the admin email account provided at the time of service creation. Its membership is managed by the system.'
//     type: 'system'
//   }
// }

// resource service_bfyoc_api_04_name_developers 'Microsoft.ApiManagement/service/groups@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'developers'
//   properties: {
//     displayName: 'Developers'
//     description: 'Developers is a built-in group. Its membership is managed by the system. Signed-in users fall into this group.'
//     type: 'system'
//   }
// }

// resource service_bfyoc_api_04_name_guests 'Microsoft.ApiManagement/service/groups@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'guests'
//   properties: {
//     displayName: 'Guests'
//     description: 'Guests is a built-in group. Its membership is managed by the system. Unauthenticated users visiting the developer portal fall into this group.'
//     type: 'system'
//   }
// }

// resource service_bfyoc_api_04_name_appi_bfyoc_04 'Microsoft.ApiManagement/service/loggers@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'appi-bfyoc-04'
//   properties: {
//     loggerType: 'applicationInsights'
//     credentials: {
//       instrumentationKey: '{{Logger-Credentials--641ae08f463461148c9450d5}}'
//     }
//     isBuffered: true
//     resourceId: components_appi_bfyoc_04_externalid
//   }
// }

// resource service_bfyoc_api_04_name_641ae08f463461148c9450d4 'Microsoft.ApiManagement/service/namedValues@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: '641ae08f463461148c9450d4'
//   properties: {
//     displayName: 'Logger-Credentials--641ae08f463461148c9450d5'
//     secret: true
//   }
// }

// resource service_bfyoc_api_04_name_func_hack4_c2_key 'Microsoft.ApiManagement/service/namedValues@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'func-hack4-c2-key'
//   properties: {
//     displayName: 'func-hack4-c2-key'
//     tags: [
//       'key'
//       'function'
//       'auto'
//     ]
//     secret: true
//   }
// }

// resource service_bfyoc_api_04_name_AccountClosedPublisher 'Microsoft.ApiManagement/service/notifications@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'AccountClosedPublisher'
// }

// resource service_bfyoc_api_04_name_BCC 'Microsoft.ApiManagement/service/notifications@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'BCC'
// }

// resource service_bfyoc_api_04_name_NewApplicationNotificationMessage 'Microsoft.ApiManagement/service/notifications@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'NewApplicationNotificationMessage'
// }

// resource service_bfyoc_api_04_name_NewIssuePublisherNotificationMessage 'Microsoft.ApiManagement/service/notifications@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'NewIssuePublisherNotificationMessage'
// }

// resource service_bfyoc_api_04_name_PurchasePublisherNotificationMessage 'Microsoft.ApiManagement/service/notifications@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'PurchasePublisherNotificationMessage'
// }

// resource service_bfyoc_api_04_name_QuotaLimitApproachingPublisherNotificationMessage 'Microsoft.ApiManagement/service/notifications@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'QuotaLimitApproachingPublisherNotificationMessage'
// }

// resource service_bfyoc_api_04_name_RequestPublisherNotificationMessage 'Microsoft.ApiManagement/service/notifications@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'RequestPublisherNotificationMessage'
// }

// resource service_bfyoc_api_04_name_policy 'Microsoft.ApiManagement/service/policies@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'policy'
//   properties: {
//     value: '<!--\r\n    IMPORTANT:\r\n    - Policy elements can appear only within the <inbound>, <outbound>, <backend> section elements.\r\n    - Only the <forward-request> policy element can appear within the <backend> section element.\r\n    - To apply a policy to the incoming request (before it is forwarded to the backend service), place a corresponding policy element within the <inbound> section element.\r\n    - To apply a policy to the outgoing response (before it is sent back to the caller), place a corresponding policy element within the <outbound> section element.\r\n    - To add a policy position the cursor at the desired insertion point and click on the round button associated with the policy.\r\n    - To remove a policy, delete the corresponding policy statement from the policy document.\r\n    - Policies are applied in the order of their appearance, from the top down.\r\n-->\r\n<policies>\r\n  <inbound />\r\n  <backend>\r\n    <forward-request />\r\n  </backend>\r\n  <outbound />\r\n</policies>'
//     format: 'xml'
//   }
// }

// resource service_bfyoc_api_04_name_default 'Microsoft.ApiManagement/service/portalconfigs@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'default'
//   properties: {
//     enableBasicAuth: true
//     signin: {
//       require: false
//     }
//     signup: {
//       termsOfService: {
//         requireConsent: false
//       }
//     }
//     delegation: {
//       delegateRegistration: false
//       delegateSubscription: false
//     }
//     cors: {
//       allowedOrigins: []
//     }
//     csp: {
//       mode: 'disabled'
//       reportUri: []
//       allowedSources: []
//     }
//   }
// }

// resource service_bfyoc_api_04_name_delegation 'Microsoft.ApiManagement/service/portalsettings@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'delegation'
//   properties: {
//     subscriptions: {
//       enabled: false
//     }
//     userRegistration: {
//       enabled: false
//     }
//   }
// }

// resource service_bfyoc_api_04_name_signin 'Microsoft.ApiManagement/service/portalsettings@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'signin'
//   properties: {
//     enabled: false
//   }
// }

// resource service_bfyoc_api_04_name_signup 'Microsoft.ApiManagement/service/portalsettings@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'signup'
//   properties: {
//     enabled: true
//     termsOfService: {
//       enabled: false
//       consentRequired: false
//     }
//   }
// }

// resource service_bfyoc_api_04_name_external_partners 'Microsoft.ApiManagement/service/products@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'external-partners'
//   properties: {
//     displayName: 'External Partners'
//     description: 'External Partners\nThe External Partners use case is to be able to see products that BYFOC has to offer, so should only have the product operations exposed to them. So this product suite should only have the following operations exposed to them:\n\nGetProduct\nGetProducts'
//     subscriptionRequired: false
//     state: 'published'
//   }
// }

// resource service_bfyoc_api_04_name_internal_business_users 'Microsoft.ApiManagement/service/products@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'internal-business-users'
//   properties: {
//     displayName: 'Internal Business Users'
//     description: 'The Internal business users use the APIs for reporting purposes. They need access to the product and rating information but shouldn’t be using the user operation or be able to create ratings. So the operations that should be exposed to this product suite are as follows:\n\nGetProduct\nGetProducts\nGetRating\nGetRatings'
//     subscriptionRequired: false
//     state: 'published'
//   }
// }

// resource service_bfyoc_api_04_name_mobile_applications 'Microsoft.ApiManagement/service/products@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'mobile-applications'
//   properties: {
//     displayName: 'Mobile Applications'
//     description: 'Mobile Applications\nThe Mobile Application requires access to all of the APIs. Each of them is required for different areas of the application’s UX. So the operations that need to be configured for this product suite are as follows:\n\nGetUser\nGetProduct\nGetProducts\nCreateRating\nGetRating\nGetRatings\nInternal busi'
//     subscriptionRequired: false
//     state: 'published'
//   }
// }

// resource service_bfyoc_api_04_name_starter 'Microsoft.ApiManagement/service/products@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'starter'
//   properties: {
//     displayName: 'Starter'
//     description: 'Subscribers will be able to run 5 calls/minute up to a maximum of 100 calls/week.'
//     subscriptionRequired: true
//     approvalRequired: false
//     subscriptionsLimit: 1
//     state: 'published'
//   }
// }

// resource service_bfyoc_api_04_name_unlimited 'Microsoft.ApiManagement/service/products@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'unlimited'
//   properties: {
//     displayName: 'Unlimited'
//     description: 'Subscribers have completely unlimited access to the API. Administrator approval is required.'
//     subscriptionRequired: true
//     approvalRequired: true
//     subscriptionsLimit: 1
//     state: 'published'
//   }
// }

// resource Microsoft_ApiManagement_service_properties_service_bfyoc_api_04_name_641ae08f463461148c9450d4 'Microsoft.ApiManagement/service/properties@2019-01-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: '641ae08f463461148c9450d4'
//   properties: {
//     displayName: 'Logger-Credentials--641ae08f463461148c9450d5'
//     value: '59c43fa5-1f8b-421d-81d6-5388068daa6e'
//     secret: true
//   }
// }

// resource Microsoft_ApiManagement_service_properties_service_bfyoc_api_04_name_func_hack4_c2_key 'Microsoft.ApiManagement/service/properties@2019-01-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'func-hack4-c2-key'
//   properties: {
//     displayName: 'func-hack4-c2-key'
//     value: 'bfg6+/ePdQr/beaL2leFiVWjxgO9VsMlOpUzEXSNi9v7c+CoBqX5hA=='
//     tags: [
//       'key'
//       'function'
//       'auto'
//     ]
//     secret: true
//   }
// }

// resource service_bfyoc_api_04_name_master 'Microsoft.ApiManagement/service/subscriptions@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'master'
//   properties: {
//     scope: '${service_bfyoc_api_04_name_resource.id}/'
//     displayName: 'Built-in all-access subscription'
//     state: 'active'
//     allowTracing: true
//   }
// }

// // resource service_bfyoc_api_04_name_1 'Microsoft.ApiManagement/service/users@2022-08-01' = {
// //   parent: service_bfyoc_api_04_name_resource
// //   name: '1'
// //   properties: {
// //     firstName: 'Administrator'
// //     email: 'info@example.com'
// //     state: 'active'
// //     identities: [
// //       {
// //         provider: 'Azure'
// //         id: 'info@example.com'
// //       }
// //     ]
// //     lastName: users_1_lastName
// //   }
// // }

// resource service_bfyoc_api_04_name_func_hack4_c2_641b00bf9108c5f28ed7d564 'Microsoft.ApiManagement/service/apis/operations@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_func_hack4_c2
//   name: '641b00bf9108c5f28ed7d564'
//   properties: {
//     displayName: 'Get Product'
//     method: 'GET'
//     urlTemplate: '/GetProduct'
//     templateParameters: []
//     request: {
//       queryParameters: [
//         {
//           name: 'productId'
//           values: []
//           type: operations_641b00bf9108c5f28ed7d564_type
//         }
//       ]
//       headers: []
//       representations: []
//     }
//     responses: []
//   }
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_func_hack4_c2_641b00d8baab387932ac3547 'Microsoft.ApiManagement/service/apis/operations@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_func_hack4_c2
//   name: '641b00d8baab387932ac3547'
//   properties: {
//     displayName: 'Get Products'
//     method: 'GET'
//     urlTemplate: '/GetProducts'
//     templateParameters: []
//     responses: []
//   }
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_641b010bfe2c001d7fb3fe6f_641b010c3649f1e3d4a7d286 'Microsoft.ApiManagement/service/apis/operations@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_641b010bfe2c001d7fb3fe6f
//   name: '641b010c3649f1e3d4a7d286'
//   properties: {
//     displayName: 'GetRatings'
//     method: 'GET'
//     urlTemplate: '/GetRatings/{userId}'
//     templateParameters: [
//       {
//         name: 'userId'
//         required: true
//         values: []
//         type: operations_641b010c3649f1e3d4a7d286_type
//       }
//     ]
//     responses: []
//   }
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_641b010bfe2c001d7fb3fe6f_641b010c6fecce0eeac1fa86 'Microsoft.ApiManagement/service/apis/operations@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_641b010bfe2c001d7fb3fe6f
//   name: '641b010c6fecce0eeac1fa86'
//   properties: {
//     displayName: 'Get Products'
//     method: 'GET'
//     urlTemplate: '/GetProducts'
//     templateParameters: []
//     responses: []
//   }
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_641b010bfe2c001d7fb3fe6f_641b010cd9e2fc5c0070bb0d 'Microsoft.ApiManagement/service/apis/operations@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_641b010bfe2c001d7fb3fe6f
//   name: '641b010cd9e2fc5c0070bb0d'
//   properties: {
//     displayName: 'GetRating'
//     method: 'GET'
//     urlTemplate: '/GetRating/{ratingId}'
//     templateParameters: [
//       {
//         name: 'ratingId'
//         required: true
//         values: []
//         type: operations_641b010cd9e2fc5c0070bb0d_type
//       }
//     ]
//     responses: []
//   }
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_641b010bfe2c001d7fb3fe6f_641b010d9d4467e1651b1e5f 'Microsoft.ApiManagement/service/apis/operations@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_641b010bfe2c001d7fb3fe6f
//   name: '641b010d9d4467e1651b1e5f'
//   properties: {
//     displayName: 'Get Product'
//     method: 'GET'
//     urlTemplate: '/GetProduct'
//     templateParameters: []
//     request: {
//       queryParameters: [
//         {
//           name: 'productId'
//           values: []
//           type: operations_641b010d9d4467e1651b1e5f_type
//         }
//       ]
//       headers: []
//       representations: []
//     }
//     responses: []
//   }
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_641b012ccf94bd7109a11fed_641b012e539d950096fc3b8e 'Microsoft.ApiManagement/service/apis/operations@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_641b012ccf94bd7109a11fed
//   name: '641b012e539d950096fc3b8e'
//   properties: {
//     displayName: 'Get Product'
//     method: 'GET'
//     urlTemplate: '/GetProduct'
//     templateParameters: []
//     request: {
//       queryParameters: [
//         {
//           name: 'productId'
//           values: []
//           type: operations_641b012e539d950096fc3b8e_type
//         }
//       ]
//       headers: []
//       representations: []
//     }
//     responses: []
//   }
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_641b012ccf94bd7109a11fed_641b012e7eb38fa8dac49430 'Microsoft.ApiManagement/service/apis/operations@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_641b012ccf94bd7109a11fed
//   name: '641b012e7eb38fa8dac49430'
//   properties: {
//     displayName: 'Get Products'
//     method: 'GET'
//     urlTemplate: '/GetProducts'
//     templateParameters: []
//     responses: []
//   }
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_func_hack4_c2_get_getrating 'Microsoft.ApiManagement/service/apis/operations@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_func_hack4_c2
//   name: 'get-getrating'
//   properties: {
//     displayName: 'GetRating'
//     method: 'GET'
//     urlTemplate: '/GetRating/{ratingId}'
//     templateParameters: [
//       {
//         name: 'ratingId'
//         required: true
//         values: []
//         type: operations_get_getrating_type
//       }
//     ]
//     responses: []
//   }
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_func_hack4_c2_get_getratings 'Microsoft.ApiManagement/service/apis/operations@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_func_hack4_c2
//   name: 'get-getratings'
//   properties: {
//     displayName: 'GetRatings'
//     method: 'GET'
//     urlTemplate: '/GetRatings/{userId}'
//     templateParameters: [
//       {
//         name: 'userId'
//         required: true
//         values: []
//         type: operations_get_getratings_type
//       }
//     ]
//     responses: []
//   }
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_func_hack4_c2_get_user 'Microsoft.ApiManagement/service/apis/operations@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_func_hack4_c2
//   name: 'get-user'
//   properties: {
//     displayName: 'Get User'
//     method: 'GET'
//     urlTemplate: '/GetUser'
//     templateParameters: []
//     request: {
//       queryParameters: [
//         {
//           name: 'userId'
//           values: []
//           type: operations_get_user_type
//         }
//       ]
//       headers: []
//       representations: []
//     }
//     responses: []
//   }
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_func_hack4_c2_post_createrating 'Microsoft.ApiManagement/service/apis/operations@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_func_hack4_c2
//   name: 'post-createrating'
//   properties: {
//     displayName: 'CreateRating'
//     method: 'POST'
//     urlTemplate: '/CreateRating'
//     templateParameters: []
//     responses: []
//   }
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_applicationinsights 'Microsoft.ApiManagement/service/diagnostics@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: 'applicationinsights'
//   properties: {
//     alwaysLog: 'allErrors'
//     httpCorrelationProtocol: 'Legacy'
//     logClientIp: true
//     loggerId: service_bfyoc_api_04_name_appi_bfyoc_04.id
//     sampling: {
//       samplingType: 'fixed'
//       percentage: 100
//     }
//     frontend: {
//       request: {
//         dataMasking: {
//           queryParams: [
//             {
//               value: '*'
//               mode: 'Hide'
//             }
//           ]
//         }
//       }
//     }
//     backend: {
//       request: {
//         dataMasking: {
//           queryParams: [
//             {
//               value: '*'
//               mode: 'Hide'
//             }
//           ]
//         }
//       }
//     }
//   }
// }

// resource service_bfyoc_api_04_name_applicationinsights_appi_bfyoc_04 'Microsoft.ApiManagement/service/diagnostics/loggers@2018-01-01' = {
//   parent: service_bfyoc_api_04_name_applicationinsights
//   name: 'appi-bfyoc-04'
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_administrators_1 'Microsoft.ApiManagement/service/groups/users@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_administrators
//   name: '1'
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_developers_1 'Microsoft.ApiManagement/service/groups/users@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_developers
//   name: '1'
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_internal_business_users_641b010bfe2c001d7fb3fe6f 'Microsoft.ApiManagement/service/products/apis@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_internal_business_users
//   name: '641b010bfe2c001d7fb3fe6f'
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_external_partners_641b012ccf94bd7109a11fed 'Microsoft.ApiManagement/service/products/apis@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_external_partners
//   name: '641b012ccf94bd7109a11fed'
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_mobile_applications_func_hack4_c2 'Microsoft.ApiManagement/service/products/apis@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_mobile_applications
//   name: 'func-hack4-c2'
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_external_partners_administrators 'Microsoft.ApiManagement/service/products/groups@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_external_partners
//   name: 'administrators'
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_internal_business_users_administrators 'Microsoft.ApiManagement/service/products/groups@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_internal_business_users
//   name: 'administrators'
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_mobile_applications_administrators 'Microsoft.ApiManagement/service/products/groups@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_mobile_applications
//   name: 'administrators'
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_starter_administrators 'Microsoft.ApiManagement/service/products/groups@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_starter
//   name: 'administrators'
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_unlimited_administrators 'Microsoft.ApiManagement/service/products/groups@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_unlimited
//   name: 'administrators'
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_starter_developers 'Microsoft.ApiManagement/service/products/groups@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_starter
//   name: 'developers'
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_unlimited_developers 'Microsoft.ApiManagement/service/products/groups@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_unlimited
//   name: 'developers'
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_starter_guests 'Microsoft.ApiManagement/service/products/groups@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_starter
//   name: 'guests'
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_unlimited_guests 'Microsoft.ApiManagement/service/products/groups@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_unlimited
//   name: 'guests'
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_external_partners_policy 'Microsoft.ApiManagement/service/products/policies@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_external_partners
//   name: 'policy'
//   properties: {
//     value: '<!--\r\n    IMPORTANT:\r\n    - Policy elements can appear only within the <inbound>, <outbound>, <backend> section elements.\r\n    - To apply a policy to the incoming request (before it is forwarded to the backend service), place a corresponding policy element within the <inbound> section element.\r\n    - To apply a policy to the outgoing response (before it is sent back to the caller), place a corresponding policy element within the <outbound> section element.\r\n    - To add a policy, place the cursor at the desired insertion point and select a policy from the sidebar.\r\n    - To remove a policy, delete the corresponding policy statement from the policy document.\r\n    - Position the <base> element within a section element to inherit all policies from the corresponding section element in the enclosing scope.\r\n    - Remove the <base> element to prevent inheriting policies from the corresponding section element in the enclosing scope.\r\n    - Policies are applied in the order of their appearance, from the top down.\r\n    - Comments within policy elements are not supported and may disappear. Place your comments between policy elements or at a higher level scope.\r\n-->\r\n<policies>\r\n  <inbound>\r\n    <base />\r\n    <rate-limit-by-key calls="15" renewal-period="60" counter-key="@(context.Subscription?.Key ?? &quot;anonymous&quot;)" />\r\n  </inbound>\r\n  <backend>\r\n    <base />\r\n  </backend>\r\n  <outbound>\r\n    <base />\r\n  </outbound>\r\n  <on-error>\r\n    <base />\r\n  </on-error>\r\n</policies>'
//     format: 'xml'
//   }
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_internal_business_users_policy 'Microsoft.ApiManagement/service/products/policies@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_internal_business_users
//   name: 'policy'
//   properties: {
//     value: '<!--\r\n    IMPORTANT:\r\n    - Policy elements can appear only within the <inbound>, <outbound>, <backend> section elements.\r\n    - To apply a policy to the incoming request (before it is forwarded to the backend service), place a corresponding policy element within the <inbound> section element.\r\n    - To apply a policy to the outgoing response (before it is sent back to the caller), place a corresponding policy element within the <outbound> section element.\r\n    - To add a policy, place the cursor at the desired insertion point and select a policy from the sidebar.\r\n    - To remove a policy, delete the corresponding policy statement from the policy document.\r\n    - Position the <base> element within a section element to inherit all policies from the corresponding section element in the enclosing scope.\r\n    - Remove the <base> element to prevent inheriting policies from the corresponding section element in the enclosing scope.\r\n    - Policies are applied in the order of their appearance, from the top down.\r\n    - Comments within policy elements are not supported and may disappear. Place your comments between policy elements or at a higher level scope.\r\n-->\r\n<policies>\r\n  <inbound>\r\n    <base />\r\n    <rate-limit-by-key calls="10" renewal-period="60" counter-key="@(context.Subscription?.Key ?? &quot;anonymous&quot;)" />\r\n  </inbound>\r\n  <backend>\r\n    <base />\r\n  </backend>\r\n  <outbound>\r\n    <base />\r\n  </outbound>\r\n  <on-error>\r\n    <base />\r\n  </on-error>\r\n</policies>'
//     format: 'xml'
//   }
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_starter_policy 'Microsoft.ApiManagement/service/products/policies@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_starter
//   name: 'policy'
//   properties: {
//     value: '<!--\r\n            IMPORTANT:\r\n            - Policy elements can appear only within the <inbound>, <outbound>, <backend> section elements.\r\n            - Only the <forward-request> policy element can appear within the <backend> section element.\r\n            - To apply a policy to the incoming request (before it is forwarded to the backend service), place a corresponding policy element within the <inbound> section element.\r\n            - To apply a policy to the outgoing response (before it is sent back to the caller), place a corresponding policy element within the <outbound> section element.\r\n            - To add a policy position the cursor at the desired insertion point and click on the round button associated with the policy.\r\n            - To remove a policy, delete the corresponding policy statement from the policy document.\r\n            - Position the <base> element within a section element to inherit all policies from the corresponding section element in the enclosing scope.\r\n            - Remove the <base> element to prevent inheriting policies from the corresponding section element in the enclosing scope.\r\n            - Policies are applied in the order of their appearance, from the top down.\r\n        -->\r\n<policies>\r\n  <inbound>\r\n    <rate-limit calls="5" renewal-period="60" />\r\n    <quota calls="100" renewal-period="604800" />\r\n    <base />\r\n  </inbound>\r\n  <backend>\r\n    <base />\r\n  </backend>\r\n  <outbound>\r\n    <base />\r\n  </outbound>\r\n</policies>'
//     format: 'xml'
//   }
//   dependsOn: [
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_func_hack4_c2_641b00bf9108c5f28ed7d564_policy 'Microsoft.ApiManagement/service/apis/operations/policies@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_func_hack4_c2_641b00bf9108c5f28ed7d564
//   name: 'policy'
//   properties: {
//     value: '<!--\r\n    IMPORTANT:\r\n    - Policy elements can appear only within the <inbound>, <outbound>, <backend> section elements.\r\n    - To apply a policy to the incoming request (before it is forwarded to the backend service), place a corresponding policy element within the <inbound> section element.\r\n    - To apply a policy to the outgoing response (before it is sent back to the caller), place a corresponding policy element within the <outbound> section element.\r\n    - To add a policy, place the cursor at the desired insertion point and select a policy from the sidebar.\r\n    - To remove a policy, delete the corresponding policy statement from the policy document.\r\n    - Position the <base> element within a section element to inherit all policies from the corresponding section element in the enclosing scope.\r\n    - Remove the <base> element to prevent inheriting policies from the corresponding section element in the enclosing scope.\r\n    - Policies are applied in the order of their appearance, from the top down.\r\n    - Comments within policy elements are not supported and may disappear. Place your comments between policy elements or at a higher level scope.\r\n-->\r\n<policies>\r\n  <inbound>\r\n    <base />\r\n    <set-backend-service base-url="https://serverlessohapi.azurewebsites.net/api" />\r\n  </inbound>\r\n  <backend>\r\n    <base />\r\n  </backend>\r\n  <outbound>\r\n    <base />\r\n  </outbound>\r\n  <on-error>\r\n    <base />\r\n  </on-error>\r\n</policies>'
//     format: 'xml'
//   }
//   dependsOn: [
//     service_bfyoc_api_04_name_func_hack4_c2
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_func_hack4_c2_641b00d8baab387932ac3547_policy 'Microsoft.ApiManagement/service/apis/operations/policies@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_func_hack4_c2_641b00d8baab387932ac3547
//   name: 'policy'
//   properties: {
//     value: '<!--\r\n    IMPORTANT:\r\n    - Policy elements can appear only within the <inbound>, <outbound>, <backend> section elements.\r\n    - To apply a policy to the incoming request (before it is forwarded to the backend service), place a corresponding policy element within the <inbound> section element.\r\n    - To apply a policy to the outgoing response (before it is sent back to the caller), place a corresponding policy element within the <outbound> section element.\r\n    - To add a policy, place the cursor at the desired insertion point and select a policy from the sidebar.\r\n    - To remove a policy, delete the corresponding policy statement from the policy document.\r\n    - Position the <base> element within a section element to inherit all policies from the corresponding section element in the enclosing scope.\r\n    - Remove the <base> element to prevent inheriting policies from the corresponding section element in the enclosing scope.\r\n    - Policies are applied in the order of their appearance, from the top down.\r\n    - Comments within policy elements are not supported and may disappear. Place your comments between policy elements or at a higher level scope.\r\n-->\r\n<policies>\r\n  <inbound>\r\n    <base />\r\n    <set-backend-service base-url="https://serverlessohapi.azurewebsites.net/api" />\r\n  </inbound>\r\n  <backend>\r\n    <base />\r\n  </backend>\r\n  <outbound>\r\n    <base />\r\n  </outbound>\r\n  <on-error>\r\n    <base />\r\n  </on-error>\r\n</policies>'
//     format: 'xml'
//   }
//   dependsOn: [
//     service_bfyoc_api_04_name_func_hack4_c2
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_func_hack4_c2_get_getrating_policy 'Microsoft.ApiManagement/service/apis/operations/policies@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_func_hack4_c2_get_getrating
//   name: 'policy'
//   properties: {
//     value: '<policies>\r\n  <inbound>\r\n    <base />\r\n    <set-backend-service id="apim-generated-policy" backend-id="func-hack4-c2" />\r\n  </inbound>\r\n  <backend>\r\n    <base />\r\n  </backend>\r\n  <outbound>\r\n    <base />\r\n  </outbound>\r\n  <on-error>\r\n    <base />\r\n  </on-error>\r\n</policies>'
//     format: 'xml'
//   }
//   dependsOn: [
//     service_bfyoc_api_04_name_func_hack4_c2
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_func_hack4_c2_get_getratings_policy 'Microsoft.ApiManagement/service/apis/operations/policies@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_func_hack4_c2_get_getratings
//   name: 'policy'
//   properties: {
//     value: '<policies>\r\n  <inbound>\r\n    <base />\r\n    <set-backend-service id="apim-generated-policy" backend-id="func-hack4-c2" />\r\n  </inbound>\r\n  <backend>\r\n    <base />\r\n  </backend>\r\n  <outbound>\r\n    <base />\r\n  </outbound>\r\n  <on-error>\r\n    <base />\r\n  </on-error>\r\n</policies>'
//     format: 'xml'
//   }
//   dependsOn: [
//     service_bfyoc_api_04_name_func_hack4_c2
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_func_hack4_c2_get_user_policy 'Microsoft.ApiManagement/service/apis/operations/policies@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_func_hack4_c2_get_user
//   name: 'policy'
//   properties: {
//     value: '<!--\r\n    IMPORTANT:\r\n    - Policy elements can appear only within the <inbound>, <outbound>, <backend> section elements.\r\n    - To apply a policy to the incoming request (before it is forwarded to the backend service), place a corresponding policy element within the <inbound> section element.\r\n    - To apply a policy to the outgoing response (before it is sent back to the caller), place a corresponding policy element within the <outbound> section element.\r\n    - To add a policy, place the cursor at the desired insertion point and select a policy from the sidebar.\r\n    - To remove a policy, delete the corresponding policy statement from the policy document.\r\n    - Position the <base> element within a section element to inherit all policies from the corresponding section element in the enclosing scope.\r\n    - Remove the <base> element to prevent inheriting policies from the corresponding section element in the enclosing scope.\r\n    - Policies are applied in the order of their appearance, from the top down.\r\n    - Comments within policy elements are not supported and may disappear. Place your comments between policy elements or at a higher level scope.\r\n-->\r\n<policies>\r\n  <inbound>\r\n    <base />\r\n    <set-backend-service base-url="https://serverlessohapi.azurewebsites.net/api" />\r\n  </inbound>\r\n  <backend>\r\n    <base />\r\n  </backend>\r\n  <outbound>\r\n    <base />\r\n  </outbound>\r\n  <on-error>\r\n    <base />\r\n  </on-error>\r\n</policies>'
//     format: 'xml'
//   }
//   dependsOn: [
//     service_bfyoc_api_04_name_func_hack4_c2
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_func_hack4_c2_post_createrating_policy 'Microsoft.ApiManagement/service/apis/operations/policies@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_func_hack4_c2_post_createrating
//   name: 'policy'
//   properties: {
//     value: '<policies>\r\n  <inbound>\r\n    <base />\r\n    <set-backend-service id="apim-generated-policy" backend-id="func-hack4-c2" />\r\n  </inbound>\r\n  <backend>\r\n    <base />\r\n  </backend>\r\n  <outbound>\r\n    <base />\r\n  </outbound>\r\n  <on-error>\r\n    <base />\r\n  </on-error>\r\n</policies>'
//     format: 'xml'
//   }
//   dependsOn: [
//     service_bfyoc_api_04_name_func_hack4_c2
//     service_bfyoc_api_04_name_resource
//   ]
// }

// resource service_bfyoc_api_04_name_641ad1fff0021e004e070001 'Microsoft.ApiManagement/service/subscriptions@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: '641ad1fff0021e004e070001'
//   properties: {
//     // ownerId: service_bfyoc_api_04_name_1.id
//     scope: service_bfyoc_api_04_name_starter.id
//     state: 'active'
//     displayName: subscriptions_641ad1fff0021e004e070001_displayName
//   }
// }

// resource service_bfyoc_api_04_name_641ad1fff0021e004e070002 'Microsoft.ApiManagement/service/subscriptions@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: '641ad1fff0021e004e070002'
//   properties: {
//     // ownerId: service_bfyoc_api_04_name_1.id
//     scope: service_bfyoc_api_04_name_unlimited.id
//     state: 'active'
//     displayName: subscriptions_641ad1fff0021e004e070002_displayName
//   }
// }

// resource service_bfyoc_api_04_name_641af34a463461148c9450dd 'Microsoft.ApiManagement/service/subscriptions@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: '641af34a463461148c9450dd'
//   properties: {
//     // ownerId: service_bfyoc_api_04_name_1.id
//     scope: service_bfyoc_api_04_name_internal_business_users.id
//     state: 'active'
//     allowTracing: false
//     displayName: subscriptions_641af34a463461148c9450dd_displayName
//   }
// }

// resource service_bfyoc_api_04_name_641af375463461148c9450e0 'Microsoft.ApiManagement/service/subscriptions@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: '641af375463461148c9450e0'
//   properties: {
//     // ownerId: service_bfyoc_api_04_name_1.id
//     scope: service_bfyoc_api_04_name_external_partners.id
//     state: 'active'
//     allowTracing: false
//     displayName: subscriptions_641af375463461148c9450e0_displayName
//   }
// }

// resource service_bfyoc_api_04_name_641af387463461148c9450e3 'Microsoft.ApiManagement/service/subscriptions@2022-08-01' = {
//   parent: service_bfyoc_api_04_name_resource
//   name: '641af387463461148c9450e3'
//   properties: {
//     // ownerId: service_bfyoc_api_04_name_1.id
//     scope: service_bfyoc_api_04_name_mobile_applications.id
//     state: 'active'
//     allowTracing: false
//     displayName: subscriptions_641af387463461148c9450e3_displayName
//   }
// }
