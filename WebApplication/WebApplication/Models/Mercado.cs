using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace WebApplication.Models
{
	public class Mercado
	{
		public Mercado(int mercadoId, decimal cuotaOver, decimal cuotaUnder, int dineroOver, int dineroUnder, decimal tipo, int eventoId)
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
		public decimal CuotaOver { get; set; }
		public decimal CuotaUnder { get; set; }
		public int DineroOver { get; set; }
		public int DineroUnder { get; set; }
		public decimal Tipo { get; set; }
		public int EventoId { get; set; }


	}

	public class MercadoDTO
	{
		public MercadoDTO(decimal cuotaOver, decimal cuotaUnder, decimal tipo)
		{
			CuotaOver = cuotaOver;
			CuotaUnder = cuotaUnder;
			Tipo = tipo;
			
		}

		public decimal CuotaOver { get; set; }
		public decimal CuotaUnder { get; set; }
		public decimal Tipo { get; set; }
	}




}