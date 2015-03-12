using System;
using System.Data;
using System.Data.SqlClient;
using ProjectManagementVerification.BLL;

namespace ProjectManagementVerification.DAL
{
    public class StudentGroupDb : GlobalDb
    {
        readonly GlobalDb _db = new GlobalDb();


        # region Save
        public bool Save(StudentGroup studentGroup)
        {
            var query = "INSERT into CreateStudentGroup values ('" + studentGroup.GroupId + "', "
                                                            + studentGroup.StudentId + ", '"
                                                            + studentGroup.GroupTitle + "', "
                                                            + studentGroup.CreatedBy + ", '"
                                                            + studentGroup.CreationDate + "', '"
                                                            + studentGroup.GroupType + "', '"
                                                            + studentGroup.GroupStatus + "')";
                                                            
            return _db.SaveChanges(query);
            //return query;
        }
        #endregion



        # region ExistingValidationStudentGroup
        public bool ExistingValidationStudentGroup(string groupId, int studentId)
        {
            var query = "SELECT GroupTitle from CreateStudentGroup where GroupId='" + groupId + "' and StudentId = " + studentId;
            return Existing_Validation(query);
        }
        #endregion



        #region Update
        public bool Update(StudentGroup studentGroup, string groupId, int studentId)
        {
            var query = @"UPDATE CreateStudentGroup 
                                    SET
                                 GroupId = " + studentGroup.GroupId + "," +
                                " StudentId = " + studentGroup.StudentId + ", "
                                + " GroupTitle = N'" + studentGroup.GroupTitle + "', "
                                + " CreatedBy = N'" + studentGroup.CreatedBy + "', "
                                + " CreationDate = N'" + studentGroup.CreationDate + "', "
                                + " GroupType = N'" + studentGroup.GroupType + "', "
                                + " Status = '" + studentGroup.GroupStatus + "' WHERE";
            if ((groupId != string.Empty) && (studentId > 0))
            {
                query += " StudentId = " + studentId +
                              " AND GroupId = " + groupId;
            }
            if (studentId == 0)
            {
                query += " GroupId = " + groupId;
            }
            if (groupId == string.Empty)
            {
                query += " StudentId = " + studentId;
            }
            return _db.SaveChanges(query);
        }
        #endregion



        #region Delete
        public bool Delete(StudentGroup studentGroup)
        {
            var query = @"DELETE FROM CreateStudentGroup 
                            WHERE StudentId = " + studentGroup.StudentId + " AND GroupId = " + studentGroup.GroupId;
            return _db.SaveChanges(query);
        }
        #endregion



        #region GetData
        public DataTable GetData(string searchText, int type)
        {
            if (type == 0)
            {
                var query = @"SELECT sg.StudentId, sg.CreatedBy, sg.GroupId, sg.GroupTitle, s.FullName AS StudentName, 
                              t.FullName AS TeacherName, sg.CreationDate, sg.GroupType, sg.GroupStatus 
                              FROM CreateStudentGroup sg INNER JOIN Teacher t ON sg.CreatedBy = t.Id
                              INNER JOIN Student s ON sg.StudentId = s.Id
                                WHERE 
                               t.FullName LIKE '" + searchText + "%' OR s.FullName = '" + searchText + "%' OR sg.GroupId = '" + searchText + "%' ORDER BY sg.CreationDate DESC";
                var dt = _db.GetData(query);
                return dt;
            }
            else
            {
                const string query = @"SELECT sg.StudentId, sg.CreatedBy, sg.GroupId, sg.GroupTitle, s.FullName AS StudentName, 
                              t.FullName AS TeacherName, sg.CreationDate, sg.GroupType, sg.GroupStatus 
                              FROM CreateStudentGroup sg INNER JOIN Teacher t ON sg.CreatedBy = t.Id
                              INNER JOIN Student s ON sg.StudentId = s.Id ORDER BY sg.CreationDate DESC";
                var dt = _db.GetData(query);
                return dt;
            }

        }
        #endregion



