﻿using AdsGoFast.Models.Options;
using AdsGoFast.Services;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text;

namespace AdsGoFast.Models
{
    public interface ICoreFunctionsContext {
        public IHttpClientFactory httpClient { get; set; }
        public string httpClientName { get; set; }
    }
  

    class CoreFunctionsContext: ICoreFunctionsContext
    {
        public IHttpClientFactory httpClient { get; set; }

        public string httpClientName { get; set; }
        public CoreFunctionsContext(IHttpClientFactory Client)
        {
            httpClient = Client;
            httpClientName = "CoreFunctions";
        }
    }
}
