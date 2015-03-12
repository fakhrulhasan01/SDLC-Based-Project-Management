using System;
using System.Data;
using System.Data.SqlClient;
using ProjectManagementVerification.BLL;

namespace ProjectManagementVerification.DAL
{
    public class CreateProjectGroupDb : GlobalDb
    {
        readonly GlobalDb _db = new GlobalDb();


        # region Save
        public bool Save(CreateProjectGroup createProjectGroup)
        {
            var query = "INSERT into CreateProjectGroup values ('" + createProjectGroup.GroupId + "', '"
                                                            + createProjectGroup.Description + "', '"
                                                            + createProjectGroup.GroupType + "', "
                                                            + createProjectGroup.CreatedBy + ", '"
                                                            + createProjectGroup.CreationDate + "', '"
                                                            + createProjectGroup.Status + "')";

            return _db.SaveChanges(query);
            //return query;
        }
        #endregion



        # region ExistingValidationCreateProjectGroup
        public bool ExistingValidationCreateProjectGroup(string groupId)
        {
            var query = "SELECT GroupId from CreateProjectGroup where GroupId='" + groupId + "'";
            return Existing_Validation(query);
        }
        #endregion



        #region Update
        public bool Update(CreateProjectGroup createProjectGroup)
        {
            var query = @"UPDATE CreateProjectGroup 
                                    SET
                                 GroupId = '" + createProjectGroup.GroupId + "'," +
                                " Description = '" + createProjectGroup.Description + "', "
                                + " GroupType = '" + createProjectGroup.GroupType + "', "
                                + " CreatedBy = " + createProjectGroup.CreatedBy + ", "
                                + " CreationDate = '" + createProjectGroup.CreationDate + 
                                "' WHERE Id = "+createProjectGroup.Id;
            return _db.SaveChanges(query);
        }
        #endregion



        #region Delete
        public bool Delete(CreateProjectGroup createProjectGroup)
        {
            var query = @"DELETE FROM CreateProjectGroup 
                            WHERE Id = " + createProjectGroup.Id;
            return _db.SaveChanges(query);
        }
        #endregion



        #region GetData
        public DataTable GetData(string searchText, int type, int teacherId)
        {
            string query = @"SELECT g.Id, g.CreatedBy, g.GroupId, g.Description, g.GroupType, t.FullName, g.CreationDate, 
                                     g.Status FROM CreateProjectGroup g INNER JOIN Teacher t ON g.CreatedBy = t.Id 
                                      Where g.CreatedBy = t.Id ";
            if (teacherId > 0)
            {
                query += "AND g.CreatedBy = "+teacherId;
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
        public DataTable Search(int teacherId, string status, string dateFrom, string dateTo, string groupId, string groupType)
        {
            var query = @"SELECT g.Id, g.CreatedBy, g.GroupId, g.Description, g.GroupType, t.FullName, g.CreationDate, g.Status 
                        FROM CreateProjectGroup g INNER JOIN Teacher t ON g.CreatedBy = t.Id      
                                    WHERE 
                               g.CreatedBy = t.Id";
            if (teacherId > 0)
            {
                query += " AND g.CreatedBy = " + teacherId;
            }

            if (dateFrom != string.Empty)
            {
                query += " AND g.CreationDate > '" + dateFrom + "'";
            }

            if (dateTo != string.Empty)
            {
                query += " AND g.CreationDate < '" + dateTo + "'";
            }

            if (status != string.Empty)
            {
                query += " AND g.Status = '" + status + "'";
            }

            if (groupId != string.Empty)
            {
                query += " AND g.GroupId = '" + groupId + "'";
            }

            if (groupType != string.Empty)
            {
                query += " AND g.GroupType = '" + groupType + "'";
            }

            var dt = _db.GetData(query);
            return dt;
        }
        #endregion



        #region CreateProjectGroupById
        public CreateProjectGroup CreateProjectGroupById(int id)
        {
            CreateProjectGroup createProjectGroup = null;
            using (var connection = ConnectDb.GetSqlConnection())
            {
                var query = @"SELECT * FROM CreateProjectGroup WHERE Id = " + id ;
                var cmd = new SqlCommand(query, connection);
                connection.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        createProjectGroup = new CreateProjectGroup
                        {
                            Id = Convert.ToInt32(reader["Id"].ToString()),
                            GroupId = reader["GroupId"].ToString(),
                            Description = reader["Description"].ToString(),
                            GroupType = reader["GroupType"].ToString(),
                            CreatedBy = Convert.ToInt32(reader["CreatedBy"].ToString()),
                            CreationDate = reader["CreationDate"].ToString(),
                            Status = reader["Status"].ToString()
                        };
                    }

                    connection.Close();
                }
            }
            return createProjectGroup;
        }
        #endregion

    }
}