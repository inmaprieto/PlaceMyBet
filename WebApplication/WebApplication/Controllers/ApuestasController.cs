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
        public IEnumerable<ApuestaDTO> Get()
        {
            var repos = new ApuestasRepository();
            List<ApuestaDTO> apuestas = repos.RetrieveDTO();
            return apuestas;
        }

        public Apuesta Get(int id) 
        {
            return null;
        }

        public void Post([FromBody]ApuestaUsuario apuesta) 
        {
            var repo = new ApuestasRepository();
            repo.Save(apuesta);
        }

       

    }
}
