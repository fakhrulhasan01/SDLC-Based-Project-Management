using System;
using System.Data;
using System.Data.SqlClient;
using ProjectManagementVerification.BLL;

namespace ProjectManagementVerification.DAL
{
    public class ChecklistDb : GlobalDb
    {
        private readonly GlobalDb _db = new GlobalDb();

        # region Save
        public bool Save(Checklist checklist)
        {
            var query = "INSERT into Checklist values (" + checklist.ProjectPhaseId + ", '"
                                                            + checklist.ChecklistName + "', '"
                                                            + checklist.ChecklistDescription + "', '"
                                                            + checklist.ChecklistType + "', '"
                                                            + checklist.CreationDate + "', "
                                                            + checklist.CreatedBy + ", '"
                                                            + checklist.Status + "')";

            return _db.SaveChanges(query);
            //return query;
        }
        #endregion



        # region ExistingValidationChecklist
        public bool ExistingValidationChecklist(int projectPhaseId, string checklistName, string type)
        {
            var query = @"SELECT ChecklistName from Checklist where 
                        ProjectPhaseId=" + projectPhaseId + " AND ChecklistName = '" + checklistName + "' AND ChecklistType = '"+type+"'";
            return Existing_Validation(query);
        }
        #endregion



        #region Update
        public bool Update(Checklist checklist, string exist)
        {
            if (exist == "No")
            {
                var query = @"UPDATE Checklist 
                                    SET
                                 ProjectPhaseId = " + checklist.ProjectPhaseId + "," +
                            " ChecklistName = '" + checklist.ChecklistName + "', "
                            + " ChecklistDescription = '" + checklist.ChecklistDescription + "', "
                            + " ChecklistType = '" + checklist.ChecklistType + "', "
                            + " CreationDate = '" + checklist.CreationDate + "', "
                            + " CreatedBy = " + checklist.CreatedBy + ", "
                            + " Status = '" + checklist.Status +
                            "' WHERE Id = " + checklist.Id;
                return _db.SaveChanges(query);
            }
            else
            {

                var query = @"UPDATE Checklist 
                                    SET
                                ChecklistDescription = '" + checklist.ChecklistDescription + "', "
                            + " ChecklistType = '" + checklist.ChecklistType + "', "
                            + " CreationDate = '" + checklist.CreationDate + "', "
                            + " CreatedBy = " + checklist.CreatedBy + ", "
                            + " Status = '" + checklist.Status +
                            "' WHERE Id = " + checklist.Id; 
                return _db.SaveChanges(query);
            }

        }
        #endregion



        #region Delete
        public bool Delete(Checklist checklist)
        {
            var query = @"DELETE FROM Checklist 
                            WHERE Id = " + checklist.Id;
            return _db.SaveChanges(query);
        }
        #endregion



        #region GetData
        public DataTable GetData(string searchText, int type, int teacherId)
        {
            string query = @"SELECT c.Id, c.ProjectPhaseId, pt.Id AS ProjectTypeId, c.ChecklistName, p.PhaseName, 
                            pt.Name AS ProjectTypeName, c.ChecklistDescription,  c.ChecklistType, c.CreationDate, 
                            t.FullName, c.Status FROM Checklist c INNER JOIN ProjectPhase p ON c.ProjectPhaseId = p.Id 
                            INNER JOIN ProjectType pt ON p.ProjectTypeId = pt.Id INNER JOIN Teacher t
                            ON c.CreatedBy = t.Id WHERE c.CreatedBy = t.Id";
            if (teacherId > 0)
            {
                query += " AND c.CreatedBy = "+teacherId;
            }
            if (type == 0)
            {
                query += @" OR pt.Name LIKE '" + searchText + "%' OR p.PhaseName = '" + searchText + "%' OR c.ChecklistName = '" + searchText + "%' ";
            }
            query += " ORDER BY c.Id DESC";
            var dt = _db.GetData(query);
            return dt;
        }
        #endregion



        #region SearchReport
        public DataTable Search(int projectTypeId, int phaseId, string status, string type)
        {
            var query = @"SELECT c.Id, c.ProjectPhaseId, pt.Id AS ProjectTypeId, c.ChecklistName, p.PhaseName, 
                            pt.Name AS ProjectTypeName, c.ChecklistDescription,  c.ChecklistType, c.CreationDate, 
                            t.FullName, c.Status FROM Checklist c INNER JOIN ProjectPhase p ON c.ProjectPhaseId = p.Id 
                            INNER JOIN ProjectType pt ON p.ProjectTypeId = pt.Id INNER JOIN Teacher t
                            ON c.CreatedBy = t.Id WHERE c.CreatedBy = t.Id";
            if (projectTypeId > 0)
            {
                query += " AND p.ProjectTypeId = " + projectTypeId;
            }


            if (phaseId > 0)
            {
                query += " AND p.Id = " + phaseId;
            }


            if (status != string.Empty)
            {
                query += " AND c.Status = '" + status + "'";
            }

            if (type != string.Empty)
            {
                query += " AND c.ChecklistType = '" + type + "'";
            }

            var dt = _db.GetData(query);
            return dt;
        }
        #endregion


        #region SearchReportForTeacher
        public DataTable Search(int createdBy, int projectPhaseId, int projectTypeId, string status)
        {
            var query = @"SELECT c.Id, c.ProjectPhaseId, pt.Id AS ProjectTypeId, c.ChecklistName, p.PhaseName, 
                            pt.Name AS ProjectTypeName, c.ChecklistDescription,  c.ChecklistType, c.CreationDate, 
                            t.FullName, c.Status FROM Checklist c INNER JOIN ProjectPhase p ON c.ProjectPhaseId = p.Id 
                            INNER JOIN ProjectType pt ON p.ProjectTypeId = pt.Id INNER JOIN Teacher t
                            ON c.CreatedBy = t.Id WHERE (c.ChecklistType = 'Mandatory' OR CreatedBy = "+createdBy +")";
            if (status != string.Empty)
            {
                query += " AND c.Status = '" + status + "'";
            }

            if (projectPhaseId > 0)
            {
                query += " AND c.ProjectPhaseId = " + projectPhaseId;
            }

            if (projectTypeId > 0)
            {
                query += " AND pt.Id = " + projectTypeId;
            }

            var dt = _db.GetData(query);
            return dt;
        }
        #endregion



        #region ChecklistById
        public Checklist ChecklistById(int id)
        {
            Checklist checklist = null;
            using (var connection = ConnectDb.GetSqlConnection())
            {
                var query = @"SELECT * FROM Checklist WHERE Id = " + id;
                var cmd = new SqlCommand(query, connection);
                connection.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        checklist = new Checklist
                        {
                            Id = Convert.ToInt32(reader["Id"].ToString()),
                            ProjectPhaseId = Convert.ToInt32(reader["ProjectPhaseId"].ToString()),
                            ChecklistName = reader["ChecklistName"].ToString(),
                            ChecklistDescription = reader["ChecklistDescription"].ToString(),
                            ChecklistType = reader["ChecklistType"].ToString(),
                            CreationDate = reader["CreationDate"].ToString(),
                            CreatedBy = Convert.ToInt32(reader["CreatedBy"].ToString()),
                            Status = reader["Status"].ToString()
                        };
                    }

                    connection.Close();
                }
            }
            return checklist;
        }
        #endregion



    }
}