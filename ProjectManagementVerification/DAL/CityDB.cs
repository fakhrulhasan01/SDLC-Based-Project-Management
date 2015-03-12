using System;
using System.Data;
using System.Data.SqlClient;
using ProjectManagementVerification.BLL;

namespace ProjectManagementVerification.DAL
{
    public class CityDb : GlobalDb
    {
        readonly GlobalDb _db = new GlobalDb();


        # region Save
        public bool Save(City city)
        {
            var query = "INSERT into city values (N'" + city.Name + "', '"+city.CountryId+"')";
            return _db.SaveChanges(query);
        }
        #endregion



        # region ExistingValidationCity
        public bool ExistingValidationCity(string name, int countryId)
        {
            var query = "SELECT Name from City where Name=N'" + name + "' and CountryId = "+countryId;
            return Existing_Validation(query);
        }
        #endregion



        #region Update
        public bool Update(City city)
        {
            var query = @"UPDATE City 
                                    SET
                                 Name = N'" + city.Name + "'," +
                                 " CountryId = N'" + city.CountryId + "'" +
                                 " WHERE Id = '" + city.Id + "'";
            return _db.SaveChanges(query);
        }
        #endregion



        #region Delete
        public bool Delete(City city)
        {
            var query = "DELETE FROM City WHERE Id = '" + city.Id + "'";
            return _db.SaveChanges(query);
        }
        #endregion



        #region GetData
        public DataTable GetData(string searchText, int type)
        {
            if (type == 0)
            {
                var query = @"SELECT c.Id, c.Name as CityName, cn.Name as CountryName 
                                            FROM City c INNER JOIN Country cn 
                                                    ON
                                            c.CountryId = cn.Id
                                            WHERE c.Name LIKE '" + searchText + "%' ORDER BY Id DESC";
                var dt = _db.GetData(query);
                return dt;
            }
            else
            {
                const string query = @"SELECT c.Id, c.Name as CityName, cn.Name as CountryName 
                                            FROM City c INNER JOIN Country cn 
                                                    ON
                                            c.CountryId = cn.Id";
                var dt = _db.GetData(query);
                return dt;
            }

        }
        #endregion



        #region SearchReport
        public DataTable Search(string name, int countryId)
        {
            var query = @"SELECT c.Id, c.Name as CityName, cn.Name as CountryName 
                                            FROM City c INNER JOIN Country cn 
                                                    ON
                                            c.CountryId = cn.Id WHERE cn.Id = c.CountryId";
            if (name != string.Empty)
            {
                query += " AND c.Name = '"+name+"'";
            }
            if (countryId != 0)
            {
                query += " AND c.CountryId = " + countryId ;
            }
                var dt = _db.GetData(query);
                return dt;
        }
        #endregion



        #region CityById
        public City CityById(int id)
        {
            City city = null;
            using (var connection = ConnectDb.GetSqlConnection())
            {
                var query = @"SELECT [ID], [Name], [CountryId] FROM City WHERE Id = '" + id + "'";
                var cmd = new SqlCommand(query, connection);
                connection.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        city = new City
                        {
                            Id = Convert.ToInt32(reader["Id"].ToString()),
                            Name = reader["Name"].ToString(),
                            CountryId = Convert.ToInt32(reader["CountryId"])
                        };
                    }

                    connection.Close();
                }
            }
            return city;
        }
        #endregion



    }
}