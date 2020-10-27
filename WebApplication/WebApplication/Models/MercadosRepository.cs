using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;

namespace WebApplication.Models
{
    public class MercadosRepository
    {
        private MySqlConnection Connect()
        {
            /*Servidor = localhost*/
            string connString = "Server=127.0.0.1;Port=3306;Database=placemybet;Uid=root;password=;SslMode=none";
            MySqlConnection con = new MySqlConnection(connString);
            return con;
        }

        internal List<Mercado> Retrieve()
        {
            MySqlConnection con = Connect();
            MySqlCommand command = con.CreateCommand();
            command.CommandText = "SELECT * FROM mercado";

            try
            {
                con.Open();
                MySqlDataReader res = command.ExecuteReader();

                Mercado m = null;
                List<Mercado> mercados = new List<Mercado>();
                while (res.Read())
                {
                    //Debug.WriteLine("Recuperado: " + res.GetInt32(0) + " " + res.GetString(1) + " " + res.GetString(2) + " " + res.GetString(3));
                    m = new Mercado(res.GetInt32(0), res.GetDecimal(1), res.GetDecimal(2), res.GetInt32(3),res.GetInt32(4),res.GetDecimal(5),res.GetInt32(6));
                    mercados.Add(m);
                }

                con.Close();
                return mercados;
            }
            catch (MySqlException e)
            {
                Debug.WriteLine("Se ha producido un error al conectar con la base de datos");
                return null;
            }
        }

        internal List<MercadoDTO> RetrieveDTO()
        {
            MySqlConnection con = Connect();
            MySqlCommand command = con.CreateCommand();
            command.CommandText = "SELECT * FROM mercado";

            try
            {
                con.Open();
                MySqlDataReader res = command.ExecuteReader();

                MercadoDTO m = null;
                List<MercadoDTO> mercados = new List<MercadoDTO>();
                while (res.Read())
                {
                    //Debug.WriteLine("Recuperado: " + res.GetInt32(0) + " " + res.GetString(1) + " " + res.GetString(2) + " " + res.GetString(3));
                    m = new MercadoDTO( res.GetDecimal(1), res.GetDecimal(2), res.GetDecimal(5));
                    mercados.Add(m);
                }

                con.Close();
                return mercados;
            }
            catch (MySqlException e)
            {
                Debug.WriteLine("Se ha producido un error al conectar con la base de datos");
                return null;
            }
        }


    }
}