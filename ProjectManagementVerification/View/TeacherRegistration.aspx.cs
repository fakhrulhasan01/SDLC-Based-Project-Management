using System;
using System.Globalization;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI.WebControls;
using ProjectManagementVerification.DAL;
using TeacherBLL = ProjectManagementVerification.BLL.Teacher;




namespace ProjectManagementVerification.View
{
    public partial class TeacherRegistration : System.Web.UI.Page
    {
        readonly TeacherDb _db = new TeacherDb();
        readonly DepartmentDb _dbDepartment = new DepartmentDb();
        readonly CountryDb _dbCountry = new CountryDb();
        readonly CityDb _dbCity = new CityDb();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Reset();
            }
        }

        private void Reset()
        {
            txtFullName.Text = "";
            txtEmail.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
            txtEmployeeId.Text = "";
            LoadCountry();
            LoadDepartment();
        }


        private void LoadCountry()
        {
            ddlCountry.Items.Insert(0, "Select Country");
            var dt = _dbCountry.GetData(string.Empty, 1);
            if (dt == null) return;
            for (var i = 0; i < dt.Rows.Count; i++)
            {
                ddlCountry.Items.Add(new ListItem(dt.Rows[i][1].ToString(), dt.Rows[i][0].ToString()));
            }
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



        private string _key;
        private string _imageRename;
        //Method for ImageUpload
        private string PhotoUpload()
        {
            var photo = "";
            _key = GetUniqueKey(7);
            if (flStudentImage.HasFile)
            {
                var path = Path.GetFileName(flStudentImage.PostedFile.FileName);
                _imageRename = (_key + path).Replace("'", "`");
                flStudentImage.SaveAs(Server.MapPath("~/Dashboard/Photo/" + _imageRename));
                photo = "Photo/" + _imageRename;
            }
            return photo;
        }



        private void LoadDepartment()
        {
            ddlDepartment.Items.Clear();
            ddlDepartment.Items.Insert(0, "Select Department");
            var dt = _dbDepartment.GetData(string.Empty, 1);
            if (dt == null) return;
            for (var i = 0; i < dt.Rows.Count; i++)
            {
                ddlDepartment.Items.Add(new ListItem(dt.Rows[i][1].ToString(), dt.Rows[i][0].ToString()));
            }
        }

        private void LoadCity(int countryId)
        {
            ddlCity.Items.Clear();
            ddlCity.Items.Insert(0, "Select");
            var dt = _dbCity.Search(string.Empty, countryId);
            if (dt == null) return;
            for (var i = 0; i < dt.Rows.Count; i++)
            {
                ddlCity.Items.Add(new ListItem(dt.Rows[i][1].ToString(), dt.Rows[i][0].ToString()));
            }
        }




        protected void btnRegister_Click(object sender, EventArgs e)
        {
            var teacher = new TeacherBLL
            {
                FullName = txtFullName.Text.Replace("'","`"),
                EmployeeId =  txtEmployeeId.Text.Replace("'", "`"),
                Address = string.Empty,
                CityId = Convert.ToInt32(Request.Form["ctl00$Main$ddlCity"]),
                DepartmentId = Convert.ToInt32(ddlDepartment.SelectedValue),
                Designation = txtDesignation.Text.Replace("'", "`"),
                Email = txtEmail.Text.Replace("'", "`"),
                Password = txtPassword.Text.Replace("'", "`"),
                Gender = ddlGender.SelectedItem.Text,
                JoinDate = DateTime.Now.ToString(CultureInfo.InvariantCulture),
                Telephone = string.Empty,
                Mobile = string.Empty,
                UserType = "t",
                Status = "a",
                Picture = PhotoUpload()
            };

            if (_db.Save(teacher))
            {
                SessionManager.CurrentLoginTeacher = _db.TeacherByEmail(txtEmail.Text.Replace("'", "`"));
                Response.Redirect("../Dashboard/Welcome.aspx");
            }
            else
            {
                
            }
            
        }


    }
}