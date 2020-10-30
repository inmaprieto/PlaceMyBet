using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace WebApplication.Models
{
	public class Apuesta
	{
		public Apuesta(int apuestaId, string emailUsuario, int mercadoId, double cuotaApuesta, int dineroApuesta, string fechaApuesta, string tipoApuesta)
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
		public double CuotaApuesta { get; set; }
		public int DineroApuesta { get; set; }
		public string FechaApuesta { get; set; }
		public string TipoApuesta { get; set; }
	}

	public class ApuestaDTO
	{
		public ApuestaDTO(string emailUsuario, double cuotaApuesta, int dineroApuesta, string fechaApuesta, string tipoApuesta)
		{
			EmailUsuario = emailUsuario;
			CuotaApuesta = cuotaApuesta;
			DineroApuesta = dineroApuesta;
			FechaApuesta = fechaApuesta;
			TipoApuesta = tipoApuesta;
		}

		public string EmailUsuario { get; set; }
		public double CuotaApuesta { get; set; }
		public int DineroApuesta { get; set; }
		public string FechaApuesta { get; set; }
		public string TipoApuesta { get; set; }
	}
	public class ApuestaUsuario
	{
		public ApuestaUsuario(string emailUsuario, int idMercado, int dineroApuesta, string tipoApuesta)
		{
			EmailUsuario = emailUsuario;
			IdMercado = idMercado;
			DineroApuesta = dineroApuesta;
			TipoApuesta = tipoApuesta;
		}

		public string EmailUsuario { get; set; }
		public int IdMercado { get; set; }
		public int DineroApuesta { get; set; }
		public string TipoApuesta { get; set; }
	}

}