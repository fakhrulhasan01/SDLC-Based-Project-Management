using System;
using System.Data;
using System.Data.SqlClient;
using ProjectManagementVerification.BLL;

namespace ProjectManagementVerification.DAL
{
    public class TaskFeedbackDb : GlobalDb
    {
        private readonly GlobalDb _db = new GlobalDb();
        
        # region Save
        public bool Save(TaskFeedback taskFeedback)
        {
            var query = "INSERT into TaskFeedback values (" + taskFeedback.TaskId + ", '"
                                                            + taskFeedback.FeedbackDescription + "', '"
                                                            + taskFeedback.FeedbackFile + "', '"
                                                            + taskFeedback.FeedbackDate+ "', '"
                                                            + taskFeedback.UpdateDate + "', '"
                                                            + taskFeedback.EvaluationStatus + "'," 
                                                            + taskFeedback.StudentId + ")";

            return _db.SaveChanges(query);
            //return query;
        }
        #endregion



        /*# region ExistingValidationAssignTask
        public bool ExistingValidationAssignTask(int checklistId, int projectId, string taskTitle)
        {
            var query = @"SELECT TaskTitle from TaskFeedback where TaskTitle = '" +
                taskTitle + "' AND ChecklistId = " + checklistId + " AND ProjectId = " + projectId;
            return Existing_Validation(query);
        }
        #endregion*/



        #region Update
        public bool Update(TaskFeedback taskFeedback, string exist)
        {
            if (exist == "No")
            {
                var query = @"UPDATE TaskFeedback 
                                    SET
                                 TaskId = " + taskFeedback.TaskId + ","
                            + " FeedbackDescription = '" + taskFeedback.FeedbackDescription + "', "
                            + " FeedbackFile = '" + taskFeedback.FeedbackFile + "', "
                            + " FeedbackDate = '" + taskFeedback.FeedbackDate + "', "
                            + " UpdateDate = '" + taskFeedback.UpdateDate + "', "
                            + " EvaluationStatus = '" + taskFeedback.EvaluationStatus + "',"
                            + " StudentId = " + taskFeedback.StudentId  
                            + " WHERE Id = " + taskFeedback.Id;
                return _db.SaveChanges(query);
            }
            else
            {
                var query = @"UPDATE TaskFeedback 
                                    SET
                                 TaskId = " + taskFeedback.TaskId + ","
                            + " FeedbackDescription = '" + taskFeedback.FeedbackDescription + "', "
                            + " FeedbackFile = '" + taskFeedback.FeedbackFile + "', "
                            + " FeedbackDate = '" + taskFeedback.FeedbackDate + "', "
                            + " UpdateDate = '" + taskFeedback.UpdateDate + "', "
                            + " EvaluationStatus = '" + taskFeedback.EvaluationStatus + "',"
                            + " StudentId = " + taskFeedback.StudentId
                            + " WHERE Id = " + taskFeedback.Id;
                return _db.SaveChanges(query);
            }

        }
        #endregion



        #region Delete
        public bool Delete(int id)
        {
            var query = @"DELETE FROM TaskFeedback
                            WHERE Id = " + id;
            return _db.SaveChanges(query);
        }
        #endregion



        #region GetData
        public DataTable GetData(string searchText, int type, int taskId)
        {
            string query = @"SELECT tf.Id, tf.TaskId, t.TaskDescription, tf.FeedbackDescription, tf.FeedbackFile, tf.FeedbackDate, tf.UpdateDate, 
                            tf.EvaluationStatus, s.FullName AS StudentName, tf.StudentId FROM TaskFeedback tf INNER JOIN AssignTask t ON 
                            tf.TaskId = t.Id INNER JOIN Student s ON tf.StudentId = s.Id";
            if (taskId > 0)
            {
                query += " AND tf.TaskId = " + taskId;
            }
            if (type == 0)
            {
                query += @" OR tf.FeedbackDescription LIKE '%" + searchText + "%' ";
            }
            query += " ORDER BY tf.Id DESC";
            var dt = _db.GetData(query);
            return dt;
        }
        #endregion



        #region SearchReport
        public DataTable Search(int taskId, int studentId)
        {
            var query = @"SELECT tf.Id, tf.TaskId, t.TaskDescription, tf.FeedbackDescription, tf.FeedbackFile, tf.FeedbackDate, tf.UpdateDate, 
                            tf.EvaluationStatus, s.FullName AS StudentName, tf.StudentId FROM TaskFeedback tf INNER JOIN AssignTask t ON 
                            tf.TaskId = t.Id INNER JOIN Student s ON tf.StudentId = s.Id";
            if (taskId > 0)
            {
                query += " AND tf.TaskId = " + taskId;
            }

            if (studentId > 0)
            {
                query += " AND tf.StudentId = " + studentId;
            }

            var dt = _db.GetData(query);
            return dt;
            //return query;
        }
        #endregion




        #region TaskFeedbackById
        public TaskFeedback TaskFeedbackById(int id)
        {
            TaskFeedback taskFeedback = null;
            using (var connection = ConnectDb.GetSqlConnection())
            {
                var query = @"SELECT * FROM TaskFeedback WHERE Id = " + id;
                var cmd = new SqlCommand(query, connection);
                connection.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        taskFeedback = new TaskFeedback
                        {
                            Id = Convert.ToInt32(reader["Id"].ToString()),
                            TaskId = Convert.ToInt32(reader["TaskId"].ToString()),
                            FeedbackDescription = reader["FeedbackDescription"].ToString(),
                            FeedbackFile = reader["FeedbackFile"].ToString(),
                            FeedbackDate = reader["FeedbackDate"].ToString(),
                            UpdateDate = reader["UpdateDate"].ToString(),
                            EvaluationStatus = reader["EvaluationStatus"].ToString(),
                            StudentId = Convert.ToInt32(reader["StudentId"].ToString())
                        };
                    }
                    connection.Close();
                }
            }
            return taskFeedback;
        }
        #endregion

    }
}