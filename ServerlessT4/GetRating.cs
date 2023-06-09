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

namespace Z.GetRating
{
    public class GetRating
    {
        private readonly ILogger<GetRating> _logger;

        public GetRating(ILogger<GetRating> log)
        {
            _logger = log;
        }

        [FunctionName("GetRating")]
        [OpenApiOperation(operationId: "Run", tags: new[] { "Rating" })]
        [OpenApiSecurity("function_key", SecuritySchemeType.ApiKey, Name = "code", In = OpenApiSecurityLocationType.Query)]
        [OpenApiParameter(name: "ratingId", In = ParameterLocation.Query, Required = true, Type = typeof(string), Description = "The **ratingId** parameter")]
        [OpenApiResponseWithBody(statusCode: HttpStatusCode.OK, contentType: "text/plain", bodyType: typeof(string), Description = "The OK response")]
        public async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Function, "get", Route = "GetRating/{ratingId}")] HttpRequest req,
            [CosmosDB(
        databaseName: "BFYOC",
        containerName: "Ratings",
        Connection  = "CosmosDbConnectionString",
        SqlQuery = "Select * from r where r.id = {ratingId}"
       )]IEnumerable<Rating> ratings)
        {
            _logger.LogInformation("C# HTTP trigger function processed a request.");

            var result = ratings.FirstOrDefault();

            if (result == null)
            {
                string ratingId = req.Query["ratingId"];
                string responseMessage = $"No data was found for ratingId: {ratingId}";
                return new NotFoundObjectResult(responseMessage);
            }

            return new OkObjectResult(result);
        }
    }
}

