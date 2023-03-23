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
using Microsoft.Azure.WebJobs.Extensions.CosmosDB;
using System.Threading;

namespace Z.BatchOrders
{
    public class BatchOrders
    {
        [FunctionName("BatchOrders")]
        public static async Task Run([BlobTrigger("raw/{name}", Connection = "batchblobstorage11c00e_STORAGE")] Stream myBlob, string name, ILogger log,
                [DurableClient] IDurableEntityClient entityClient
)
        {
            log.LogInformation($"C# Blob trigger function Processed blob\n Name:{name} \n Size: {myBlob.Length} Bytes");

            var entityId = new EntityId("Counter", "Counter");
            await entityClient.SignalEntityAsync(entityId, "add", name);
        }

        [FunctionName("Counter")]
        public void Counter([EntityTrigger] IDurableEntityContext ctx)
        {
            var vote = ctx.GetState<string>(); // does not yet work
            switch (ctx.OperationName.ToLowerInvariant())
            {
                case "add":
                    ctx.SetState(vote);
                    break;
                case "reset":

                    ctx.SetState(vote);
                    break;
                case "get":
                    ctx.Return(vote);
                    break;
                case "delete":
                    ctx.DeleteState();
                    break;
            }
        }


    }


}
