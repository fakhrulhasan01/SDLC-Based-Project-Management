using System;
using System.Data;
using System.Data.SqlClient;
using ProjectManagementVerification.BLL;

namespace ProjectManagementVerification.DAL
{
    public class BlogDb:GlobalDb
    {
        # region Save
        public bool Save(Blog blog)
        {
            var query = "INSERT into Blog values ('" + blog.Title + "', '"
                                                            + blog.Description + "', '"
                                                            + blog.PostDate + "', '"
                                                            + blog.Tags + "', "
                                                            + blog.PostedBy + ", '"
                                                            + blog.PostedUserType + "','"
                                                            + blog.Picture+"')";

            return SaveChanges(query);
            //return query;
        }
        #endregion



        #region Update
        public bool Update(Blog blog)
        {
                var query = @"UPDATE Blog 
                                    SET
                                 Title = '" + blog.Title + "'," +
                            " Description = '" + blog.Description + "', "
                            + " PostDate = '" + blog.PostDate + "', "
                            + " Tags = '" + blog.Tags + "', "
                            + " PostedBy = " + blog.PostedBy + ", "
                            + " PostedUserType = '" + blog.PostedUserType + "'," 
                            + " Picture = '" + blog.Picture + "'"+
                            " WHERE Id = " + blog.Id;
                return SaveChanges(query);
        }
        #endregion



        #region Delete
        public bool Delete(int id)
        {
            var query = @"DELETE FROM Blog 
                            WHERE Id = " + id;
            return SaveChanges(query);
        }
        #endregion



        #region GetData
        public DataTable GetData(string searchText, int type)
        {
            string query = @"SELECT [Id], [Title], [Description], [PostDate], [Tags], IsNull((Select FullName From Student Where Id = [PostedBy] AND [PostedUserType]='s'),'') AS Student,
IsNull((Select FullName From Student Where Id = [PostedBy] AND [PostedUserType]='t'),'') AS Teacher, [PostedUserType], IsNull([Picture],'') AS Picture FROM Blog WHERE Id = Id";
            if (type == 0)
            {
                query += @" AND (Title LIKE '" + searchText + "%' OR Description = '" + searchText + "%') ";
            }
            query += " ORDER BY [Id] DESC";
            var dt = GetData(query);
            return dt;
        }
        #endregion



        #region SearchReport
        public DataTable Search(int userId, string userType)
        {
            var query = @"SELECT [Id], [Title], [Description], [PostDate], [Tags], IsNull((Select FullName From Student Where Id = [PostedBy] AND [PostedUserType]='s'),'') AS Student,
IsNull((Select FullName From Student Where Id = [PostedBy] AND [PostedUserType]='t'),'') AS Teacher, [PostedUserType], IsNull([Picture],'') AS Picture FROM Blog WHERE Id = Id";
            if (userId > 0)
            {
                query += " AND PostedBy = "+userId;
            }
            if (userType != string.Empty)
            {
                query += " AND PostedUserType = '"+userType+"'";
            }
            var dt = GetData(query);
            return dt;
        }
        #endregion



        #region BlogById
        public Blog BlogById(int id)
        {
            Blog blog = null;
            using (var connection = ConnectDb.GetSqlConnection())
            {
                var query = @"SELECT * FROM Blog WHERE Id = " + id;
                var cmd = new SqlCommand(query, connection);
                connection.Open();
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        blog = new Blog
                        {
                            Id = Convert.ToInt32(reader["Id"].ToString()),
                            Title = reader["Title"].ToString(),
                            Description = reader["Description"].ToString(),
                            PostDate = reader["PostDate"].ToString(),
                            Tags = reader["Tags"].ToString(),
                            PostedBy = Convert.ToInt32(reader["PostedBy"].ToString()),
                            PostedUserType = reader["PostedUserType"].ToString()
                        };
                    }

                    connection.Close();
                }
            }
            return blog;
        }
        #endregion

    }
}