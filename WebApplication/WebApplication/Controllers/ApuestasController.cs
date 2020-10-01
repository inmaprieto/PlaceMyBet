using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WebApplication.Models;

namespace WebApplication.Controllers
{
    public class ApuestasController : ApiController
    {
        // GET: api/Eventos
        public IEnumerable<Apuesta> Get()
        {
            var repos = new ApuestasRepository();
            List<Apuesta> apuestas = repos.Retrieve();
            return apuestas;
        }


    }
}
