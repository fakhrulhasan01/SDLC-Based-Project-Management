using System;
using ProjectManagementVerification.DAL;
using CountryBLL = ProjectManagementVerification.BLL.Country;

namespace ProjectManagementVerification.Dashboard
{
    public partial class CountryAdd : System.Web.UI.Page
    {
        readonly CountryDb _db = new CountryDb();

        public static int SearchType { get; set; }

        private void Reset()
        {
            txtCountryName.Text = "";
            GridView1.DataSource = null;
            GridView1.DataBind();
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            var country = new CountryBLL
            {
                Name = txtCountryName.Text
            };
            if (_db.ExistingValidationCountry(txtCountryName.Text.Replace("'","`")))
            {
                if (_db.Save(country))
                {
                    lblMessage.Text = "Country Name Successfully Inserted";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                        "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + lblMessage.ClientID +
                        "').style.display='none'\",10000)</script>");
                    Reset();
                }
                else
                {
                    lblMessage.Text = "May be database connection failure";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                        "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + lblMessage.ClientID +
                        "').style.display='none'\",10000)</script>");
                    Reset();
                }
            }
            else
            {
                lblMessage.Text = "This country is already exist";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                    "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + lblMessage.ClientID +
                    "').style.display='none'\",10000)</script>");
                Reset();                
            }
        }

        protected void btnSearchAll_Click(object sender, EventArgs e)
        {
            SearchType = 1;
            GridView1.DataSource = _db.GetData(string.Empty, SearchType);
            GridView1.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            SearchType = 0;
            GridView1.DataSource = _db.GetData(txtSearch.Text.Replace("'","`"), SearchType);
            GridView1.DataBind();
        }

        protected void GridView1_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            var dataKey = GridView1.DataKeys[e.NewEditIndex];
            if (dataKey != null)
            {
                var id = Convert.ToInt32(dataKey.Value);
                SessionManager.CountryToEdit = _db.CountryById(id);
                Response.Redirect("CountryEdit.aspx");
            }

        }

        protected void GridView1_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            if (SearchType == 0)
            {
                GridView1.DataSource = _db.GetData(txtSearch.Text, 0);
                GridView1.DataBind();
            }
            else
            {
                GridView1.DataSource = _db.GetData(string.Empty, 1);
                GridView1.DataBind();
            }
        }


    }
}