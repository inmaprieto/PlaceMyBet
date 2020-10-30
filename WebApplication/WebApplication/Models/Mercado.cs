using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace WebApplication.Models
{
	public class Mercado
	{
		public Mercado(int mercadoId, double cuotaOver, double cuotaUnder, int dineroOver, int dineroUnder, double tipo, int eventoId)
		{
			MercadoId = mercadoId;
			CuotaOver = cuotaOver;
			CuotaUnder = cuotaUnder;
			DineroOver = dineroOver;
			DineroUnder = dineroUnder;
			Tipo = tipo;
			EventoId = eventoId;
		}

		public int MercadoId { get; set; }
		public double CuotaOver { get; set; }
		public double CuotaUnder { get; set; }
		public int DineroOver { get; set; }
		public int DineroUnder { get; set; }
		public double Tipo { get; set; }
		public int EventoId { get; set; }


	}

	public class MercadoDTO
	{
		public MercadoDTO(double cuotaOver, double cuotaUnder, double tipo)
		{
			CuotaOver = cuotaOver;
			CuotaUnder = cuotaUnder;
			Tipo = tipo;
			
		}

		public double CuotaOver { get; set; }
		public double CuotaUnder { get; set; }
		public double Tipo { get; set; }
	}




}