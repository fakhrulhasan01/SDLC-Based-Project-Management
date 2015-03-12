using System;
using System.Data;
using System.Data.SqlClient;
using ProjectManagementVerification.BLL;

namespace ProjectManagementVerification.DAL
{
    public class ProjectTypeDb : GlobalDb
    {
        readonly GlobalDb _db = new GlobalDb();


        # region Save
        public bool Save(ProjectType projectType)
        {
            var query = "INSERT into projectType values ('" + projectType.Name + "', '"+projectType.Description+"')";
            return _db.SaveChanges(query);
        }
        #endregion



        # region ExistingValidationProjectType
        public bool ExistingValidationProjectType(string name)
        {
            var query = "SELECT Name from ProjectType where Name='" + name + "'";
            return Existing_Validation(query);
        }
        #endregion



        #region Update
        public bool Update(ProjectType projectType)
        {
            var query = @"UPDATE ProjectType 
                                    SET
                                 Name = '" + projectType.Name + "'," +
                                 " Description = '" + projectType.Description + "'" +
                                 " WHERE Id = '" + projectType.Id + "'";
            return _db.SaveChanges(query);
        }
        #endregion



        #region Delete
        public bool Delete(ProjectType projectType)
        {
            var query = "DELETE FROM ProjectType WHERE Id = '" + projectType.Id + "'";
            return _db.SaveChanges(query);
        }
        #endregion



        #region GetData
        public DataTable GetData(string searchText, int type)
        {
            if (type == 0)
            {
                var query = @"SELECT Id, Name, Description FROM ProjectType 
                              WHERE Name 
                            LIKE '%" + searchText + "%' OR Description LIKE '%"+searchText+"%' ORDER BY Id DESC";
                var dt = _db.GetData(query);
                return dt;
            }
            else
            {
                const string query = @"SELECT Id, Name, Description FROM ProjectType ORDER BY Id DESC";
                var dt = _db.GetData(query);
                return dt;
            }

        }
        #endregion



        #region SearchReport
        public DataTable Search(string name, int id)
        {
            var query = @"SELECT Id, Name, Description FROM ProjectType WHERE Id = Id";
            if (name != string.Empty)
            {
                query += " AND Name = '" + name + "'";
            }
            if (id != 0)
            {
                query += " AND Id = " + id;
            }
            var dt = _db.GetData(query);
            return dt;
        }
        #endregion



        #region ProjectTypeById
        public ProjectType ProjectTypeById(int id)
        {
            ProjectType projectType = null;
            using (var connection = ConnectDb.GetSqlConnection())
            {
                var query = @"SELECT [ID], [Name], [Description] FROM ProjectType WHERE Id = '" + id + "'";
                var cmd = new SqlCommand(query, connection);
                connection.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        projectType = new ProjectType
                        {
                            Id = Convert.ToInt32(reader["Id"].ToString()),
                            Name = reader["Name"].ToString(),
                            Description = reader["Description"].ToString()
                        };
                    }

                    connection.Close();
                }
            }
            return projectType;
        }
        #endregion


    }
}