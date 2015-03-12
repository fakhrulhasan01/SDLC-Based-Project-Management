using System;
using System.Data;
using System.Data.SqlClient;
using ProjectManagementVerification.BLL;

namespace ProjectManagementVerification.DAL
{
    public class StudentAssignToGroupDb : GlobalDb
    {
        readonly GlobalDb _db = new GlobalDb();


        # region Save
        public bool Save(StudentAssignToGroup studentAssignToGroup)
        {
            var query = "INSERT into StudentAssignToGroup values (" + studentAssignToGroup.ProjectGroupId + ", "
                                                            + studentAssignToGroup.StudentId + ", "
                                                            + studentAssignToGroup.AddedBy + ", '"
                                                            + studentAssignToGroup.AddedDate + "', '"
                                                            + studentAssignToGroup.StudentStatus + "')";

            return _db.SaveChanges(query);
            //return query;
        }
        #endregion



        # region ExistingValidationStudentAssignToGroup
        public bool ExistingValidationStudentAssignToGroup(int projectGroupId, int studentId)
        {
            var query = "SELECT StudentStatus from StudentAssignToGroup where ProjectGroupId=" + projectGroupId + " AND StudentId="+studentId;
            return Existing_Validation(query);
        }
        #endregion



        #region Update
        public bool Update(StudentAssignToGroup studentAssignToGroup, int projectGroupId, int studentId, string exist)
        {
            if (exist == "No")
            {
                var query = @"UPDATE StudentAssignToGroup 
                                    SET
                                 ProjectGroupId = " + studentAssignToGroup.ProjectGroupId + "," +
                            " StudentId = " + studentAssignToGroup.StudentId + ", "
                            + " AddedBy = " + studentAssignToGroup.AddedBy + ", "
                            + " AddedDate = '" + studentAssignToGroup.AddedDate + "', "
                            + " StudentStatus = '" + studentAssignToGroup.StudentStatus +
                            "' WHERE ProjectGroupId = " + projectGroupId +
                            " AND StudentId = " + studentId;
                return _db.SaveChanges(query);
                //return query;
            }
            else
            {
                var query = @"UPDATE StudentAssignToGroup 
                                    SET
                                AddedBy = " + studentAssignToGroup.AddedBy + ", "
                            + " AddedDate = '" + studentAssignToGroup.AddedDate + "', "
                            + " StudentStatus = '" + studentAssignToGroup.StudentStatus +
                            "' WHERE ProjectGroupId = " + projectGroupId +
                            " AND StudentId = " + studentId;
                return _db.SaveChanges(query);
                //return query;
            }
        }
        #endregion



        #region Delete
        public bool Delete(StudentAssignToGroup studentAssignToGroup)
        {
            var query = @"DELETE FROM StudentAssignToGroup 
                            WHERE ProjectGroupId = " + studentAssignToGroup.ProjectGroupId +
                            " AND StudentId = "+studentAssignToGroup.StudentId;
            return _db.SaveChanges(query);
        }
        #endregion



        #region GetData
        public DataTable GetData(string searchText, int type, int teacherId)
        {
            string query = @"SELECT a.ProjectGroupId, a.StudentId, a.AddedBy, g.GroupId, g.Description, g.GroupType, s.FullName AS StudentName, 
                            t.FullName AS TeacherName, a.AddedDate, a.StudentStatus FROM StudentAssignToGroup a INNER JOIN 
                            CreateProjectGroup g ON a.ProjectGroupId = g.Id INNER JOIN Student s ON a.StudentId = s.Id 
                            INNER JOIN Teacher t ON a.AddedBy = t.Id    
                                    WHERE 
                               a.AddedBy = t.Id ";
            if (teacherId > 0)
            {
                query += "AND a.AddedBy = " + teacherId;
            }
            if (type == 0)
            {
                query += @"OR t.FullName LIKE '" + searchText + "%' OR g.Status = '" + searchText + "%' OR g.GroupId = '" + searchText + "%' ORDER BY g.Id DESC";
            }
            query += " ORDER BY g.Id DESC";
            var dt = _db.GetData(query);
            return dt;
        }
        #endregion



        #region SearchReport
        public DataTable Search(int teacherId, int studentId, string status, string dateFrom, string dateTo, int groupId, string groupType)
        {
            var query = @"SELECT a.ProjectGroupId, a.StudentId, a.AddedBy, g.GroupId, g.Description, g.GroupType, s.FullName AS StudentName, 
                            t.FullName AS TeacherName, a.AddedDate, a.StudentStatus FROM StudentAssignToGroup a INNER JOIN 
                            CreateProjectGroup g ON a.ProjectGroupId = g.Id INNER JOIN Student s ON a.StudentId = s.Id 
                            INNER JOIN Teacher t ON a.AddedBy = t.Id    
                                    WHERE 
                               a.AddedBy = t.Id";
            if (teacherId > 0)
            {
                query += " AND a.AddedBy = " + teacherId;
            }

            if (studentId > 0)
            {
                query += " AND a.StudentId = "+studentId;
            }

            if (dateFrom != string.Empty)
            {
                query += " AND a.AddedDate > '" + dateFrom + "'";
            }

            if (dateTo != string.Empty)
            {
                query += " AND a.AddedDate < '" + dateTo + "'";
            }

            if (status != string.Empty)
            {
                query += " AND a.StudentStatus = '" + status + "'";
            }

            if (groupId > 0)
            {
                query += " AND g.Id = " + groupId;
            }

            if (groupType != string.Empty)
            {
                query += " AND g.GroupType = '" + groupType + "'";
            }

            var dt = _db.GetData(query);
            return dt;
        }
        #endregion



        #region StudentAssignToGroupById
        public StudentAssignToGroup StudentAssignToGroupById(int projectGroupId, int studentId)
        {
            StudentAssignToGroup studentAssignToGroup = null;
            using (var connection = ConnectDb.GetSqlConnection())
            {
                var query = @"SELECT * FROM StudentAssignToGroup WHERE ProjectGroupId = " + projectGroupId 
                                    +" AND StudentId = "+studentId;
                var cmd = new SqlCommand(query, connection);
                connection.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        studentAssignToGroup = new StudentAssignToGroup
                        {
                            ProjectGroupId = Convert.ToInt32(reader["ProjectGroupId"].ToString()),
                            StudentId = Convert.ToInt32(reader["StudentId"].ToString()),
                            AddedBy = Convert.ToInt32(reader["AddedBy"].ToString()),
                            AddedDate = reader["AddedDate"].ToString(),
                            StudentStatus = reader["StudentStatus"].ToString()
                        };
                    }

                    connection.Close();
                }
            }
            return studentAssignToGroup;
        }
        #endregion


    }
}