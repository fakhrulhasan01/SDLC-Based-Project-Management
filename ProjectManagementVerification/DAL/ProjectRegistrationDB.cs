using System;
using System.Data;
using System.Data.SqlClient;
using ProjectManagementVerification.BLL;

namespace ProjectManagementVerification.DAL
{
    public class ProjectRegistrationDb : GlobalDb
    {
        private readonly GlobalDb _db = new GlobalDb();
        
        
        # region Save
        public bool Save(ProjectRegistration projectRegistration)
        {
            var query = "INSERT INTO ProjectRegistration values ('" + projectRegistration.ProjectTitle + "', '"
                                                            + projectRegistration.ProjectSummary + "', "
                                                            + projectRegistration.GroupId + ", "
                                                            + projectRegistration.TeacherId + ", "
                                                            + projectRegistration.ProjectTypeId + ", '"
                                                            + projectRegistration.RegistrationDate + "', '"
                                                            + projectRegistration.Status + "', '"
                                                            + projectRegistration.ProgressStatus + "')";

            return _db.SaveChanges(query);
            //return query;
        }
        #endregion



        # region ExistingValidationProjectRegistration
        public bool ExistingValidationProjectRegistration(int groupId)
        {
            var query = @"SELECT ProjectTitle from ProjectRegistration 
                                    where 
                        GroupId=" + groupId;
            return Existing_Validation(query);
        }
        #endregion



        #region Update
        public bool Update(ProjectRegistration projectRegistration, string exist)
        {
            if (exist == "No")
            {
                var query = @"UPDATE ProjectRegistration 
                                    SET
                                 ProjectTitle = '" + projectRegistration.ProjectTitle + "'," +
                            " ProjectSummary = '" + projectRegistration.ProjectSummary + "', "
                            + " GroupId = " + projectRegistration.GroupId + ", "
                            + " TeacherId = " + projectRegistration.TeacherId + ", "
                            + " ProjectTypeId = " + projectRegistration.ProjectTypeId + ", "
                            + " RegistrationDate = '" + projectRegistration.RegistrationDate + "', "
                            + " Status = '" + projectRegistration.Status + "', "
                            + " ProgressStatus = " + projectRegistration.ProgressStatus  
                            + " WHERE Id = " + projectRegistration.Id;
                return _db.SaveChanges(query);
            }
            else
            {
                var query = @"UPDATE ProjectRegistration 
                                    SET
                                 ProjectTitle = '" + projectRegistration.ProjectTitle + "'," +
                            " ProjectSummary = '" + projectRegistration.ProjectSummary + "', "
                            + " TeacherId = " + projectRegistration.TeacherId + ", "
                            + " ProjectTypeId = " + projectRegistration.ProjectTypeId + ", "
                            + " RegistrationDate = '" + projectRegistration.RegistrationDate + "', "
                            + " Status = '" + projectRegistration.Status + "', "
                            + " ProgressStatus = " + projectRegistration.ProgressStatus
                            + " WHERE Id = " + projectRegistration.Id; 
                return _db.SaveChanges(query);
            }

        }
        #endregion



        #region Delete
        public bool Delete(ProjectRegistration projectRegistration)
        {
            var query = @"DELETE FROM ProjectRegistration 
                            WHERE Id = " + projectRegistration.Id;
            return _db.SaveChanges(query);
        }
        #endregion



        #region GetData
        public DataTable GetData(string searchText, int type, int teacherId)
        {
            string query = @"SELECT p.Id, p.GroupId, p.ProjectTypeId, p.ProjectTitle, p.ProjectSummary, 
                              pt.Name AS ProjectTypeName, g.GroupId AS GGroupId, t.FullName AS TeacherName, 
                              p.RegistrationDate, p.Status, p.ProgressStatus FROM ProjectRegistration p 
                              INNER JOIN ProjectType pt ON p.ProjectTypeId = pt.Id INNER JOIN CreateProjectGroup g
                              ON p.GroupId = g.Id INNER JOIN Teacher t ON p.TeacherId = t.Id 
                              WHERE p.GroupId = g.Id";
            if (teacherId > 0)
            {
                query += @" AND p.TeacherId = " + teacherId;
            }

            if (type == 0)
            {
                query += @" AND (pt.Name LIKE '%" + searchText + "%' OR p.ProjectTitle LIKE '%" + searchText + "%')";
            }
            query += " ORDER BY p.Id DESC";
            var dt = _db.GetData(query);
            return dt;
            //return query;
        }
        #endregion



