using System;
using System.Data;
using System.Web.UI.WebControls;
using ProjectManagementVerification.DAL;
using ProjectManagementVerification.BLL;

namespace ProjectManagementVerification.Dashboard
{
    public partial class EditPersonalInfo : System.Web.UI.Page
    {
        private readonly CountryDb _dbCountry = new CountryDb();
        private readonly CityDb _dbCity = new CityDb();
        private readonly TeacherDb _dbTeacher = new TeacherDb();

        private void LoadCountryCity()
        {
            City city = _dbCity.CityById(Convert.ToInt32(SessionManager.CurrentLoginTeacher.CityId));
            Country country = _dbCountry.CountryById(city.CountryId);
            DataTable dtCountry = _dbCountry.GetData(string.Empty, 1);
            for (int i = 0; i < dtCountry.Rows.Count; i++)
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


        public void PageData()
        {
            var currentTeacher = SessionManager.CurrentLoginTeacher;
            if (currentTeacher != null)
            {
                txtFullName.Text = currentTeacher.FullName;
                //txtAddress.Text = currentTeacher.Address;

                if (currentTeacher.Gender == "Male")
                {
                    ddlGender.SelectedItem.Text = "Male";
                }
                else
                {
                    ddlGender.SelectedItem.Text = "Female";
                }

                
                if (currentTeacher.Address != string.Empty)
                {
                    txtAddress.Text = currentTeacher.Address;
                }
                else
                {
                    txtAddress.Attributes["placeholder"] = "Not Mentioned";
                }



                if (currentTeacher.Telephone != string.Empty)
                {
                    txtPhone.Text = currentTeacher.Telephone;
                }
                else
                {
                    txtPhone.Attributes["placeholder"] = "Not Mentioned";
                }


                if (currentTeacher.Mobile != string.Empty)
                {
                    txtMobile.Text = currentTeacher.Mobile;
                }
                else
                {
                    txtMobile.Attributes["placeholder"] = "Not Mentioned";
                }


                LoadCountryCity();

                txtPhone.Text = currentTeacher.Telephone;
                txtMobile.Text = currentTeacher.Mobile;
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PageData();
            }
        }

        protected void btnUpdatePersonalInfo_Click(object sender, EventArgs e)
        {
            var teacher = SessionManager.CurrentLoginTeacher;
            teacher.FullName = txtFullName.Text.Replace("'", "`");
            teacher.Address = txtAddress.Text.Replace("'", "`");
            teacher.CityId = Convert.ToInt32(ddlCity.SelectedValue);
            teacher.Telephone = txtPhone.Text.Replace("'", "`");
            teacher.Mobile = txtMobile.Text.Replace("'", "`");
            teacher.Gender = ddlGender.Text;

            if (_dbTeacher.Update(teacher))
            {
                SessionManager.CurrentLoginTeacher = _dbTeacher.TeacherById(teacher.Id);
                lblMessage.Text = "Your Information Successfully Updated";
                lblMessage.ForeColor = System.Drawing.Color.Green;
                PageData();
            }
            else
            {
                lblMessage.Text = "Sorry!! Can't Update";
            }
        }




    }
}