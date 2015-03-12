using System;
using System.Data;
using System.Data.SqlClient;
using ProjectManagementVerification.BLL;

namespace ProjectManagementVerification.DAL
{
    public class DepartmentDb : GlobalDb
    {

        readonly GlobalDb _db = new GlobalDb();


        # region Save
        public bool Save(Department department)
        {
            var query = "INSERT into department values (N'" + department.Name + "')";
            return _db.SaveChanges(query);
        }
        #endregion



        # region ExistingValidationDepartment
        public bool ExistingValidationDepartment(string name)
        {
            var query = "SELECT Name from Department where Name=N'" + name + "'";
            return Existing_Validation(query);
        }
        #endregion



        #region Update
        public bool Update(Department department)
        {
            var query = @"UPDATE Department 
                                    SET
                                 Name = N'" + department.Name + "'" +
                                 " WHERE Id = '" + department.Id + "'";
            return _db.SaveChanges(query);
        }
        #endregion



        #region Delete
        public bool Delete(Department department)
        {
            var query = "DELETE FROM Department WHERE Id = '" + department.Id + "'";
            return _db.SaveChanges(query);
        }
        #endregion



        #region GetData
        public DataTable GetData(string searchText, int type)
        {
            if (type == 0)
            {
                var query = "SELECT * FROM Department WHERE Name LIKE '" + searchText + "%' ORDER BY Id DESC";
                var dt = _db.GetData(query);
                return dt;
            }
            else
            {
                const string query = @"SELECT * FROM Department ORDER BY Id DESC";
                var dt = _db.GetData(query);
                return dt;
            }

        }
        #endregion



        #region SearchReport
        public DataTable Search(string name, int id)
        {
            var query = @"SELECT  * FROM Department WHERE Id = Id";
            if (name != string.Empty)
            {
                query += " AND Name = '" + name + "'";
            }
            if (id > 0)
            {
                query += " AND Id = " + id;
            }
            
            var dt = _db.GetData(query);
            return dt;
        }
        #endregion



        #region DepartmentById
        public Department DepartmentById(int id)
        {
            Department department = null;
            using (var connection = ConnectDb.GetSqlConnection())
            {
                var query = @"SELECT [ID], [Name] FROM Department WHERE Id = '" + id + "'";
                var cmd = new SqlCommand(query, connection);
                connection.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        department = new Department
                        {
                            Id = Convert.ToInt32(reader["Id"].ToString()),
                            Name = reader["Name"].ToString()
                        };
                    }

                    connection.Close();
                }
            }
            return department;

        }
        #endregion


    }
}