using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WebApplication.Models;

namespace WebApplication.Controllers
{
    public class EventosController : ApiController
    {
        // GET: api/Eventos
        public IEnumerable<EventoDTO> Get()
        {
            var repos = new EventosRepository();
            List<EventoDTO> eventos = repos.RetrieveDTO();
            return eventos;
        }

      

      
    }
}
