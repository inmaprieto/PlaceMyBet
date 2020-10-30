using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Web;

namespace WebApplication.Models
{
    public class ApuestasRepository
    {
        private MySqlConnection Connect()
        {
            /*Servidor = localhost*/
            string connString = "Server=127.0.0.1;Port=3306;Database=placemybet;Uid=root;password=;SslMode=none";
            MySqlConnection con = new MySqlConnection(connString);
            return con;
        }

        internal List<Apuesta> Retrieve()
        {
            MySqlConnection con = Connect();
            MySqlCommand command = con.CreateCommand();
            command.CommandText = "SELECT * FROM apuesta";

            try
            {
                con.Open();
                MySqlDataReader res = command.ExecuteReader();

                Apuesta a = null;
                List<Apuesta> apuestas = new List<Apuesta>();
                while (res.Read())
                {
                    //Debug.WriteLine("Recuperado: " + res.GetInt32(0) + " " + res.GetString(1) + " " + res.GetString(2) + " " + res.GetString(3));
                    a = new Apuesta(res.GetInt32(0), res.GetString(1), res.GetInt32(2), res.GetDouble(3), res.GetInt32(4),res.GetString(5),res.GetString(6));
                    apuestas.Add(a);
                }

                con.Close();
                return apuestas;
            }
            catch (MySqlException e)
            {
                Debug.WriteLine("Se ha producido un error al conectar con la base de datos");
                return null;
            }
        }

        internal List<ApuestaDTO> RetrieveDTO()
        {
            MySqlConnection con = Connect();
            MySqlCommand command = con.CreateCommand();
            command.CommandText = "SELECT * FROM apuesta";

            try
            {
                con.Open();
                MySqlDataReader res = command.ExecuteReader();

                ApuestaDTO a = null;
                List<ApuestaDTO> apuestas = new List<ApuestaDTO>();
                while (res.Read())
                {
                    //Debug.WriteLine("Recuperado: " + res.GetInt32(0) + " " + res.GetString(1) + " " + res.GetString(2) + " " + res.GetString(3));
                    a = new ApuestaDTO(res.GetString(1), res.GetDouble(3), res.GetInt32(4), res.GetString(5), res.GetString(6));
                    apuestas.Add(a);
                }

                con.Close();
                return apuestas;
            }
            catch (MySqlException e)
            {
                Debug.WriteLine("Se ha producido un error al conectar con la base de datos");
                return null;
            }
        }

        internal void Save(ApuestaUsuario ap) 
        {
           
            //string emailUsuario, int mercadoId, double cuotaApuesta, int dineroApuesta, string fechaApuesta, string tipoApuesta
            MySqlConnection con = Connect();
            MySqlCommand command = con.CreateCommand();
            // Recupero la cuota over o under 
            DateTime fecha_actual = DateTime.Now;
            Mercado mercadoOb = recuperarCuotaMercado(ap.IdMercado);
            // recupero la cuota correspondiente segun la apuesta realizada
            double cuota;
            if (ap.TipoApuesta.Equals("under"))
            {
                cuota = Math.Round(mercadoOb.CuotaUnder, 2);
            }
            else 
            {
                cuota = Math.Round(mercadoOb.CuotaOver, 2);
            }
            Debug.WriteLine(Math.Round(cuota, 2));
            Debug.WriteLine(mercadoOb.CuotaOver);
            Debug.WriteLine(mercadoOb.CuotaUnder);
        
            //INSERT de la apuesta
            command.CommandText = "INSERT INTO apuesta (email_usuario, id_mercado, cuota_apuesta, dinero_apuesta, fecha_apuesta, tipo_apuesta)" +
                " VALUES ('"+ap.EmailUsuario+ "','" + ap.IdMercado + "', '" + cuota + "', '" + ap.DineroApuesta + "', '" + fecha_actual + "', '" + ap.TipoApuesta + "' );";

            try
            {
                con.Open();
                command.ExecuteNonQuery();
                con.Close();
            }
            catch (MySqlException e)
            {
                Debug.WriteLine("Se ha producido un error de conexión");
            }

            ajusteCuotaDineroMercado(mercadoOb, ap);

        }

