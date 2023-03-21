using System.IO;
using System.Net;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Cosmos;
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
        public CosmosClient cosmosClient;
        public Database database;
        public Container container;
        public CreateRating(ILogger<CreateRating> log)
        {
            _logger = log;
        }

        [FunctionName("CreateRating")]
        [OpenApiOperation(operationId: "Run", tags: new[] { "Rating" })]
        [OpenApiSecurity("function_key", SecuritySchemeType.ApiKey, Name = "code", In = OpenApiSecurityLocationType.Query)]
        [OpenApiRequestBody(contentType: "json", bodyType: typeof(System.Text.Json.JsonDocument), Description = "Parameters", Example = typeof(CreateRatingDto))]
        public async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Function, "post", Route = null)] HttpRequest req,
            [CosmosDB(
        databaseName: "my-database",
        collectionName: "my-container",
        ConnectionStringSetting = "CosmosDbConnectionString")]IAsyncCollector<dynamic> documentsOuts)
        {
            _logger.LogInformation("C# HTTP trigger function processed a request.");

            string requestBody = await new StreamReader(req.Body).ReadToEndAsync();

            var data = JsonConvert.DeserializeObject<CreateRatingDto>(requestBody);

            Rating item = new(
                ratingId: new System.Guid().ToString(),
                userId: data.UserId.ToString(),
                productId: data.ProductId.ToString(),
                locationName: data.LocationName,
                rating: data.Rating,
                userNotes: data.UserNotes);

            var options = new CosmosClientOptions() { ConnectionMode = ConnectionMode.Gateway };
            cosmosClient = new CosmosClient(EndpointUri, PrimaryKey, options);
            database = cosmosClient.GetDatabase("Data");
            container = database.GetContainer("Locations");

            ItemResponse<Rating> loc_response = await container.CreateItemAsync<Rating>(
                item, new PartitionKey(item.ratingId));


            string responseMessage = data?.UserId == System.Guid.Empty
                ? "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a zpersonalized response."
                : $"Hello, {data.UserId}. This HTTP triggered function executed successfully.";

            return new OkObjectResult(responseMessage);
        }
    }
}

