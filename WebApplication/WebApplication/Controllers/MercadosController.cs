﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WebApplication.Models;

namespace WebApplication.Controllers
{
    public class MercadosController : ApiController
    {
        // GET: api/Eventos
        public IEnumerable<Mercado> Get()
        {
            var repos = new MercadosRepository();
            List<Mercado> mercados = repos.Retrieve();
            return mercados;
        }


    }
}
