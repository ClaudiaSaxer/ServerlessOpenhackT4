using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Host;
using Microsoft.Extensions.Logging;
using Microsoft.Azure.WebJobs.Extensions.DurableTask;
using System.Net.Http;
using Microsoft.Azure.WebJobs.Extensions.Http;
using System.Diagnostics.Metrics;
using System.Net;
using Newtonsoft.Json.Linq;
using DurableTask.Core.Stats;
using System.Collections.Generic;

namespace Z.BatchOrders
{
    public class BatchOrders
    {
        [FunctionName("BatchOrders")]
        public static async Task Run([BlobTrigger("raw/{name}", Connection = "batchblobstorage11c00e_STORAGE")] Stream myBlob, string name, ILogger log,
                [OrchestrationClient] IDurableOrchestrationClient durableOrchestrationClient
)
        {
            log.LogInformation($"C# Blob trigger function Processed blob\n Name:{name} \n Size: {myBlob.Length} Bytes");
            await durableOrchestrationClient.StartNewAsync("YourNewDurableFunction", name);
        }

        [FunctionName("YourNewDurableFunction")]
        public async Task YourNewDurableFunction(
      [OrchestrationTrigger] IDurableOrchestrationContext orchestrationContext, ILogger logger)
        {
            var input = orchestrationContext.GetInput<string>();
            logger.LogInformation($"C# YourNewDurableFunction function Processed blob\n Name:{input}");
            // Call activity functions here.  
        }
    }


}
