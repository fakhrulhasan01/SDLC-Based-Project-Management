using System;
using System.Data;
using System.Data.SqlClient;
using ProjectManagementVerification.BLL;

namespace ProjectManagementVerification.DAL
{
    public class TeacherDb : GlobalDb
    {
        readonly GlobalDb _db = new GlobalDb();


        # region Save
        public bool Save(Teacher teacher)
        {
            var query = @"INSERT into teacher values (N'" + teacher.FullName + "', '"
                                                          + teacher.EmployeeId + "', '"
                                                          + teacher.Gender + "', '"
                                                          + teacher.Designation + "', '"
                                                          + teacher.Email + "', '"
                                                          + teacher.Password + "', '"
                                                          + teacher.Address + "', '"
                                                          + teacher.CityId + "', '"
                                                          + teacher.DepartmentId + "', '"
                                                          + teacher.Telephone + "', '"
                                                          + teacher.Mobile + "', '"
                                                          + teacher.JoinDate + "', '"
                                                          + teacher.Status + "', '"
                                                          + teacher.Picture + "', '"
                                                          + teacher.UserType + "')";
            return _db.SaveChanges(query);
        }
        #endregion



        # region ExistingValidationTeacher
        public bool ExistingValidationTeacher(string name, int countryId)
        {
            var query = "SELECT Name from Teacher where Name=N'" + name + "' and CountryId = " + countryId;
            return Existing_Validation(query);
        }
        #endregion



        #region Update
        public bool Update(Teacher teacher)
        {
            var query = @"UPDATE Teacher 
                                    SET
                                 FullName = N'" + teacher.FullName + "'," +
                               " EmployeeId = N'" + teacher.EmployeeId + "', "
                              + " Gender = N'" + teacher.Gender + "', "
                              + " Designation = N'" + teacher.Designation + "', "
                              + " Email = N'" + teacher.Email + "', "
                              + " Password = N'" + teacher.Password + "', "
                              + " Address = N'" + teacher.Address + "', "
                              + " CityId = '" + teacher.CityId + "', "
                              + " DepartmentId = '" + teacher.DepartmentId + "', "
                              + " Telephone = '" + teacher.Telephone + "', "
                              + " Mobile = '" + teacher.Mobile + "', "
                              + " JoinDate = '" + teacher.JoinDate + "', "
                              + " Status = '" + teacher.Status + "', "
                              + " Picture = '" + teacher.Picture + "', "
                              + " UserType = '" + teacher.UserType + "'" +
                              " WHERE Id = " + teacher.Id;
            return _db.SaveChanges(query);
            //return query;
        }
        #endregion



        #region Delete
        public bool Delete(Teacher teacher)
        {
            var query = "DELETE FROM Teacher WHERE Id = '" + teacher.Id + "'";
            return _db.SaveChanges(query);
        }
        #endregion



        #region GetData
        public DataTable GetData(string searchText, int type)
        {
            if (type == 0)
            {
                var query = @"SELECT t.Id, t.FullName, t.EmployeeId, t.Gender, t.Designation, t.Email, t.Password, t.Address, 
			                c.Name AS CityName, cn.Name AS CountryName, d.Name, t.Telephone, t.Mobile, 
			                t.JoinDate, t.Status, t.Picture, t.UserType FROM Teacher AS t INNER JOIN City AS c 
			                ON t.CityId = c.Id INNER JOIN Country AS cn ON c.CountryId = cn.Id INNER JOIN Department AS d
			                ON t.DepartmentId = d.Id
                                WHERE t.FullName LIKE '" + searchText + "%' ORDER BY t.Id DESC";
                var dt = _db.GetData(query);
                return dt;
            }
            else
            {
                const string query = @"SELECT t.Id, t.FullName, t.EmployeeId, t.Gender, t.Designation, t.Email, t.Password, t.Address, 
			                            c.Name AS CityName, cn.Name AS CountryName, d.Name, t.Telephone, t.Mobile, 
			                            t.JoinDate, t.Status, t.Picture, t.UserType FROM Teacher AS t INNER JOIN City AS c 
			                            ON t.CityId = c.Id INNER JOIN Country AS cn ON c.CountryId = cn.Id INNER JOIN Department AS d
                        			 ON t.DepartmentId = d.Id ORDER BY t.Id DESC";
                var dt = _db.GetData(query);
                return dt;
            }

        }
        #endregion



