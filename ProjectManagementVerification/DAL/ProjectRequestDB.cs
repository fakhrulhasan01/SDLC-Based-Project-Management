using System;
using System.Data;
using System.Data.SqlClient;
using ProjectManagementVerification.BLL;

namespace ProjectManagementVerification.DAL
{
    public class ProjectRequestDb : GlobalDb
    {
        readonly GlobalDb _db = new GlobalDb();


        # region Save
        public bool Save(ProjectRequest projectRequest)
        {
            var query = @"INSERT into projectRequest values (" + projectRequest.StudentId + ", "
                                                          + projectRequest.TeacherId + ", '"
                                                          + projectRequest.StudentMessage + "', '"
                                                          + projectRequest.ApprovalStatus + "', '"
                                                          + projectRequest.RequestDate + "', '"
                                                          + projectRequest.ConfirmationDate + "', '"
                                                          + projectRequest.Status + "')";
            return _db.SaveChanges(query);
        }
        #endregion



        # region ExistingValidationProjectRequest
        public bool ExistingValidationProjectRequest(string studentId, int teacherId)
        {
            var query = "SELECT ApprovalStatus from ProjectRequest where StudentId=" + studentId + "' and TeacherId = " + teacherId;
            return Existing_Validation(query);
        }
        #endregion



        #region Update
        public bool Update(ProjectRequest projectRequest, int studentId, int teacherId)
        {
            var query = @"UPDATE ProjectRequest 
                                    SET
                                 StudentId = " + projectRequest.StudentId + "," +
                        " TeacherId = " + projectRequest.TeacherId + ", "
                        + " StudentMessage = N'" + projectRequest.StudentMessage + "', "
                        + " ApprovalStatus = N'" + projectRequest.ApprovalStatus + "', "
                        + " RequestDate = N'" + projectRequest.RequestDate + "', "
                        + " ConfirmationDate = N'" + projectRequest.ConfirmationDate + "', "
                        + " Status = '" + projectRequest.Status + "' WHERE";
            if((studentId > 0) && (teacherId > 0)){
                query += " StudentId = " + studentId +
                              " AND TeacherId = "+teacherId;
            }
            if (studentId == 0)
            {
                query += " TeacherId = " + teacherId;
            }
            if (teacherId == 0)
            {
                query += " StudentID = " + studentId;
            }
            return _db.SaveChanges(query);
        }
        #endregion



        #region Delete
        public bool Delete(ProjectRequest projectRequest)
        {
            var query = @"DELETE FROM ProjectRequest 
                            WHERE StudentId = " + projectRequest.StudentId + " AND TeacherId = "+projectRequest.TeacherId;
            return _db.SaveChanges(query);
        }
        #endregion



        #region GetData
        public DataTable GetData(string searchText, int type)
        {
            if (type == 0)
            {
                var query = @"SELECT pr.StudentId, pr.TeacherId, s.FullName AS StudentName, t.FullName AS TeacherName, 
	                           pr.StudentMessage, pr.RequestDate, pr.ApprovalStatus, pr.ConfirmationDate, pr.Status 
	                           from ProjectRequest pr INNER JOIN Student s ON pr.StudentId = s.Id 
	                           INNER JOIN Teacher t ON pr.TeacherId = t.Id
                                WHERE 
                               t.FullName LIKE '%" + searchText + "%' OR s.FullName = '%" + searchText + "%' OR pr.ApprovalStatus = '%" + searchText + "%' ORDER BY pr.RequestDate DESC";
                var dt = _db.GetData(query);
                return dt;
            }
            else
            {
                const string query = @"SELECT pr.StudentId, pr.TeacherId, s.FullName AS StudentName, t.FullName AS TeacherName, 
	                                   pr.StudentMessage, pr.RequestDate, pr.ApprovalStatus, pr.ConfirmationDate, pr.Status 
	                                   from ProjectRequest pr INNER JOIN Student s ON pr.StudentId = s.Id 
	                                   INNER JOIN Teacher t ON pr.TeacherId = t.Id ORDER BY pr.RequestDate DESC";
                var dt = _db.GetData(query);
                return dt;
            }

        }
        #endregion



        #region SearchReport
        public DataTable Search(string studentEmail, string status, string teacherEmail, string dateFrom, string dateTo)
        {
            var query = @"SELECT pr.StudentId, pr.TeacherId, s.FullName AS StudentName, t.FullName AS TeacherName, 
	                           pr.StudentMessage, pr.RequestDate, pr.ApprovalStatus, pr.ConfirmationDate, pr.Status
	                           from ProjectRequest pr INNER JOIN Student s ON pr.StudentId = s.Id 
	                           INNER JOIN Teacher t ON pr.TeacherId = t.Id 
                                WHERE 
                               pr.StudentId = s.Id";
            if (studentEmail != string.Empty)
            {
                query += " AND s.Email = '" + studentEmail + "'";
            }
            if (teacherEmail != string.Empty)
            {
                query += " AND t.Email = '" + teacherEmail + "'";
            }

            if (dateFrom != string.Empty)
            {
                query += " AND pr.RequestDate > '" + dateFrom + "'";
            }

            if (dateTo != string.Empty)
            {
                query += " AND pr.RequestDate < '" + dateTo + "'";
            }

            if (status != string.Empty)
            {
                query += " AND pr.ApprovalStatus = '" + status + "'";
            }

            var dt = _db.GetData(query);
            return dt;
            //return query;
        }
        #endregion



        #region ProjectRequestById
        public ProjectRequest ProjectRequestById(int studentId, int teacerId)
        {
            ProjectRequest projectRequest = null;
            using (var connection = ConnectDb.GetSqlConnection())
            {
                var query = @"SELECT * FROM ProjectRequest WHERE StudentId = " + studentId + " AND TeacherId = "+teacerId;
                var cmd = new SqlCommand(query, connection);
                connection.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        projectRequest = new ProjectRequest
                        {
                            StudentId = Convert.ToInt32(reader["StudentId"].ToString()),
                            TeacherId = Convert.ToInt32(reader["TeacherId"].ToString()),
                            StudentMessage = reader["StudentMessage"].ToString(),
                            ApprovalStatus = reader["ApprovalStatus"].ToString(),
                            RequestDate = reader["RequestDate"].ToString(),
                            ConfirmationDate = reader["ConfirmationDate"].ToString()
                        };
                    }

                    connection.Close();
                }
            }
            return projectRequest;
        }
        #endregion




    }
}