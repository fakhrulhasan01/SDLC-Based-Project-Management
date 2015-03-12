using System;
using System.Drawing;
using System.Web.UI.WebControls;
using ProjectManagementVerification.DAL;
using CityBLL = ProjectManagementVerification.BLL.City;

namespace ProjectManagementVerification.Dashboard
{
    public partial class CityAdd : System.Web.UI.Page
    {
        private readonly CityDb _db = new CityDb();
        private readonly CountryDb _dbCountry = new CountryDb();        
        private static int SearchType { get; set; }
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

        private void Reset()
        {
            ddlCountry.Items.Clear();
            LoadCountry();
            GridView1.DataSource = null;
            GridView1.DataBind();
            ddlCountry.SelectedItem.Text = "Select";
            txtCityName.Text = "";
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Reset();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            var city = new CityBLL
            {
                Name = txtCityName.Text.Replace("'","`"),
                CountryId = Convert.ToInt32(ddlCountry.SelectedValue)
            };
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

                    Reset();
                }
                else
                {
                    lblMessage.Text = "Sorry! May be database connection failure";
                    lblMessage.ForeColor = Color.Red;
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                        "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" +
                        lblMessage.ClientID +
                        "').style.display='none'\",10000)</script>");

                    Reset();
                }
            }
            else
            {
                lblMessage.Text = "The City <b>" + txtCityName.Text + "</b> on Country <b>" + 
                                            ddlCountry.SelectedItem.Text +"</b> already exist"; 
                lblMessage.ForeColor = Color.Red;
                ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                    "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" +
                    lblMessage.ClientID +
                    "').style.display='none'\",10000)</script>");

                Reset();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            SearchType = 0;
            GridView1.DataSource = _db.GetData(txtSearch.Text.Replace("'", "`"), SearchType);
            GridView1.DataBind();
        }

        protected void btnSearchAll_Click(object sender, EventArgs e)
        {
            SearchType = 1;
            GridView1.DataSource = _db.GetData(string.Empty, SearchType);
            GridView1.DataBind();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            var dataKey = GridView1.DataKeys[e.NewEditIndex];
            if (dataKey != null)
            {
                var id = Convert.ToInt32(dataKey.Value);
                SessionManager.CityToEdit = _db.CityById(id);
                Response.Redirect("CityEdit.aspx");
            }

        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            var key = GridView1.DataKeys[e.RowIndex];
            var id = 0;
            if (key != null)
            {
                id = Convert.ToInt32(key.Value);
            }
            var city = new CityBLL
            {
                Id = id
            };
            if (_db.Delete(city))
            {
                lblMessage.Text = "City Successfully Deteted";
                lblMessage.ForeColor = Color.Green;
                ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                    "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" +
                    lblMessage.ClientID +
                    "').style.display='none'\",10000)</script>");

                Reset();
            }
            else
            {
                lblMessage.Text = "Sorry! Can't Delete for dependency";
                lblMessage.ForeColor = Color.Red;
                ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                    "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" +
                    lblMessage.ClientID +
                    "').style.display='none'\",10000)</script>");

                Reset();
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            if (SearchType == 0)
            {
                GridView1.DataSource = _db.GetData(txtSearch.Text.Replace("'", "`"), SearchType);
                GridView1.DataBind();
            }
            else
            {
                GridView1.DataSource = _db.GetData(string.Empty, SearchType);
                GridView1.DataBind();
            }
        }

        
    }
}