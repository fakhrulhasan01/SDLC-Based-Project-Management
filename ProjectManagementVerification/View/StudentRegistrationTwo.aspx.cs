using System;
using System.Web.UI.WebControls;
using ProjectManagementVerification.DAL;

namespace ProjectManagementVerification.View
{
    public partial class StudentRegistrationTwo : System.Web.UI.Page
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

        protected void btnRegister_Click(object sender, EventArgs e)
        {

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
            ddlCity.Items.Insert(0, "Select City");
            var dt = _dbCity.Search(string.Empty, countryId);
            if (dt == null) return;
            for (var i = 0; i < dt.Rows.Count; i++)
            {
                ddlCity.Items.Add(new ListItem(dt.Rows[i][1].ToString(), dt.Rows[i][0].ToString()));
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
            ddlCountry.Items.Insert(0, "Select Country");
            var dt = _dbCountry.GetData(string.Empty, 1);
            if (dt == null) return;
            for (var i = 0; i < dt.Rows.Count; i++)
            {
                ddlCountry.Items.Add(new ListItem(dt.Rows[i][1].ToString(), dt.Rows[i][0].ToString()));
            }
        }



    }
}