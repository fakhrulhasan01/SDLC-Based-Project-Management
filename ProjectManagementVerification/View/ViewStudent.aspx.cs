using System;
using System.Security.AccessControl;
using Microsoft.Owin;
using ProjectManagementVerification.DAL;
using ProjectManagementVerification.SecurityFiles;

namespace ProjectManagementVerification.View
{
    public partial class ViewStudent : System.Web.UI.Page
    {
        readonly CityDb _dbCity = new CityDb();
        readonly DepartmentDb _dbDepartment = new DepartmentDb();
        readonly StudentDb _dbStudent = new StudentDb();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PageData();
            }
        }


        private void PageData()
        {
            HashGenerator hg = new HashGenerator();
            string hashTwo = hg.Md5Hash(hg.Md5Hash(Request.QueryString["id"])); 
            string hashThree = hg.Md5Hash(hashTwo);
            Response.Write(Request.QueryString["id"]);
            
            if (Request.QueryString["id"] != null)
            {
                if ((hashTwo == Request.QueryString["key"]) && (hashThree == Request.QueryString["key2"]))
                {
                    var currentStudent = _dbStudent.StudentById(Convert.ToInt32(Request.QueryString["id"]));
                    var department = _dbDepartment.DepartmentById(currentStudent.DepartmentId);


                    lblStudentId.Text = currentStudent.StudentId;
                    lblFatherName.Text = currentStudent.FatherName == string.Empty
                        ? "Not Mentioned"
                        : currentStudent.FatherName;
                    lblMotherName.Text = currentStudent.MotherName == string.Empty
                        ? "Not Mentioned"
                        : currentStudent.MotherName;
                    lblCurrentSemester.Text = currentStudent.SemisterInfo;
                    lblDateOfBirth.Text = currentStudent.DateOfBirth;
                    lblDepartment.Text = department.Name;
                    lblGender.Text = currentStudent.Gender;


                    lblFullName.Text = currentStudent.FullName;
                    lblEmail.Text = currentStudent.Email;
                    lblAddress.Text = currentStudent.Address == string.Empty ? "No Address" : currentStudent.Address;
                    lblContact.Text = currentStudent.Mobile == string.Empty ? "No Mobile" : currentStudent.Mobile;
                    lblContact.Text += currentStudent.Mobile == string.Empty
                        ? ", No Telephone"
                        : ", " + currentStudent.Telephone;
                    var cityInfo = _dbCity.CityById(Convert.ToInt32(currentStudent.CityId));
                    string cityName = cityInfo.Name;
                    lblCity.Text = cityName;
                    imgProfilePic.ImageUrl = "../Students/" + currentStudent.Picture;



                }
                else
                {
                    Response.Redirect("../View/Login.aspx");
                }
            }
            else
            {
                Response.Redirect("../View/Login.aspx");
            }

        }



    }
}