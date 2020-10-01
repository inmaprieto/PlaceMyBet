using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace WebApplication.Models
{
	public class Apuesta
	{
		public Apuesta(int apuestaId, string emailUsuario, int mercadoId, decimal cuotaApuesta, int dineroApuesta, string fechaApuesta, string tipoApuesta)
		{
			ApuestaId = apuestaId;
			EmailUsuario = emailUsuario;
			MercadoId = mercadoId;
			CuotaApuesta = cuotaApuesta;
			DineroApuesta = dineroApuesta;
			FechaApuesta = fechaApuesta;
			TipoApuesta = tipoApuesta;
		}

		public int ApuestaId { get; set; }
		public string EmailUsuario { get; set; }
		public int MercadoId { get; set; }
		public decimal CuotaApuesta { get; set; }
		public int DineroApuesta { get; set; }
		public string FechaApuesta { get; set; }
		public string TipoApuesta { get; set; }
	}




}