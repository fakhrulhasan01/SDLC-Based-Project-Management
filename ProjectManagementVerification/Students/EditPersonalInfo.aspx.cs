using System;
using System.Data;
using System.Web.UI.WebControls;
using ProjectManagementVerification.DAL;
using CityBLL = ProjectManagementVerification.BLL.City;


namespace ProjectManagementVerification.Students
{
    public partial class EditPersonalInfo : System.Web.UI.Page
    {
        private readonly StudentDb _dbStudent = new StudentDb();
        private readonly CountryDb _dbCountry = new CountryDb();
        private readonly CityDb _dbCity = new CityDb();
        private void LoadPageData()
        {
            var studentInfo = SessionManager.CurrentLoginStudent;
            if (studentInfo != null)
            {
                txtFullName.Text = studentInfo.FullName;
                txtAddress.Text = studentInfo.Address == string.Empty ? "Not Metioned" : studentInfo.Address;
                txtFatherName.Text = studentInfo.FatherName == string.Empty ? "Not Metioned" : studentInfo.FatherName;
                txtMotherName.Text = studentInfo.MotherName == string.Empty ? "Not Metioned" : studentInfo.MotherName;
                txtDateOfBirth.Text = studentInfo.DateOfBirth == string.Empty ? "Not Metioned" : studentInfo.DateOfBirth;
                

                
                
                if (studentInfo.Gender == "Male")
                {
                    ddlGender.Items.Insert(0, "Male");
                    ddlGender.Items.Insert(1, "Female");
                }
                else
                {
                    ddlGender.Items.Insert(0, "Female");
                    ddlGender.Items.Insert(1, "Male");                    
                }
                

                LoadCountryCity();

                txtPhoneNo.Text = studentInfo.Telephone;
                txtMobileNo.Text = studentInfo.Mobile;

            }

        }


        private void LoadCountryCity()
        {
            var city = _dbCity.CityById(Convert.ToInt32(SessionManager.CurrentLoginStudent.CityId));
            var country = _dbCountry.CountryById(city.CountryId);
            DataTable dtCountry = _dbCountry.GetData(string.Empty, 1);
            for (int i = 0; i < dtCountry.Rows.Count;  i++)
            {
                ddlCountry.Items.Insert(i, new ListItem(dtCountry.Rows[i][1].ToString(), dtCountry.Rows[i][0].ToString()));
            }
            ddlCountry.SelectedValue = country.Id.ToString();

            //Response.Write(city.CountryId.ToString());
            DataTable dtCity = _dbCity.Search(string.Empty, city.CountryId);
            for (int i = 0; i < dtCity.Rows.Count; i++)
            {
                ddlCity.Items.Insert(i, new ListItem(dtCity.Rows[i][1].ToString(), dtCity.Rows[i][0].ToString()));
            }
            ddlCity.SelectedValue = city.Id.ToString();

        }



        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                LoadPageData();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            var studentInfoToEdit = SessionManager.CurrentLoginStudent;
            studentInfoToEdit.FullName = txtFullName.Text;
            studentInfoToEdit.Address = txtAddress.Text=="Not Mentioned"?string.Empty:txtAddress.Text;
            studentInfoToEdit.FatherName = txtFatherName.Text == "Not Mentioned" ? string.Empty : txtFatherName.Text;
            studentInfoToEdit.MotherName = txtMotherName.Text == "Not Mentioned" ? string.Empty : txtMotherName.Text;
            studentInfoToEdit.Gender = ddlGender.SelectedValue;
            studentInfoToEdit.DateOfBirth = txtDateOfBirth.Text;
            studentInfoToEdit.CityId = Convert.ToInt32(Request.Form["ctl00$Slide$ddlCity"]);
            studentInfoToEdit.Telephone = txtPhoneNo.Text == "Not Mentioned" ? string.Empty : txtPhoneNo.Text;
            studentInfoToEdit.Mobile = txtMobileNo.Text == "Not Mentioned" ? string.Empty : txtMobileNo.Text;

            if (_dbStudent.Update(studentInfoToEdit))
            {
            }
        }




    }
}