        #region SearchReport

        public DataTable Search(int projectTypeId, int teacherId, string groupId, string status, string dateFrom,
            string dateTo)
        {
            var query = @"SELECT p.Id, p.GroupId, p.ProjectTypeId, p.ProjectTitle, p.ProjectSummary, 
                              pt.Name AS ProjectTypeName, g.GroupId AS GGroupId, t.FullName AS TeacherName, 
                              p.RegistrationDate, p.Status, p.ProgressStatus FROM ProjectRegistration p 
                              INNER JOIN ProjectType pt ON p.ProjectTypeId = pt.Id INNER JOIN CreateProjectGroup g
                              ON p.GroupId = g.Id INNER JOIN Teacher t ON p.TeacherId = t.Id 
                              WHERE p.GroupId = g.Id";
            if (teacherId > 0)
            {
                query += " AND p.TeacherId = " + teacherId;
            }

            if (projectTypeId > 0)
            {
                query += " AND p.ProjectTypeId = " + projectTypeId;
            }



            if (groupId != string.Empty)
            {
                query += " AND g.GroupId = '" + groupId + "'";
            }

            if (status != string.Empty)
            {
                query += " AND p.Status = '" + status + "'";
            }

            if (dateFrom != string.Empty)
            {
                query += " AND p.RegistrationDate > '" + dateFrom + "'";
            }

            if (dateTo != string.Empty)
            {
                query += " AND p.RegistrationDate < '" + dateTo + "'";
            }

            query += " ORDER BY p.Id DESC";

            var dt = _db.GetData(query);
            return dt;
        }

        #endregion



        #region ProjectRegistrationByGroupId
        public ProjectRegistration ProjectRegistrationByGroupId(int groupId)
        {
            ProjectRegistration projectRegistration = null;
            using (var connection = ConnectDb.GetSqlConnection())
            {
                var query = @"SELECT * FROM ProjectRegistration WHERE GroupId = " + groupId;
                var cmd = new SqlCommand(query, connection);
                connection.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        projectRegistration = new ProjectRegistration
                        {
                            Id = Convert.ToInt32(reader["Id"].ToString()),
                            ProjectTitle = reader["ProjectTitle"].ToString(),
                            ProjectSummary = reader["ProjectSummary"].ToString(),
                            GroupId = Convert.ToInt32(reader["GroupId"].ToString()),
                            TeacherId = Convert.ToInt32(reader["TeacherId"].ToString()),
                            ProjectTypeId = Convert.ToInt32(reader["ProjectTypeId"].ToString()),
                            RegistrationDate = reader["RegistrationDate"].ToString(),
                            Status = reader["Status"].ToString(),
                            ProgressStatus = Convert.ToInt32(reader["ProgressStatus"].ToString())
                        };
                    }
                    connection.Close();
                }
            }
            return projectRegistration;
        }
        #endregion


        #region ProjectRegistrationById
        public ProjectRegistration ProjectRegistrationById(int id)
        {
            ProjectRegistration projectRegistration = null;
            using (var connection = ConnectDb.GetSqlConnection())
            {
                var query = @"SELECT * FROM ProjectRegistration WHERE Id = " + id;
                var cmd = new SqlCommand(query, connection);
                connection.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        projectRegistration = new ProjectRegistration
                        {
                            Id = Convert.ToInt32(reader["Id"].ToString()),
                            ProjectTitle = reader["ProjectTitle"].ToString(),
                            ProjectSummary = reader["ProjectSummary"].ToString(),
                            GroupId = Convert.ToInt32(reader["GroupId"].ToString()),
                            TeacherId = Convert.ToInt32(reader["TeacherId"].ToString()),
                            ProjectTypeId = Convert.ToInt32(reader["ProjectTypeId"].ToString()),
                            RegistrationDate = reader["RegistrationDate"].ToString(),
                            Status = reader["Status"].ToString(),
                            ProgressStatus = Convert.ToInt32(reader["ProgressStatus"].ToString())
                        };
                    }

                    connection.Close();
                }
            }
            return projectRegistration;
        }
        #endregion



    }
}