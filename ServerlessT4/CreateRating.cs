using System;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Text.Json.Serialization;
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
        databaseName: "BFYOC",
        containerName: "Ratings",
        Connection  = "CosmosDbConnectionString"
       )]IAsyncCollector<Rating> ratings)
        {
            _logger.LogInformation("C# HTTP trigger function processed a request.");

            string requestBody = await new StreamReader(req.Body).ReadToEndAsync();

            var data = JsonConvert.DeserializeObject<CreateRatingDto>(requestBody);

            Rating item = new(
                id: System.Guid.NewGuid().ToString(),
                userId: data.UserId.ToString(),
                productId: data.ProductId.ToString(),
                locationName: data.LocationName,
                rating: data.Rating,
                userNotes: data.UserNotes,
                timestamp: DateTime.UtcNow);



            using (var httpClient = new HttpClient())
            {
                var responseUser = await httpClient.GetAsync($"https://serverlessohapi.azurewebsites.net/api/GetUser?userId={item.userId}");

                if (!responseUser.IsSuccessStatusCode)
                {
                    return new BadRequestObjectResult($"Please add a valid UserId: {item.userId}");
                }
                else
                {
                    // success
                    // var json = await response.Content.ReadAsStringAsync();
                    // var user = JsonConvert.DeserializeObject<UserDto>(json);
                }


                var responseProduct = await httpClient.GetAsync($"https://serverlessohapi.azurewebsites.net/api/GetProduct?productId={item.productId}");

                if (!responseProduct.IsSuccessStatusCode)
                {
                    return new BadRequestObjectResult($"Please add a valid productId: {item.productId}");
                }
            }

            if (item.rating < 0 || item.rating > 5)
            {
                return new BadRequestObjectResult($"Please add a rating from 0-5: {item.rating}");
            }

            await ratings.AddAsync(item);
            return new OkObjectResult(item);
        }
    }

    internal class UserDto
    {
        [JsonPropertyName("userId")]
        public Guid UserId { get; set; }
        [JsonPropertyName("userName")]
        public string UserName { get; set; }
        [JsonPropertyName("fullName")]
        public string FullName { get; set; }
    }

    internal class ProductDto
    {
        [JsonPropertyName("productId")]
        public Guid ProductId { get; set; }
        [JsonPropertyName("productName")]
        public string ProductName { get; set; }
        [JsonPropertyName("productDescription")]
        public string ProductDescription { get; set; }
    }

    internal class CreateRatingDto
    {
        public Guid UserId { get; set; }
        public Guid ProductId { get; set; }
        public string LocationName { get; set; }
        public int Rating { get; set; }
        public string UserNotes { get; set; }
    }
}

