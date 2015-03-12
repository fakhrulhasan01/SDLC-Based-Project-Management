using System;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using ProjectManagementVerification.DAL;
using ProjectManagementVerification.SecurityFiles;
using BlogBLL = ProjectManagementVerification.BLL.Blog;

namespace ProjectManagementVerification.View
{
    public partial class PostOnBlog : System.Web.UI.Page
    {
        private readonly BlogDb _db = new BlogDb();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (SessionManager.CurrentLoginStudent != null)
                {

                }
                else if (SessionManager.CurrentLoginTeacher != null)
                {

                }
                else
                {
                    Response.Redirect("Default.aspx");
                }
            }
        }

        private string _key;
        private string _imageRename;
        //Method for ImageUpload
        private string PhotoUpload()
        {
            var photo = "";
            _key = GetUniqueKey(7);
            if (flBlogImage.HasFile)
            {
                var path = Path.GetFileName(flBlogImage.PostedFile.FileName);
                _imageRename = (_key + path).Replace("'", "`");
                flBlogImage.SaveAs(Server.MapPath("~/View/BlogImages/" + _imageRename));
                photo = _imageRename;
            }
            else
            {
                photo = string.Empty;
            }
            return photo;
        }

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

        protected void btnPost_Click(object sender, EventArgs e)
        {
            int userId = 0;
            string userType = string.Empty;
            if (SessionManager.CurrentLoginStudent != null)
            {
                userId = SessionManager.CurrentLoginStudent.Id;
                userType = "s";
            }else if (SessionManager.CurrentLoginTeacher != null)
            {
                userId = SessionManager.CurrentLoginTeacher.Id;
                userType = "t";
            }
            var fileGenerator = new FileGenerator();
            var blog = new BlogBLL
            {
                Title = txtBlogTitle.Text.Replace("'","`"),
                Description = fileGenerator.CreateFile(txtBlogContent.Text, "TextFiles/BlogTextFiles"),
                PostDate = DateTime.Now.ToString(CultureInfo.InvariantCulture),
                Tags = txtTags.Text.Replace("'","`"),
                PostedBy = userId,
                PostedUserType = userType,
                Picture = PhotoUpload()
            };
            if (_db.Save(blog))
            {
                lblMessage.Text = "Successfully posted on blog";
                lblMessage.ForeColor = Color.Green;
            }
            else
            {
                lblMessage.Text = "Failed";
                lblMessage.ForeColor = Color.Red;
            }
        }
    }
}