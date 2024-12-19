using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.IO;
using PHCLT.Models;
using System.Dynamic;

namespace PHCLT.Controllers
{
    public class ClsSystem
    {
        public int companyid;
        SqlConnection cn = new SqlConnection();

        //public static System.Object IO { get; internal set; }

        public Int32 excute(string sql)
        {
            cn.ConnectionString=ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
            SqlCommand cmd = new SqlCommand(sql, cn);
            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();
            return 0;
        }

        public DataTable Returntable(string sql)
        {
            DataTable dt=null;
            cn.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
            SqlDataAdapter adp = new SqlDataAdapter(sql, cn);
            cn.Open();
            DataSet  ds=new DataSet();
            adp.Fill(ds);
            cn.Close();
            dt = ds.Tables[0];
            return dt;
        }

        public List<dynamic> ReturnDataList(string sql)
        {
            List<dynamic> dataList = new List<dynamic>();

            cn.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
            SqlDataAdapter adp = new SqlDataAdapter(sql, cn);

            try
            {
                cn.Open();
                DataSet ds = new DataSet();
                adp.Fill(ds);

                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    dynamic dataObject = new ExpandoObject();
                    var dataDictionary = (IDictionary<string, object>)dataObject;

                    foreach (DataColumn col in ds.Tables[0].Columns)
                    {
                        dataDictionary[col.ColumnName] = row[col.ColumnName];
                    }

                    dataList.Add(dataObject);
                }
            }
            finally
            {
                cn.Close();
            }

            return dataList;
        }

        public String FindOneString(string sql)
        {
            string Onestr = "";
            cn.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
            SqlDataAdapter adp = new SqlDataAdapter(sql, cn);
            cn.Open();
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            adp.Fill(ds);
            cn.Close();
            dt = ds.Tables[0];
            if (dt.Rows.Count > 0) 
                {
                Onestr = dt.Rows[0][0].ToString();
                }
                
            return Onestr;
        }


        public Int32 ExecuteScalar(string sql)
        {
            cn.ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
            SqlCommand cmd = new SqlCommand(sql, cn);
            cn.Open();
            int count = Convert.ToInt32(cmd.ExecuteScalar());
            cn.Close();
            return count;
        }

        public void DeleteFilesInFolder(string filePath)
        {
            try
            {
                // Check if the folder exists
                if (File.Exists(filePath))
                {
                    File.Delete(filePath);
                    Console.WriteLine($"File  deleted successfully.");
                }
                else
                {
                    Console.WriteLine($"File not found");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error deleting files: {ex.Message}");
            }
        }

        public string DateConversion(string sDate)
        {
            if (sDate.Trim().Length == 10)
            {
                sDate = $"{sDate.Substring(3, 2)}/{sDate.Substring(0, 2)}/{sDate.Substring(6, 4)}";
            }
            else if (sDate.Trim().Length > 10)
            {
                sDate = $"{sDate.Substring(3, 2)}/{sDate.Substring(0, 2)}/{sDate.Substring(6, 4)}";
            }
            else if (sDate.Trim().Length == 9)
            {
                if (sDate.Substring(1, 1) == "/")
                {
                    sDate = $"{sDate.Substring(2, 2)}/{sDate.Substring(0, 1)}/{sDate.Substring(5, 4)}";
                }
                else
                {
                    sDate = $"{sDate.Substring(3, 1)}/{sDate.Substring(0, 2)}/{sDate.Substring(5, 4)}";
                }
            }
            else if (sDate.Trim().Length == 8)
            {
                sDate = $"{sDate.Substring(2, 1)}/{sDate.Substring(0, 1)}/{sDate.Substring(4, 4)}";
            }

            return sDate;
        }

        public LoginResponse VerifyUser(string UserName, string Password)
        {
            try
            {
                LoginResponse loginResponse = new LoginResponse
                {
                    UserType = "",  // Set the initial values
                    Username = "",
                    UserId = 0,
                    CustomerId = 0
                };

                string userName = UserName;

                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ToString()))
                {
                    connection.Open();

                    string stringUserQuery = "SELECT UserName, UserId,UsesFullname FROM UserMaster WHERE UserName = @UserName AND Password = @Password";                    

                    using (SqlCommand command = new SqlCommand(stringUserQuery, connection))
                    {
                        command.Parameters.AddWithValue("@UserName", userName);
                        command.Parameters.AddWithValue("@Password", Password);

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                // Read values for Admin user
                                reader.Read();
                                loginResponse.UserType = "Admin";
                                loginResponse.Username = reader["UserName"].ToString();
                                loginResponse.UserId = Convert.ToInt32(reader["UserId"]);
                                loginResponse.UsesFullname = reader["UsesFullname"].ToString();
                            }
                        }
                    }
                    
                    return loginResponse;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public LoginResponse CheckUserSubScription(dynamic UserId)
        {
            try
            {
                LoginResponse loginResponse = new LoginResponse
                {
                    UserType = "",  
                    Username = "",
                    UserId = 0,
                    CustomerId = 0,
                    UserSubdate = null
                };

                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ToString()))
                {
                    connection.Open();

                    string stringUserQuery = "SELECT UserSubdate FROM UserMaster WHERE UserId = @UserId";

                    using (SqlCommand command = new SqlCommand(stringUserQuery, connection))
                    {
                        command.Parameters.AddWithValue("@UserId", UserId);

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.HasRows)
                            {
                                reader.Read();
                                loginResponse.UserType = "Admin";
                                DateTime userSubdate = Convert.ToDateTime(reader["UserSubdate"]);

                                if (userSubdate.Date >= DateTime.Now.Date)
                                {
                                    loginResponse.UserSubdate = userSubdate.ToString("dd/MM/yyyy");
                                }
                            }
                        }
                    }

                    return loginResponse;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}