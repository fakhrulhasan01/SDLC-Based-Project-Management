using System;
using System.Data;
using System.Data.SqlClient;
using ProjectManagementVerification.BLL;

namespace ProjectManagementVerification.DAL
{
    public class CountryDb : GlobalDb
    {
        readonly GlobalDb _db = new GlobalDb();

        
        # region Save
        public bool Save(Country country)
        {
            var query = "INSERT into country values (N'" + country.Name + "')";
            return _db.SaveChanges(query);
        }
        #endregion



        # region ExistingValidationCountry
        public bool ExistingValidationCountry(string name)
        {
            var query = "SELECT Name from Country where Name=N'" + name + "'";
            return Existing_Validation(query);
        }
        #endregion



        #region Update
        public bool Update(Country country)
        {
            var query = @"UPDATE Country 
                                    SET
                                 Name = N'"+country.Name+"'" +
                                 " WHERE Id = '"+country.Id+"'";
            return _db.SaveChanges(query);
        }
        #endregion



        #region Delete
        public bool Delete(Country country)
        {
            var query = "DELETE FROM Country WHERE Id = '"+country.Id+"'";
            return _db.SaveChanges(query);
        }
        #endregion



        #region GetData
        public DataTable GetData(string searchText, int type)
        {
            if (type == 0)
            {
                var query = "SELECT * FROM Country WHERE Name LIKE '"+searchText+"%' ORDER BY Id DESC";
                var dt = _db.GetData(query);
                return dt;
            }
            else
            {
                const string query = @"SELECT * FROM Country ORDER BY Id DESC";
                var dt = _db.GetData(query);
                return dt;
            }

        }
        #endregion



        #region SearchReport
        public DataTable Search()
        {
            DataTable dt = null;
            return dt;
        }
        #endregion



        #region CountryById
        public Country CountryById(int id)
        {
            Country country = null;
            using (var connection = ConnectDb.GetSqlConnection())
            {
                var query = @"SELECT [ID], [Name] FROM Country WHERE Id = '"+id+"'";
                var cmd = new SqlCommand(query, connection);
                connection.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        country = new Country
                        {
                            Id = Convert.ToInt32(reader["Id"].ToString()),
                            Name = reader["Name"].ToString()
                        };
                    }

                    connection.Close();
                }
            }
            return country;

        }
        #endregion



    }
}