        #region SearchReport
        public DataTable Search(string name, string email, string teacherId, int cityId, int departmentId)
        {
            var query = @"SELECT t.Id, t.FullName, t.EmployeeId, t.Gender, t.Designation, t.Email, t.Password, t.Address, 
			            c.Name AS CityName, cn.Name AS CountryName, d.Name, t.Telephone, t.Mobile, 
			            t.JoinDate, t.Status, t.Picture, t.UserType FROM Teacher AS t INNER JOIN City AS c 
			            ON t.CityId = c.Id INNER JOIN Country AS cn ON c.CountryId = cn.Id INNER JOIN Department AS d
			            ON t.DepartmentId = d.Id
									WHERE t.CityId = c.Id";
            if (name != string.Empty)
            {
                query += " AND t.FullName = '" + name + "'";
            }
            if (email != string.Empty)
            {
                query += " AND t.Email = '" + email + "'";
            }
            if (cityId > 0)
            {
                query += " AND t.CityId = " + cityId;
            }
            if (departmentId > 0)
            {
                query += " AND t.DepartmentId = " + departmentId;
            }

            if (teacherId != string.Empty)
            {
                query += " AND t.EmployeeId = '" + teacherId + "'";
            }

            var dt = _db.GetData(query);
            return dt;
            //return query;
        }
        #endregion



        #region TeacherById
        public Teacher TeacherById(int id)
        {
            Teacher teacher = null;
            using (var connection = ConnectDb.GetSqlConnection())
            {
                var query = @"SELECT * FROM Teacher WHERE Id = '" + id + "'";
                var cmd = new SqlCommand(query, connection);
                connection.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        teacher = new Teacher
                        {
                            Id = Convert.ToInt32(reader["Id"].ToString()),
                            FullName = reader["FullName"].ToString(),
                            EmployeeId = reader["EmployeeId"].ToString(),
                            Gender = reader["Gender"].ToString(),
                            Designation = reader["Designation"].ToString(),
                            Email = reader["Email"].ToString(),
                            Password = reader["Password"].ToString(),
                            Address = reader["Address"].ToString(),
                            CityId = Convert.ToInt32(reader["CityId"]),
                            DepartmentId = Convert.ToInt32(reader["DepartmentId"]),
                            Telephone = reader["Telephone"].ToString(),
                            Mobile = reader["Mobile"].ToString(),
                            JoinDate = reader["JoinDate"].ToString(),
                            Status = reader["Status"].ToString(),
                            Picture = reader["Picture"].ToString(),
                            UserType = reader["UserType"].ToString()
                        };
                    }

                    connection.Close();
                }
            }
            return teacher;
        }
        #endregion



        #region TeacherByEmail
        public Teacher TeacherByEmail(string email)
        {
            Teacher teacher = null;
            using (var connection = ConnectDb.GetSqlConnection())
            {
                var query = @"SELECT * FROM Teacher WHERE Email = '" + email + "'";
                var cmd = new SqlCommand(query, connection);
                connection.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        teacher = new Teacher
                        {
                            Id = Convert.ToInt32(reader["Id"].ToString()),
                            FullName = reader["FullName"].ToString(),
                            EmployeeId = reader["EmployeeId"].ToString(),
                            Gender = reader["Gender"].ToString(),
                            Designation = reader["Designation"].ToString(),
                            Email = reader["Email"].ToString(),
                            Password = reader["Password"].ToString(),
                            Address = reader["Address"].ToString(),
                            CityId = Convert.ToInt32(reader["CityId"]),
                            DepartmentId = Convert.ToInt32(reader["DepartmentId"]),
                            Telephone = reader["Telephone"].ToString(),
                            Mobile = reader["Mobile"].ToString(),
                            JoinDate = reader["JoinDate"].ToString(),
                            Status = reader["Status"].ToString(),
                            Picture = reader["Picture"].ToString(),
                            UserType = reader["UserType"].ToString()
                        };
                    }

                    connection.Close();
                }
            }
            return teacher;
        }
        #endregion



        #region LoginTeacher
        public Teacher LoginTeacher(string email, string password)
        {
            Teacher teacher = null;
            using (var connection = ConnectDb.GetSqlConnection())
            {
                var query = @"SELECT * FROM Teacher WHERE Email = '" + email + "' AND Password = '" + password + "'";
                var cmd = new SqlCommand(query, connection);
                connection.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        teacher = new Teacher
                        {
                            Id = Convert.ToInt32(reader["Id"].ToString()),
                            FullName = reader["FullName"].ToString(),
                            EmployeeId = reader["EmployeeId"].ToString(),
                            Gender = reader["Gender"].ToString(),
                            Designation = reader["Designation"].ToString(),
                            Email = reader["Email"].ToString(),
                            Password = reader["Password"].ToString(),
                            Address = reader["Address"].ToString(),
                            CityId = Convert.ToInt32(reader["CityId"]),
                            DepartmentId = Convert.ToInt32(reader["DepartmentId"]),
                            Telephone = reader["Telephone"].ToString(),
                            Mobile = reader["Mobile"].ToString(),
                            JoinDate = reader["JoinDate"].ToString(),
                            Status = reader["Status"].ToString(),
                            Picture = reader["Picture"].ToString(),
                            UserType = reader["UserType"].ToString()
                        };
                    }

                    connection.Close();
                }
            }
            return teacher;
        }
        #endregion



    }
}