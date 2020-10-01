using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace WebApplication.Models
{
	public class Usuario
	{
		public Usuario(string emailUsuario, string nombreUsuario, string apellidoUsuario, int edadUsuario)
		{
			EmailUsuario = emailUsuario;
			NombreUsuario = nombreUsuario;
			ApellidoUsuario = apellidoUsuario;
			EdadUsuario = edadUsuario;
		}

		public string EmailUsuario { get; set; }
		public string NombreUsuario { get; set; }
		public string ApellidoUsuario { get; set; }
		public int EdadUsuario { get; set; }
	}




}