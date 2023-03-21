using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Microsoft.Azure.WebJobs.Extensions.OpenApi.Core.Attributes;
using Microsoft.OpenApi.Models;
using Microsoft.Azure.WebJobs.Extensions.OpenApi.Core.Enums;
using System.Net;

namespace Z.OpenHack
{
    public static class HttpTrigger1
    {
        [OpenApiOperation(operationId: "Run", tags: new[] { "productId" })]
        [OpenApiSecurity("function_key", SecuritySchemeType.ApiKey, Name = "code", In = OpenApiSecurityLocationType.Query)]
        [OpenApiParameter(name: "productId", In = ParameterLocation.Query, Required = true, Type = typeof(string), Description = "The **product id** parameter")]
        [OpenApiResponseWithBody(statusCode: HttpStatusCode.OK, contentType: "text/plain", bodyType: typeof(string), Description = "The OK response")]
        [FunctionName("HttpTrigger1")]
        public static async Task<IActionResult> Run(
          [HttpTrigger(AuthorizationLevel.Function, "get", "post", Route = null)] HttpRequest req,
          ILogger log)
        {

            log.LogInformation("C# HTTP trigger function processed a request.");

            string productId = req.Query["productId"];

            string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
            dynamic data = JsonConvert.DeserializeObject(requestBody);
            productId = productId ?? data?.productId;

            string responseMessage = string.IsNullOrEmpty(productId)
                ? "This HTTP triggered function executed successfully. Pass a productId in the query string or in the request body for a personalized response."
                : $"The product name for your product id {productId} is Starfruit Explosion";

            return new OkObjectResult(responseMessage);
        }
    }
}
