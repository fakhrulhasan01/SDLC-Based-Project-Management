using System.Configuration;
using System.Data.SqlClient;

namespace ProjectManagementVerification
{
    public class ConnectDb
    {
        public static SqlConnection GetSqlConnection()
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ProjectManagementDB"].ConnectionString;
            var conn = new SqlConnection(connectionString);
            return conn;
        }
    }
}
