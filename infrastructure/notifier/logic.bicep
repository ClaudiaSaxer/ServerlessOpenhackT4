@description('Location for all resources.')
param location string = resourceGroup().location
param workflows_logic_hack4_c5_name string
param api_url string
param dynamics_url string

param connections_commondataservice_name string = 'commondataservice'

resource connections_commondataservice_name_resource 'Microsoft.Web/connections@2016-06-01' = {
  name: connections_commondataservice_name
  location: location
  properties: {
    displayName: 'null'
    customParameterValues: {
    }
    nonSecretParameterValues: {
      'token:grantType': 'code'
    }
    api: {
      name: connections_commondataservice_name
      displayName: 'Microsoft Dataverse (legacy)'
      description: 'Provides access to the environment database in Microsoft Dataverse.'
      iconUri: 'https://connectoricons-prod.azureedge.net/u/laborbol/releases/ase-v3/1.0.1622.3200/${connections_commondataservice_name}/icon-la.png'
      brandColor: '#637080'
      id: '/subscriptions/${subscription().subscriptionId}/providers/Microsoft.Web/locations/westeurope/managedApis/${connections_commondataservice_name}'
      type: 'Microsoft.Web/locations/managedApis'
    }
  }
}

param connections_office365_name string = 'office365'

resource connections_office365_name_resource 'Microsoft.Web/connections@2016-06-01' = {
  name: connections_office365_name
  location: 'westeurope'
  kind: 'V1'
  properties: {
    displayName: 'null'
    customParameterValues: {
    }
    nonSecretParameterValues: {
    }
    api: {
      name: connections_office365_name
      displayName: 'Office 365 Outlook'
      description: 'Microsoft Office 365 is a cloud-based service that is designed to help meet your organization\'s needs for robust security, reliability, and user productivity.'
      iconUri: 'https://connectoricons-prod.azureedge.net/u/laborbol/patches/1624/ase-v3-la-99-no-usgov/1.0.1624.3222/${connections_office365_name}/icon.png'
      brandColor: '#0078D4'
      id: '/subscriptions/c268b76f-4165-4b3b-8e2a-a585b336bcc0/providers/Microsoft.Web/locations/westeurope/managedApis/${connections_office365_name}'
      type: 'Microsoft.Web/locations/managedApis'
    }
    testLinks: [
      {
        requestUri: 'https://management.azure.com:443/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Web/connections/${connections_office365_name}/extensions/proxy/testconnection?api-version=2016-06-01'
        method: 'get'
      }
    ]
  }
}

