using System;
using System.Data;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI.WebControls;
using ProjectManagementVerification.DAL;
using StudentBLL = ProjectManagementVerification.BLL.Student;

namespace ProjectManagementVerification.Students
{
    public partial class Welcome : System.Web.UI.Page
    {
        readonly CityDb _dbCity = new CityDb();
        readonly DepartmentDb _dbDepartment = new DepartmentDb();
        readonly StudentDb _dbStudent = new StudentDb();
        readonly ProjectRequestDb _dbProjectRequest = new ProjectRequestDb();

        private void LoadDepartmentToEdit()
        {
            var dtDepartment = _dbDepartment.Search(string.Empty, 0);
            if (dtDepartment != null)
            {
                for (int i = 0; i < dtDepartment.Rows.Count; i++)
                {
                    ddlDepartment.Items.Insert(i,
                        new ListItem(dtDepartment.Rows[i][1].ToString(), dtDepartment.Rows[i][0].ToString()));
                }
                ddlDepartment.SelectedValue = SessionManager.CurrentLoginStudent.DepartmentId.ToString();
               
            }

        }

        private void PageData()
        {
            var currentStudent = SessionManager.CurrentLoginStudent;
            if (currentStudent != null)
            {
                LoadDepartmentToEdit();
                var department = _dbDepartment.DepartmentById(currentStudent.DepartmentId);


                lblStudentId.Text = currentStudent.StudentId;
                lblFatherName.Text = currentStudent.FatherName == string.Empty ? "Not Mentioned" : currentStudent.FatherName;
                lblMotherName.Text = currentStudent.MotherName == string.Empty ? "Not Mentioned" : currentStudent.MotherName;
                lblCurrentSemester.Text = currentStudent.SemisterInfo;
                lblDateOfBirth.Text = currentStudent.DateOfBirth;
                lblDepartment.Text = department.Name;
                lblGender.Text = currentStudent.Gender;


                lblFullName.Text = currentStudent.FullName;
                lblEmail.Text = currentStudent.Email;
                lblAddress.Text = currentStudent.Address == string.Empty ? "No Address" : currentStudent.Address;
                lblContact.Text = currentStudent.Mobile == string.Empty ? "No Mobile" : currentStudent.Mobile;
                lblContact.Text += currentStudent.Mobile == string.Empty ? ", No Telephone" : ", " + currentStudent.Telephone;
                var cityInfo = _dbCity.CityById(Convert.ToInt32(currentStudent.CityId));
                string cityName = cityInfo.Name;
                lblCity.Text = cityName;
                imgProfilePic.ImageUrl = "../Students/" + currentStudent.Picture;


                //for Academic info edit on same page
                txtStudentId.Text = currentStudent.StudentId;
                txtCurrentSemester.Text = currentStudent.SemisterInfo;

                DataTable dtApprovedRequests = _dbProjectRequest.Search(currentStudent.Email, "Approved",
                    string.Empty, string.Empty, string.Empty);
                grdApprovedRequests.DataSource = dtApprovedRequests;
                grdApprovedRequests.EmptyDataText = "No Requests are approved";
                grdApprovedRequests.DataBind();
            }
            else
            {
                Response.Redirect("../View/Login.aspx");
            }
            
        }


        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               PageData();
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


        private string PhotoUpdate()
        {
            var photo = "";
            var currentStudent = SessionManager.CurrentLoginStudent;
            _key = GetUniqueKey(7);
            if (flStudentImage.HasFile)
            {
                var path = Path.GetFileName(flStudentImage.PostedFile.FileName);
                if (currentStudent.Picture != string.Empty)
                {
                    File.Delete(Path.Combine(Server.MapPath("~/Students/"), currentStudent.Picture));
                }
                _imageRename = (_key + path).Replace("'", "`");
                flStudentImage.SaveAs(Server.MapPath("~/Students/Photo/" + _imageRename));
                photo = "Photo/" + _imageRename;
            }
            return photo;
            //return string.Empty;
        }


        protected void btnImageUpdate_Click(object sender, EventArgs e)
        {
            var currentStudent = SessionManager.CurrentLoginStudent;
            if (flStudentImage.HasFile)
            {
                currentStudent.Picture = PhotoUpdate();
                if (_dbStudent.Update(currentStudent))
                {
                    Response.Write("Successful");
                }

            }
            imgProfilePic.ImageUrl = currentStudent.Picture;
        }

        protected void btnEditPersonalInfo_Click(object sender, EventArgs e)
        {
            Response.Redirect("EditPersonalInfo.aspx");
        }

        protected void btnUpdateAcademicInfo_Click(object sender, EventArgs e)
        {
            var currentStudent = SessionManager.CurrentLoginStudent;
            currentStudent.StudentId = txtStudentId.Text;
            currentStudent.DepartmentId = Convert.ToInt32(ddlDepartment.SelectedValue);
            currentStudent.SemisterInfo = txtCurrentSemester.Text;
            if (_dbStudent.Update(currentStudent))
            {
                Response.Write("Successfully Updated");
                PageData();
                SessionManager.CurrentLoginStudent = _dbStudent.StudentById(currentStudent.Id);
            }
            else
            {
                
            }
        }




    }
}