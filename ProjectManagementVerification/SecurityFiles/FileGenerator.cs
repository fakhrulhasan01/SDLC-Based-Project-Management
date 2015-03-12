using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Web.Hosting;

namespace ProjectManagementVerification.SecurityFiles
{
    public class FileGenerator
    {

        public string GetUniqueKey(int maxSize)
        {
            var chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890".ToCharArray();
            var data = new byte[1];
            var crypto = new RNGCryptoServiceProvider();
            crypto.GetNonZeroBytes(data);
            data = new byte[maxSize];
            crypto.GetNonZeroBytes(data);
            var result = new StringBuilder(maxSize);
            foreach (var b in data)
            {
                result.Append(chars[b % (chars.Length)]);
            }
            return result.ToString();
        }



        public string CreateFile(string data)
        {
            string fileName = GetUniqueKey(14) + ".txt";
            var userData = data;

            var dataFile = HostingEnvironment.MapPath("~/TextFiles/" + fileName);
            File.WriteAllText(@dataFile, userData);
            return fileName;
        }

        public string CreateFile(string data, string path)
        {
            string fileName = GetUniqueKey(14) + ".txt";
            var userData = data;

            var dataFile = HostingEnvironment.MapPath("~/"+path+"/" + fileName);
            File.WriteAllText(@dataFile, userData);
            return fileName;
        }

    }
}