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

            var file = ctx.GetInput<string>(); // does not yet work
            var id = file.Split("-")[0];

            Dictionary<string, int> state = (Dictionary<string, int>)(ctx.GetState<object>() ?? new Dictionary<string, int>());

            var current = state.ContainsKey(id);
            if (!state.ContainsKey(id))
            {
                state.Add(id, 1);
                ctx.SetState(state);
                return;
            }

            state[id] = state[id] + 1;

            if (state[id] == 3)
            {
                // do something
                state.Remove(id);
            }

            ctx.SetState(state);

        }
    }
}
