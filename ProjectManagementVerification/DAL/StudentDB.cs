using System;
using System.Data;
using System.Data.SqlClient;
using ProjectManagementVerification.BLL;

namespace ProjectManagementVerification.DAL
{
    public class StudentDb : GlobalDb
    {
        readonly GlobalDb _db = new GlobalDb();


        # region Save
        public bool Save(Student student)
        {
            var query = @"INSERT into student values (N'" + student.FullName + "', '"
                                                          + student.StudentId + "', '"
                                                          + student.FatherName + "', '"
                                                          + student.MotherName + "', '"
                                                          + student.Gender + "', '"
                                                          + student.Email + "', '"
                                                          + student.Password + "', '"
                                                          + student.Address + "', '"
                                                          + student.CityId + "', '"
                                                          + student.DepartmentId + "', '"
                                                          + student.Telephone + "', '"
                                                          + student.Mobile + "', '"
                                                          + student.SemisterInfo + "', '"
                                                          + student.DateOfBirth + "', '"
                                                          + student.JoinDate + "', '"
                                                          + student.Status + "', '"
                                                          + student.Picture + "')";
            return _db.SaveChanges(query);
        }
        #endregion



        # region ExistingValidationStudent
        public bool ExistingValidationStudent(string name, int countryId)
        {
            var query = "SELECT Name from Student where Name=N'" + name + "' and CountryId = " + countryId;
            return Existing_Validation(query);
        }
        #endregion



        #region Update
        public bool Update(Student student)
        {
            var query = @"UPDATE Student 
                                    SET
                                 FullName = N'" + student.FullName + "'," +
                               " StudentId = N'" + student.StudentId + "', "
                              +" FatherName = N'" + student.FatherName + "', "
                              +" MotherName = N'" + student.MotherName + "', "
                              +" Gender = N'" + student.Gender + "', "
                              +" Email = N'" + student.Email + "', "
                              +" Password = N'" + student.Password + "', "
                              +" Address = N'" + student.Address + "', "
                              +" CityId = '" + student.CityId + "', "
                              +" DepartmentId = '" + student.DepartmentId + "', "
                              +" Telephone = '" + student.Telephone + "', "
                              +" Mobile = '" + student.Mobile + "', "
                              +" SemisterInfo = '" + student.SemisterInfo + "', "
                              +" DateOfBirth = '" + student.DateOfBirth + "', "
                              +" Status = '" + student.Status + "', "
                              +" Picture = '" + student.Picture + "'" +
                              " WHERE Id = "+student.Id;
            return _db.SaveChanges(query);
            //return query;
        }
        #endregion



        #region Delete
        public bool Delete(Student student)
        {
            var query = "DELETE FROM Student WHERE Id = '" + student.Id + "'";
            return _db.SaveChanges(query);
        }
        #endregion



        #region GetData
        public DataTable GetData(string searchText, int type)
        {
            if (type == 0)
            {
                var query = @"SELECT  s.[Id], s.[FullName], s.[StudentId], s.[FatherName], s.[MotherName], 
                            s.[Gender], s.[Email], s.[Password], s.[Address], c.[Name] as CityName, 
                            cn.Name as CountryName, d.[Name] as DepartmentName, s.[Telephone], s.[Mobile], 
                            s.[SemisterInfo], s.[DateOfBirth], s.[JoinDate], s.[Status], s.[Picture]
			                    FROM [Student] s INNER JOIN City c ON s.CityId = c.Id 
			                    INNER JOIN Country cn ON c.CountryId = cn.Id
			                    INNER JOIN Department d ON s.DepartmentId = d.Id 
                                WHERE s.FullName LIKE '" + searchText + "%' ORDER BY s.Id DESC";
                var dt = _db.GetData(query);
                return dt;
            }
            else
            {
                const string query = @"SELECT  s.[Id], s.[FullName], s.[StudentId], s.[FatherName], s.[MotherName], 
                                    s.[Gender], s.[Email], s.[Password], s.[Address], c.[Name] as CityName, 
                                    cn.Name as CountryName, d.[Name] as DepartmentName, s.[Telephone], s.[Mobile], 
                                    s.[SemisterInfo], s.[DateOfBirth], s.[JoinDate], s.[Status], s.[Picture]
			                            FROM [Student] s INNER JOIN City c ON s.CityId = c.Id 
			                        INNER JOIN Country cn ON c.CountryId = cn.Id
			                        INNER JOIN Department d ON s.DepartmentId = d.Id ORDER BY s.Id DESC"; 
                var dt = _db.GetData(query);
                return dt;
            }

        }
        #endregion



