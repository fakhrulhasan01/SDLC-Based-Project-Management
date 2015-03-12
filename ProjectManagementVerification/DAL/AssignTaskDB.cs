using System;
using System.Data;
using System.Data.SqlClient;
using ProjectManagementVerification.BLL;

namespace ProjectManagementVerification.DAL
{
    public class AssignTaskDb : GlobalDb
    {
        private readonly GlobalDb _db = new GlobalDb();

        # region Save
        public bool Save(AssignTask assignTask)
        {
            var query = "INSERT into AssignTask values (" + assignTask.ChecklistId + ", "
                                                            + assignTask.TeacherId + ", "
                                                            + assignTask.ProjectId + ", "
                                                            + assignTask.StudentGroupId + ", '"
                                                            + assignTask.TaskDescription + "', '"
                                                            + assignTask.TaskFile + "', '"
                                                            + assignTask.AssignDate + "', '"
                                                            + assignTask.Deadline + "', '"
                                                            + assignTask.TaskStatus + "')";

            return _db.SaveChanges(query);
            //return query;
        }
        #endregion



        # region ExistingValidationAssignTask
        public bool ExistingValidationAssignTask(int checklistId, int projectId, string taskDescription)
        {
            var query = @"SELECT TaskDescription from AssignTask where TaskDescription = '" + 
                taskDescription + "' AND ChecklistId = " + checklistId + " AND ProjectId = " +projectId;
            return Existing_Validation(query);
        }
        #endregion



        #region Update
        public bool Update(AssignTask assignTask)
        {
               var query = @"UPDATE AssignTask 
                                    SET
                                 ChecklistId = " + assignTask.ChecklistId + "," 
                            + " TeacherId = " + assignTask.TeacherId + ", "
                            + " ProjectId = " + assignTask.ProjectId + ", "
                            + " StudentGroupId = " + assignTask.StudentGroupId + ", "
                            + " TaskDescription = '" + assignTask.TaskDescription + "', "
                            + " TaskFile = '" + assignTask.TaskFile + "', "
                            + " AssignDate = '" + assignTask.AssignDate + "', "
                            + " Deadline = '" + assignTask.Deadline + "', "
                            + " TaskStatus = '" + assignTask.TaskStatus +
                            "' WHERE Id = " + assignTask.Id;
               return SaveChanges(query);
        }
        #endregion



        #region Delete
        public bool Delete(AssignTask assignTask)
        {
            var query = @"DELETE FROM AssignTask 
                            WHERE Id = " + assignTask.Id;
            return _db.SaveChanges(query);
        }
        #endregion



        #region GetData
        public DataTable GetData(string searchText, int type, int teacherId)
        {
            string query = @"SELECT ts.Id, ts.ChecklistId, ts.TeacherId, ts.ProjectId, ts.StudentGroupId, ts.TaskDescription,
		                     ts.TaskFile, ts.AssignDate, ts.Deadline, ts.TaskStatus, pr.ProjectTitle, c.ChecklistName, 
		                     pg.GroupId AS ProjectGroupId, t.FullName FROM AssignTask ts INNER JOIN ProjectRegistration pr ON 
		                     ts.ProjectId = pr.Id INNER JOIN CreateProjectGroup pg ON ts.StudentGroupId = pg.Id 
		                     INNER JOIN Checklist c ON ts.ChecklistId = c.Id INNER JOIN Teacher t ON ts.TeacherId = t.Id";
            if (teacherId > 0)
            {
                query += " AND c.CreatedBy = "+teacherId;
            }
            if (type == 0)
            {
                query += @" OR ts.TaskDescription LIKE '"+searchText+"%' ";
            }
            query += " ORDER BY c.Id DESC";
            var dt = _db.GetData(query);
            return dt;
        }
        #endregion



        #region SearchReport
        public DataTable Search(int taskId, int checklistId, int teacher, string status, int projectId)
        {
            var query = @"SELECT ts.Id, ts.ChecklistId, ts.TeacherId, ts.ProjectId, ts.StudentGroupId, ts.TaskDescription,
		                     ts.TaskFile, ts.AssignDate, ts.Deadline, ts.TaskStatus, pr.ProjectTitle, c.ChecklistName, 
		                     pg.GroupId AS ProjectGroupId, t.FullName FROM AssignTask ts INNER JOIN ProjectRegistration pr ON 
		                     ts.ProjectId = pr.Id INNER JOIN CreateProjectGroup pg ON ts.StudentGroupId = pg.Id 
		                     INNER JOIN Checklist c ON ts.ChecklistId = c.Id INNER JOIN Teacher t ON ts.TeacherId = t.Id";
            if (taskId > 0)
            {
                query += " AND ts.Id = " + taskId;
            }

            if (checklistId > 0)
            {
                query += " AND ts.ChecklistId = " + checklistId;
            }

            if (status != string.Empty)
            {
                query += " AND ts.TaskStatus = '" + status + "'";
            }

            if (teacher > 0)
            {
                query += " AND ts.TeacherId = " + teacher;
            }

            var dt = _db.GetData(query);
            return dt;
        }
        #endregion


        

        #region AssignTaskById
        public AssignTask AssignTaskById(int id)
        {
            AssignTask assignTask = null;
            using (var connection = ConnectDb.GetSqlConnection())
            {
                var query = @"SELECT * FROM AssignTask WHERE Id = " + id;
                var cmd = new SqlCommand(query, connection);
                connection.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        assignTask = new AssignTask
                        {
                            Id = Convert.ToInt32(reader["Id"].ToString()),
                            ChecklistId = Convert.ToInt32(reader["ChecklistId"].ToString()),
                            TeacherId = Convert.ToInt32(reader["TeacherId"].ToString()),
                            ProjectId = Convert.ToInt32(reader["ProjectId"].ToString()),
                            StudentGroupId = Convert.ToInt32(reader["StudentGroupId"].ToString()),
                            TaskDescription = reader["TaskDescription"].ToString(),
                            TaskFile = reader["TaskFile"].ToString(),
                            AssignDate = reader["AssignDate"].ToString(),
                            Deadline = reader["Deadline"].ToString(),
                            TaskStatus = reader["TaskStatus"].ToString()
                        };
                    }
                    connection.Close();
                }
            }
            return assignTask;
        }
        #endregion

        
    }
}