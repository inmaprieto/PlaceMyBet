using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WebApplication.Models;

namespace WebApplication.Controllers
{
    public class UsuariosController : ApiController
    {
        // GET: api/Eventos
        public IEnumerable<Usuario> Get()
        {
            var repos = new UsuariosRepository();
            List<Usuario> usuarios = repos.Retrieve();
            return usuarios;
        }


    }
}
