using System;
using System.Data;
using System.Data.SqlClient;
using ProjectManagementVerification.BLL;

namespace ProjectManagementVerification.DAL
{
    public class ProductsDb : GlobalDb
    {
        readonly GlobalDb _db = new GlobalDb();

        public bool Save(Products products)
        {
            var query = "INSERT into products values (N'" + products.Name + "','" + products.Price + "', '"+products.Quantity+"')";
            return _db.SaveChanges(query);
        }


        public bool Update(Products products)
        {
            var query = @"UPDATE Products 
                                    SET
                                 Name = '"+products.Name+"'," +
                                 "Price = '"+products.Price+"'," +
                                 "Quantity = '"+products.Quantity+"'" +
                                 "WHERE Id = '"+products.Id+"'";
            return _db.SaveChanges(query);
        }


        public bool Delete(Products products)
        {
            var query = "DELETE FROM Products WHERE Id = '"+products.Id+"'";
            return _db.SaveChanges(query);
        }



        public DataTable GetData(string searchText, int type)
        {
            if (type == 0)
            {
                var query = "SELECT * FROM Products WHERE Name LIKE '"+searchText+"%'";
                var dt = _db.GetData(query);
                return dt;
                
            }
            else
            {
                const string query = @"SELECT * FROM Products ORDER BY Id DESC";
                var dt = _db.GetData(query);
                return dt;
                
            }

        }




        public DataTable Search()
        {
            DataTable dt = null;
            return dt;
        }
        


        public Products ProductById(int id)
        {
            Products products = null;
            using (var connection = ConnectDb.GetSqlConnection())
            {
                var oString = @"SELECT [ID], [Name], [Price], [Quantity] FROM Products WHERE Id = '"+id+"'";
                var oCmd = new SqlCommand(oString, connection);
                connection.Open();
                using (var reader = oCmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        products = new Products
                        {
                            Id = Convert.ToInt32(reader["Id"].ToString()),
                            Name = reader["Name"].ToString(),
                            Price = float.Parse(reader["Price"].ToString()),
                            Quantity = Convert.ToInt32(reader["Quantity"].ToString())
                        };
                    }

                    connection.Close();
                }
            }
            return products;

        }


    }

}