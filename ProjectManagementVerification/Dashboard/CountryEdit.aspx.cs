using System;
using System.Globalization;
using ProjectManagementVerification.DAL;

namespace ProjectManagementVerification.Dashboard
{
    public partial class CountryEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPage();
            }
        }

        

        private void LoadPage()
        {
            var country = SessionManager.CountryToEdit;
            if (country != null)
            {
                txtCountryName.Text = country.Name;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

        }


    }
}