        #region SearchReport
        public DataTable Search(string name, string email, string studentId, int cityId, int departmentId)
        {
            var query = @"SELECT  s.[Id], s.[FullName], s.[StudentId], s.[FatherName], s.[MotherName], 
                            s.[Gender], s.[Email], s.[Password], s.[Address], c.[Name] as CityName, 
                            cn.Name as CountryName, d.[Name] as DepartmentName, s.[Telephone], s.[Mobile], 
                            s.[SemisterInfo], s.[DateOfBirth], s.[JoinDate], s.[Status], s.[Picture]
			                    FROM [Student] s INNER JOIN City c ON s.CityId = c.Id 
			                    INNER JOIN Country cn ON c.CountryId = cn.Id
			                    INNER JOIN Department d ON s.DepartmentId = d.Id 
									WHERE s.CityId = c.Id";
            if (name != string.Empty)
            {
                query += " AND s.Name = '" + name + "'";
            }
            if (email != string.Empty)
            {
                query += " AND s.Email = '" + email +"'";
            }
            if (cityId > 0)
            {
                query += " AND s.CityId = " + cityId;
            }
            if (departmentId > 0)
            {
                query += " AND s.DepartmentId = " + departmentId;
            }

            if (studentId != string.Empty)
            {
                query += " AND s.StudentId = '" + studentId + "'";
            }

            var dt = _db.GetData(query);
            return dt;
            //return query;
        }
        #endregion



        #region StudentById
        public Student StudentById(int id)
        {
            Student student = null;
            using (var connection = ConnectDb.GetSqlConnection())
            {
                var query = @"SELECT * FROM Student WHERE Id = '" + id + "'";
                var cmd = new SqlCommand(query, connection);
                connection.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        student = new Student
                        {
                            Id = Convert.ToInt32(reader["Id"].ToString()),
                            FullName = reader["FullName"].ToString(),
                            StudentId = reader["StudentId"].ToString(),
                            FatherName = reader["FatherName"].ToString(),
                            MotherName = reader["MotherName"].ToString(),
                            Gender = reader["Gender"].ToString(),
                            Email = reader["Email"].ToString(),
                            Password = reader["Password"].ToString(),
                            Address = reader["Address"].ToString(),
                            CityId = Convert.ToInt32(reader["CityId"]),
                            DepartmentId = Convert.ToInt32(reader["DepartmentId"]),
                            Telephone = reader["Telephone"].ToString(),
                            Mobile = reader["Mobile"].ToString(),
                            SemisterInfo = reader["SemisterInfo"].ToString(),
                            DateOfBirth = reader["DateOfBirth"].ToString(),
                            JoinDate = reader["JoinDate"].ToString(),
                            Status = reader["Status"].ToString(),
                            Picture = reader["Picture"].ToString()
                        };
                    }

                    connection.Close();
                }
            }
            return student;
        }
        #endregion


        
        #region StudentByEmail
        public Student StudentByEmail(string email)
        {
            Student student = null;
            using (var connection = ConnectDb.GetSqlConnection())
            {
                var query = @"SELECT * FROM Student WHERE Email = '" + email + "'";
                var cmd = new SqlCommand(query, connection);
                connection.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        student = new Student
                        {
                            Id = Convert.ToInt32(reader["Id"].ToString()),
                            FullName = reader["FullName"].ToString(),
                            StudentId = reader["StudentId"].ToString(),
                            FatherName = reader["FatherName"].ToString(),
                            MotherName = reader["MotherName"].ToString(),
                            Gender = reader["Gender"].ToString(),
                            Email = reader["Email"].ToString(),
                            Password = reader["Password"].ToString(),
                            Address = reader["Address"].ToString(),
                            CityId = Convert.ToInt32(reader["CityId"]),
                            DepartmentId = Convert.ToInt32(reader["DepartmentId"]),
                            Telephone = reader["Telephone"].ToString(),
                            Mobile = reader["Mobile"].ToString(),
                            SemisterInfo = reader["SemisterInfo"].ToString(),
                            DateOfBirth = reader["DateOfBirth"].ToString(),
                            JoinDate = reader["JoinDate"].ToString(),
                            Status = reader["Status"].ToString(),
                            Picture = reader["Picture"].ToString()
                        };
                    }

                    connection.Close();
                }
            }
            return student;
        }
        #endregion



        #region LoginStudent
        public Student LoginStudent(string email, string password)
        {
            Student student = null;
            using (var connection = ConnectDb.GetSqlConnection())
            {
                var query = @"SELECT * FROM Student WHERE Email = '" + email + "' AND Password = '"+password+"'";
                var cmd = new SqlCommand(query, connection);
                connection.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        student = new Student
                        {
                            Id = Convert.ToInt32(reader["Id"].ToString()),
                            FullName = reader["FullName"].ToString(),
                            StudentId = reader["StudentId"].ToString(),
                            FatherName = reader["FatherName"].ToString(),
                            MotherName = reader["MotherName"].ToString(),
                            Gender = reader["Gender"].ToString(),
                            Email = reader["Email"].ToString(),
                            Password = reader["Password"].ToString(),
                            Address = reader["Address"].ToString(),
                            CityId = Convert.ToInt32(reader["CityId"]),
                            DepartmentId = Convert.ToInt32(reader["DepartmentId"]),
                            Telephone = reader["Telephone"].ToString(),
                            Mobile = reader["Mobile"].ToString(),
                            SemisterInfo = reader["SemisterInfo"].ToString(),
                            DateOfBirth = reader["DateOfBirth"].ToString(),
                            JoinDate = reader["JoinDate"].ToString(),
                            Status = reader["Status"].ToString(),
                            Picture = reader["Picture"].ToString()
                        };
                    }

                    connection.Close();
                }
            }
            return student;
        }
        #endregion




    }
}