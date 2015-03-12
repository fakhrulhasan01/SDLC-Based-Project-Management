using System;
using System.Drawing;
using System.Web.UI.WebControls;
using ProjectManagementVerification.DAL;
using CityBLL = ProjectManagementVerification.BLL.City;

namespace ProjectManagementVerification.Dashboard
{
    public partial class CityEdit : System.Web.UI.Page
    {

        private readonly CityDb _db = new CityDb();
        private readonly CountryDb _dbCountry = new CountryDb();        

        private void LoadPage()
        {
            var city = SessionManager.CityToEdit;
            if (city != null)
            {
                txtCityName.Text = city.Name;
                ddlCountry.Items.Clear();
                var dt = _dbCountry.GetData(string.Empty, 1);
                if (dt == null) return;
                for (var i = 0; i < dt.Rows.Count; i++)
                {
                    ddlCountry.Items.Add(new ListItem(dt.Rows[i][1].ToString(), dt.Rows[i][0].ToString()));
                }
                if (city.CountryId == 0)
                {
                    ddlCountry.Items.Insert(0, "Select");
                }
                else
                {
                    ddlCountry.SelectedValue = city.CountryId.ToString();
                }
            }

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPage();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            var city = SessionManager.CityToEdit;
            city.Name = txtCityName.Text;
            city.CountryId = Convert.ToInt32(ddlCountry.SelectedValue);
            
            if (_db.ExistingValidationCity(txtCityName.Text.Replace("'", "`"), Convert.ToInt32(ddlCountry.SelectedValue)))
            {
                if (_db.Save(city))
                {
                    lblMessage.Text = "Successfully Inserted";
                    lblMessage.ForeColor = Color.Green;
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                        "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" +
                        lblMessage.ClientID +
                        "').style.display='none'\",10000)</script>");

                    LoadPage();
                }
                else
                {
                    lblMessage.Text = "Sorry! May be database connection failure";
                    lblMessage.ForeColor = Color.Red;
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                        "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" +
                        lblMessage.ClientID +
                        "').style.display='none'\",10000)</script>");

                    LoadPage();
                }
            }
            else
            {
                city.Name = "";
                city.CountryId = 0;
                lblMessage.Text = "The City <b>" + txtCityName.Text + "</b> on Country <b>" +
                                            ddlCountry.SelectedItem.Text + "</b> already exist";
                lblMessage.ForeColor = Color.Red;
                ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                    "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" +
                    lblMessage.ClientID +
                    "').style.display='none'\",10000)</script>");

                LoadPage();
            }


        }
    }
}