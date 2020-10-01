using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace WebApplication.Models
{
    public class Evento
    {
		public Evento(int eventoId, string equipoLocal, string equipoVisitante, string fechaEvento)
		{
			EventoId = eventoId;
			EquipoLocal = equipoLocal;
			EquipoVisitante = equipoVisitante;
			FechaEvento = fechaEvento;
		}

		public int EventoId { get; set; }
		public string EquipoLocal { get; set; }
		public string EquipoVisitante { get; set; }
		public string FechaEvento { get; set; }
	}

	


}