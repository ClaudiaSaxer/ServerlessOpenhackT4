using System.IO;
using System.Net;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Azure.WebJobs.Extensions.OpenApi.Core.Attributes;
using Microsoft.Azure.WebJobs.Extensions.OpenApi.Core.Enums;
using Microsoft.Extensions.Logging;
using Microsoft.OpenApi.Models;
using Newtonsoft.Json;

namespace Z.CreateRating
{
    public class CreateRating
    {
        private readonly ILogger<CreateRating> _logger;

        public CreateRating(ILogger<CreateRating> log)
        {
            _logger = log;
        }

        [FunctionName("CreateRating")]
        [OpenApiOperation(operationId: "Run", tags: new[] { "userId", "productId", "locationName", "rating", "userNotes" })]
        [OpenApiSecurity("function_key", SecuritySchemeType.ApiKey, Name = "code", In = OpenApiSecurityLocationType.Query)]
        [OpenApiParameter(name: "userId", In = ParameterLocation.Query, Required = true, Type = typeof(string), Description = "The **userId** parameter")]
        [OpenApiParameter(name: "productId", In = ParameterLocation.Query, Required = true, Type = typeof(string), Description = "The **productId** parameter")]
        [OpenApiParameter(name: "locationName", In = ParameterLocation.Query, Required = true, Type = typeof(string), Description = "The **locationName** parameter")]
        [OpenApiParameter(name: "rating", In = ParameterLocation.Query, Required = true, Type = typeof(string), Description = "The **rating** parameter")]
        [OpenApiParameter(name: "userNotes", In = ParameterLocation.Query, Required = true, Type = typeof(string), Description = "The **userNotes** parameter")]
        [OpenApiResponseWithBody(statusCode: HttpStatusCode.OK, contentType: "text/plain", bodyType: typeof(string), Description = "The OK response")]
        public async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Function, "get", "post", Route = null)] HttpRequest req)
        {
            _logger.LogInformation("C# HTTP trigger function processed a request.");

            string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
            dynamic data = JsonConvert.DeserializeObject(requestBody);
            var userId = data?.userId;
            var productId = data?.productId;
            var locationName = data?.locationName;
            var rating = data?.rating;
            var userNotes = data?.userNotes;

            string responseMessage = string.IsNullOrEmpty(userId)
                ? "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response."
                : $"Hello, {userId}. This HTTP triggered function executed successfully.";

            return new OkObjectResult(responseMessage);
        }
    }
}