resource workflows_logic_hack4_c5_name_resource 'Microsoft.Logic/workflows@2017-07-01' = {
  name: workflows_logic_hack4_c5_name
  location: location
  properties: {
    state: 'Enabled'
    definition: {
      '$schema': 'https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#'
      contentVersion: '1.0.0.0'
      parameters: {
        '$connections': {
          defaultValue: {}
          type: 'Object'
        }
      }
      triggers: {
        manual: {
          type: 'Request'
          kind: 'Http'
          inputs: {
            schema: {}
          }
        }
      }
      actions: {
        Append_to_string_variable_2: {
          runAfter: {
            For_each_2: [
              'Succeeded'
            ]
          }
          type: 'AppendToStringVariable'
          inputs: {
            name: 'products'
            value: '</tbody>\n  </table>\n  <p style="text-align: center; margin-top: 3em;font-size: 20px;">Please contact\n  your representative at Best For You Organics to get more information..</p>\n</body>\n</html>'
          }
        }
        For_each: {
          foreach: '@body(\'List_rows_(legacy)\')?[\'value\']'
          actions: {
            'Send_an_email_(V2)': {
              runAfter: {}
              type: 'ApiConnection'
              inputs: {
                body: {
                  Body: '<p>@{variables(\'products\')}</p>'
                  Importance: 'Normal'
                  Subject: 'Team 4'
                  To: '@{items(\'For_each\')?[\'emailaddress1\']}'
                }
                host: {
                  connection: {
                    name: connections_office365_name_resource.id
                  }
                }
                method: 'post'
                path: '/v2/Mail'
              }
            }
          }
          runAfter: {
            'List_rows_(legacy)': [
              'Succeeded'
            ]
          }
          type: 'Foreach'
        }
        For_each_2: {
          foreach: '@body(\'Parse_JSON\')'
          actions: {
            Append_to_string_variable: {
              runAfter: {}
              type: 'AppendToStringVariable'
              inputs: {
                name: 'products'
                value: ' <tr>\n        <th style="padding-bottom: 1em;" align="left"> @{items(\'For_each_2\')[\'productName\']}</th>\n        <th style="padding-bottom: 1em;" align="left">@{items(\'For_each_2\')[\'productDescription\']}</th>\n        <th style="padding-bottom: 1em;" align="left">@{items(\'For_each_2\')[\'productId\']}</th>\n      </tr>'
              }
            }
          }
          runAfter: {
            Initialize_variable_2: [
              'Succeeded'
            ]
          }
          type: 'Foreach'
        }
        HTTP: {
          runAfter: {}
          type: 'Http'
          inputs: {
            method: 'GET'
            uri: 'https://${api_url}.azure-api.net/mobile/GetProducts'
          }
        }
        Initialize_variable_2: {
          runAfter: {
            Parse_JSON: [
              'Succeeded'
            ]
          }
          type: 'InitializeVariable'
          inputs: {
            variables: [
              {
                name: 'products'
                type: 'string'
                value: '<!DOCTYPE html>\n<html>\n<body style="background-color: whitesmoke; color: #454545; font-family:\'Gill Sans\',\n \'Gill Sans MT\', Calibri, \'Trebuchet MS\', sans-serif; padding-bottom: 3em;">\n  <table style="width:100%; color:#454545">\n    <tr>\n      <td style="width:11em;">\n        <img style="margin-left:1em;"\n        src="https://serverlessoh.azureedge.net/public/ice-cream-2202561_320-circle.jpg"\n          height="160" width="160" alt="Fruit Ice Cream">\n      </td>\n      <td>\n        <p style="font-style: italic; font-size: 50px;\n        font-weight:600; margin-left: 1em;">Best For You Organics</p>\n      </td>\n    </tr>\n  </table>\n  <p style="text-align: center; font-style: italic; font-size:\n  80px;">New Ice Cream Line!</p>\n  <p style="margin:2em 0em; font-size: 20px; text-align: center;">\n  Best For You Organics have a new line of fruit flavored ice creams.\n  Below is the information so you can start the ordering process:\n  </p>\n  <table style="width:100%; border-top: 1px solid #454545;\n  border-bottom: 1px solid #454545; color:#454545; padding: 1em; font-size: 20px;">\n    <thead>\n      <tr>\n        <th style="padding-bottom: 1em;" align="left">Ice Cream</th>\n        <th style="padding-bottom: 1em;" align="left">Description</th>\n        <th style="padding-bottom: 1em;" align="left">Product ID</th>\n      </tr>\n    </thead>\n    <tbody style="font-size: 16px;">'
              }
            ]
          }
        }
        'List_rows_(legacy)': {
          runAfter: {
            Append_to_string_variable_2: [
              'Succeeded'
            ]
          }
          type: 'ApiConnection'
          inputs: {
            host: {
              connection: {
                name: connections_commondataservice_name_resource.id
              }
            }
            method: 'get'
            path: '/v2/datasets/@{encodeURIComponent(encodeURIComponent(\'${dynamics_url}\'))}/tables/@{encodeURIComponent(encodeURIComponent(\'contacts\'))}/items'
          }
        }
        Parse_JSON: {
          runAfter: {
            HTTP: [
              'Succeeded'
            ]
          }
          type: 'ParseJson'
          inputs: {
            content: '@body(\'HTTP\')'
            schema: {
              items: {
                properties: {
                  productDescription: {
                    type: 'string'
                  }
                  productId: {
                    type: 'string'
                  }
                  productName: {
                    type: 'string'
                  }
                }
                required: [
                  'productId'
                  'productName'
                  'productDescription'
                ]
                type: 'object'
              }
              type: 'array'
            }
          }
        }
      }
      outputs: {}
    }
  }
}