        #region SearchReport
        public DataTable Search(int studentId, string status, string teacherEmail, string dateFrom, string dateTo, string groupId, string groupType)
        {
            var query = @"SELECT sg.StudentId, sg.CreatedBy, sg.GroupId, sg.GroupTitle, s.FullName AS StudentName, 
                              t.FullName AS TeacherName, sg.CreationDate, sg.GroupType, sg.GroupStatus 
                              FROM CreateStudentGroup sg INNER JOIN Teacher t ON sg.CreatedBy = t.Id
                              INNER JOIN Student s ON sg.StudentId = s.Id 
                                WHERE 
                               sg.StudentId = s.Id";
            if (studentId > 0)
            {
                query += " AND sg.StudentId = " + studentId;
            }
            if (teacherEmail != string.Empty)
            {
                query += " AND t.Email = '" + teacherEmail + "'";
            }

            if (dateFrom != string.Empty)
            {
                query += " AND sg.CreationDate > '" + dateFrom + "'";
            }

            if (dateTo != string.Empty)
            {
                query += " AND sg.CreationDate < '" + dateTo + "'";
            }

            if (status != string.Empty)
            {
                query += " AND sg.GroupStatus = '" + status + "'";
            }

            if (groupId != string.Empty)
            {
                query += " AND sg.GroupId = '" + groupId + "'";
            }

            if (groupType != string.Empty)
            {
                query += " AND sg.GroupType = '" + groupType + "'";
            }

            var dt = _db.GetData(query);
            return dt;
        }
        #endregion



        #region SearchReport2
        public DataTable Search(int teacherId, string groupId)
        {
            var query = @"SELECT sg.StudentId, sg.CreatedBy, sg.GroupId, sg.GroupTitle, s.FullName AS StudentName, 
                              t.FullName AS TeacherName, sg.CreationDate, sg.GroupType, sg.GroupStatus 
                              FROM CreateStudentGroup sg INNER JOIN Teacher t ON sg.CreatedBy = t.Id
                              INNER JOIN Student s ON sg.StudentId = s.Id 
                                WHERE 
                               sg.StudentId = s.Id";
            if (teacherId > 0)
            {
                query += " AND sg.CreatedBy != " + teacherId  ;
            }
            if (groupId != string.Empty)
            {
                query += " AND sg.GroupId = '" + groupId + "'";
            }


            var dt = _db.GetData(query);
            return dt;
            //return query;
        }
        #endregion


       

        #region StudentGroupById
        public StudentGroup StudentGroupById(string groupId, int studentId)
        {
            StudentGroup studentGroup = null;
            using (var connection = ConnectDb.GetSqlConnection())
            {
                var query = @"SELECT * FROM CreateStudentGroup WHERE GroupId = '" + groupId + "' AND StudentId = " + studentId;
                var cmd = new SqlCommand(query, connection);
                connection.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        studentGroup = new StudentGroup
                        {
                            GroupId = reader["GroupId"].ToString(),
                            StudentId = Convert.ToInt32(reader["StudentId"].ToString()),
                            GroupTitle = reader["GroupTitle"].ToString(),
                            CreatedBy = Convert.ToInt32(reader["CreatedBy"].ToString()),
                            CreationDate = reader["CreationDate"].ToString(),
                            GroupType = reader["GroupType"].ToString(),
                            GroupStatus = reader["GroupStatus"].ToString(),
                        };
                    }

                    connection.Close();
                }
            }
            return studentGroup;
        }
        #endregion


        /*#region StudentGroupByGroupIdGroupType
        public StudentGroup StudentGroupByGroupIdGroupType(string groupId, string grou)
        {
            StudentGroup studentGroup = null;
            using (var connection = ConnectDb.GetSqlConnection())
            {
                var query = @"SELECT * FROM CreateStudentGroup WHERE GroupId = '" + groupId + "' AND StudentId = " + studentId;
                var cmd = new SqlCommand(query, connection);
                connection.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        studentGroup = new StudentGroup
                        {
                            GroupId = reader["StudentId"].ToString(),
                            StudentId = Convert.ToInt32(reader["StudentId"].ToString()),
                            GroupTitle = reader["GroupTitle"].ToString(),
                            CreatedBy = Convert.ToInt32(reader["CreatedBy"].ToString()),
                            CreationDate = reader["CreationDate"].ToString(),
                            GroupType = reader["GroupType"].ToString(),
                            GroupStatus = reader["GroupStatus"].ToString(),
                        };
                    }

                    connection.Close();
                }
            }
            return studentGroup;
        }
        #endregion
        */

    }
}