        internal void actualizarMercado(int idMercado, double cuota_over, double cuota_under, int dinero, string tipoApuesta)
        {
            string tipo_dinero;
            MySqlConnection con = Connect();
            MySqlCommand command = con.CreateCommand();
            if (tipoApuesta.Equals("under"))
            {
                tipo_dinero = "dinero_under";
            }
            else 
            {
                tipo_dinero = "dinero_over";
            }
            
            command.CommandText = "UPDATE mercado SET cuota_over=@CO, cuota_under=@CU, "+tipo_dinero+"=@D WHERE id_mercado = @ID";
            command.Parameters.AddWithValue("@CO",  cuota_over);
            command.Parameters.AddWithValue("@CU",  cuota_under);
            command.Parameters.AddWithValue("@D", dinero);
            command.Parameters.AddWithValue("@ID", idMercado);

            try
            {
                con.Open();
                command.ExecuteNonQuery();
                con.Close();
            }
            catch (MySqlException e)
            {
                Debug.WriteLine("Se ha producido un error de conexión");
            }

        }

        internal void ajusteCuotaDineroMercado(Mercado mercado, ApuestaUsuario apuesta) 
        {
            double prob_over, prob_under, nueva_cuota_over, nueva_cuota_under;
            double nuevo_dinero_apuesta;
            // modifico el dinero del mercado donde se ha realizado la apuesta          
            // recalcular nuevas cuotas over y under de probabilidad
            double sumaOverUnder = mercado.DineroOver + mercado.DineroUnder;
            if (apuesta.TipoApuesta.Equals("over"))
            {
                nuevo_dinero_apuesta = mercado.DineroOver + apuesta.DineroApuesta;
                prob_over = nuevo_dinero_apuesta / sumaOverUnder;
                prob_under =  mercado.DineroUnder / sumaOverUnder;
            }
            else
            {
                nuevo_dinero_apuesta = mercado.DineroUnder + apuesta.DineroApuesta;
                prob_over =  mercado.DineroOver / sumaOverUnder;
                prob_under =  nuevo_dinero_apuesta / sumaOverUnder;
            }

          /*
            Debug.WriteLine(sumaOverUnder);
            Debug.WriteLine(nuevo_dinero_apuesta);
            Debug.WriteLine(prob_over);
            Debug.WriteLine(prob_under);
            Debug.WriteLine(mercado.DineroOver);
            Debug.WriteLine(mercado.DineroUnder);
          */

            // recalcular las nuevas cuotas del mercado segun probabilidad
            nueva_cuota_over = (1 / prob_over) * 0.95;
            nueva_cuota_under = (1 / prob_under) * 0.95;

            // actualizar datos en el mercado
          //  Debug.WriteLine(Math.Round(nueva_cuota_over, 2));
         //   Debug.WriteLine(Math.Round(nueva_cuota_under, 2));

            actualizarMercado(mercado.MercadoId, Math.Round(nueva_cuota_over, 2), Math.Round(nueva_cuota_under, 2), (int) nuevo_dinero_apuesta, apuesta.TipoApuesta);

        }

        internal Mercado recuperarCuotaMercado(int idMercado) 
        {
            MySqlConnection con = Connect();
            MySqlCommand command = con.CreateCommand();
            Mercado mercado = null;
            // Debug.WriteLine(fecha_actual.ToString());
            command.CommandText = "SELECT * FROM mercado WHERE id_mercado = " + idMercado;

            try
            {
                con.Open();
                MySqlDataReader res = command.ExecuteReader();
                while (res.Read())
                {
                    mercado = new Mercado(res.GetInt32(0), res.GetDouble(1), res.GetDouble(2), res.GetInt32(3), res.GetInt32(4), res.GetDouble(5), res.GetInt32(6));
                }
              //  Debug.WriteLine("La cuota de mercado " + ap.TipoApuesta + " es " + cuota);
                con.Close();
            }
            catch (MySqlException e)
            {
                Debug.WriteLine("Se ha producido un error de conexión");
            }
            return mercado;
        }
    }
}