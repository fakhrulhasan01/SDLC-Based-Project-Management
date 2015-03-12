using System;
using System.Data;
using System.Data.SqlClient;
using ProjectManagementVerification.BLL;

namespace ProjectManagementVerification.DAL
{
    public class ProjectPhaseDb : GlobalDb
    {
        readonly GlobalDb _db = new GlobalDb();


        # region Save
        public bool Save(ProjectPhase projectPhase)
        {
            var query = "INSERT into ProjectPhase values (" + projectPhase.ProjectTypeId + ", '"
                                                            + projectPhase.PhaseName + "', '"
                                                            + projectPhase.PhaseDescription + "', "
                                                            + projectPhase.Priority + ", '"
                                                            + projectPhase.CreationDate + "')";

            return _db.SaveChanges(query);
            //return query;
        }
        #endregion



        # region ExistingValidationProjectPhase
        public bool ExistingValidationProjectPhase(int projectTypeId, string priority)
        {
            var query = @"SELECT PhaseName from ProjectPhase where 
                        ProjectTypeId=" + projectTypeId + " AND Priority = '" + priority + "'";
            return Existing_Validation(query);
        }
        #endregion



        #region Update
        public bool Update(ProjectPhase projectPhase, string exist)
        {
            if (exist == "No")
            {
                var query = @"UPDATE ProjectPhase 
                                    SET
                                 ProjectTypeId = " + projectPhase.ProjectTypeId + "," +
                            " PhaseName = '" + projectPhase.PhaseName + "', "
                            + " PhaseDescription = '" + projectPhase.PhaseDescription + "', "
                            + " Priority = " + projectPhase.Priority + ", "
                            + " CreationDate = '" + projectPhase.CreationDate +
                            "' WHERE Id = " + projectPhase.Id;
                return _db.SaveChanges(query);
            }
            else
            {
                var query = @"UPDATE ProjectPhase 
                                    SET
                             PhaseName = '" + projectPhase.PhaseName + "', "
                            + " PhaseDescription = '" + projectPhase.PhaseDescription + "', "
                            + " CreationDate = '" + projectPhase.CreationDate +
                            "' WHERE Id = " + projectPhase.Id;
                return _db.SaveChanges(query);
            }
            
        }
        #endregion



        #region Delete
        public bool Delete(ProjectPhase projectPhase)
        {
            var query = @"DELETE FROM ProjectPhase 
                            WHERE Id = " + projectPhase.Id;
            return _db.SaveChanges(query);
        }
        #endregion



        #region GetData
        public DataTable GetData(string searchText, int type)
        {
            string query = @"SELECT p.Id, p.ProjectTypeId, pt.Name AS ProjectTypeName, 
                            p.PhaseName, p.PhaseDescription, p.Priority, p.CreationDate 
                            FROM ProjectPhase p INNER JOIN ProjectType pt ON
                            p.ProjectTypeId = Pt.Id WHERE p.ProjectTypeId = pt.Id";
            if (type == 0)
            {
                query += @" OR pt.Name LIKE '" + searchText + "%' OR p.PhaseName = '" + searchText + "%' OR p.PhaseDescription = '" + searchText + "%'";
            }
            query += " ORDER BY p.Id DESC";
            var dt = _db.GetData(query);
            return dt;
        }
        #endregion



        #region SearchReport
        public DataTable Search(int projectTypeId, string phaseName, int priority)
        {
            var query = @"SELECT p.Id, p.ProjectTypeId, pt.Name AS ProjectTypeName, 
                            p.PhaseName, p.PhaseDescription, p.Priority, p.CreationDate 
                            FROM ProjectPhase p INNER JOIN ProjectType pt ON
                            p.ProjectTypeId = Pt.Id WHERE p.ProjectTypeId = pt.Id";
            if (projectTypeId > 0)
            {
                query += " AND p.ProjectTypeId = " + projectTypeId;
            }


            if (phaseName != string.Empty)
            {
                query += " AND p.PhaseName = '" + phaseName + "'";
            }

           
            if (priority > 0)
            {
                query += " AND p.Priority = " + priority;
            }

            var dt = _db.GetData(query);
            return dt;
        }
        #endregion



        #region ProjectPhaseById
        public ProjectPhase ProjectPhaseById(int id)
        {
            ProjectPhase projectPhase = null;
            using (var connection = ConnectDb.GetSqlConnection())
            {
                var query = @"SELECT * FROM ProjectPhase WHERE Id = " + id;
                var cmd = new SqlCommand(query, connection);
                connection.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        projectPhase = new ProjectPhase
                        {
                            Id = Convert.ToInt32(reader["Id"].ToString()),
                            ProjectTypeId = Convert.ToInt32(reader["ProjectTypeId"].ToString()),
                            PhaseName = reader["PhaseName"].ToString(),
                            PhaseDescription = reader["PhaseDescription"].ToString(),
                            Priority = Convert.ToInt32(reader["Priority"].ToString()),
                            CreationDate = reader["CreationDate"].ToString()
                        };
                    }

                    connection.Close();
                }
            }
            return projectPhase;
        }
        #endregion


    }
}