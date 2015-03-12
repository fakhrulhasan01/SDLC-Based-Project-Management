using System;
using System.Globalization;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI.WebControls;
using ProjectManagementVerification.DAL;
using StudentBLL = ProjectManagementVerification.BLL.Student;

namespace ProjectManagementVerification.View
{
    public partial class StudentRegistration : System.Web.UI.Page
    {

        readonly StudentDb _db = new StudentDb();
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
            txtStudentId.Text = "";
            LoadCountry();
            LoadDepartment();
        }


        private void LoadCountry()
        {
            ddlCountry.Items.Insert(0, "Select");
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
                flStudentImage.SaveAs(Server.MapPath("~/Students/Photo/" + _imageRename));
                photo = "Photo/" + _imageRename;
            }
            return photo;
        }


        
        private void LoadDepartment()
        {
            ddlDepartment.Items.Clear();
            ddlDepartment.Items.Insert(0, "Select");
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



        protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadCity(Convert.ToInt32(ddlCountry.SelectedValue));
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            var student = new StudentBLL
            {
                FullName = txtFullName.Text.Replace("'", "`"),
                StudentId = txtStudentId.Text.Replace("'", "`"),
                FatherName = string.Empty,
                MotherName = string.Empty,
                Gender = ddlGender.SelectedValue,
                Email = txtEmail.Text.Replace("'","`"),
                Password = txtPassword.Text,
                Address = string.Empty,
                CityId = Convert.ToInt32(Request.Form["ctl00$Slide$ddlCity"]),//To take the city id as client mode using generated name by asp.net
                DepartmentId = Convert.ToInt32(ddlDepartment.SelectedValue),
                Telephone = string.Empty,
                Mobile = string.Empty,
                SemisterInfo = txtSemesterInfo.Text.Replace("'", "`"),
                DateOfBirth = string.Empty,
                JoinDate = DateTime.Now.ToString(CultureInfo.InvariantCulture),
                Status = "A",
                Picture = PhotoUpload()
            };

            if (_db.Save(student))
            {
                var dt = _db.Search(string.Empty, txtEmail.Text, string.Empty, 0, 0);
                var id = Convert.ToInt32(dt.Rows[0]["Id"]);
                


                Response.Write(id.ToString());
                SessionManager.CurrentLoginStudent = _db.StudentByEmail(txtEmail.Text);
                Response.Redirect("../Students/Welcome.aspx");
            }
            else
            {
                Response.Write("Failed");
            }

            /*Response.Write(txtFullName.Text.Replace("'", "`") + "<br/>");
            Response.Write(txtStudentId.Text.Replace("'", "`") + "<br/>");

            Response.Write(ddlGender.SelectedItem.Text.ToString() + "<br/>");
            
            Response.Write(txtEmail.Text.Replace("'", "`") + "<br/>");
            Response.Write(ddlCountry.SelectedValue + "<br/>");*/
            //Response.Write(Request.Form["ctl00$Slide$ddlCity"]);
                
            
            //Response.Write(ddlCountry.SelectedItem.Text + "<br/>");
            /*Response.Write(ddlDepartment.SelectedValue + "<br/>");
            Response.Write(txtSemesterInfo.Text.Replace("'", "`") + "<br/>");
            Response.Write(PhotoUpload());*/
        }

        protected void ddlCountry_SelectedIndexChanged1(object sender, EventArgs e)
        {
            if (ddlCountry.SelectedItem.Text != "Select")
            {
                LoadCity(Convert.ToInt32(ddlCountry.SelectedValue));
            }
            else
            {
                ddlCity.Items.Clear();
                ddlCity.Items.Insert(0, "Select");
            }
        }

       


        

    }
}