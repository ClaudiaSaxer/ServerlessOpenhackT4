using System.Collections.Generic;
using System.IO;
using System.Linq;
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

namespace Z.GetRatings
{
    public class GetRatings
    {
        private readonly ILogger<GetRatings> _logger;

        public GetRatings(ILogger<GetRatings> log)
        {
            _logger = log;
        }

          [FunctionName("GetRatings")]
        [OpenApiOperation(operationId: "Run", tags: new[] { "Rating" })]
        [OpenApiSecurity("function_key", SecuritySchemeType.ApiKey, Name = "code", In = OpenApiSecurityLocationType.Query)]
        [OpenApiParameter(name: "userId", In = ParameterLocation.Query, Required = true, Type = typeof(string), Description = "The **userId** parameter")]
        [OpenApiResponseWithBody(statusCode: HttpStatusCode.OK, contentType: "text/plain", bodyType: typeof(string), Description = "The OK response")]
    public async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Function, "get", Route = "GetRatings/{userId}")] HttpRequest req,
            [CosmosDB(
        databaseName: "BFYOC",
        containerName: "Ratings",
        Connection  = "CosmosDbConnectionString",
        SqlQuery = "Select * from r where r.userId = {userId}"
       )]IEnumerable<Rating> ratings)
        {
            _logger.LogInformation("C# HTTP trigger function processed a request.");

            if (ratings.FirstOrDefault() == null)
            {
                string userId = req.Query["userId"];
                string responseMessage = $"No data was found for userId: {userId}";
                return new OkObjectResult(responseMessage);
            }

            return new OkObjectResult(ratings);
        }
    }
}

