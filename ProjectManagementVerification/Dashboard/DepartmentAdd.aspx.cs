using System;
using System.Drawing;
using System.Web.UI.WebControls;
using ProjectManagementVerification.DAL;
using DepartmentBLL = ProjectManagementVerification.BLL.Department;

namespace ProjectManagementVerification.Dashboard
{
    public partial class DepartmentAdd : System.Web.UI.Page
    {

        readonly DepartmentDb _db = new DepartmentDb();

        public static int SearchType { get; set; }

        private void Reset()
        {
            txtDepartmentName.Text = "";
            GridView1.DataSource = null;
            GridView1.DataBind();
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
            var department = new DepartmentBLL
            {
                Name = txtDepartmentName.Text
            };
            if (_db.ExistingValidationDepartment(txtDepartmentName.Text.Replace("'", "`")))
            {
                if (_db.Save(department))
                {
                    lblMessage.Text = "Department Name Successfully Inserted";
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
                lblMessage.Text = "This Department is already exist";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                    "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + lblMessage.ClientID +
                    "').style.display='none'\",10000)</script>");
                Reset();
            }

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            SearchType = 0;
            GridView1.DataSource = _db.GetData(txtSearch.Text.Replace("'", "`"), SearchType);
            GridView1.DataBind();
            GridView1.EmptyDataText = "No Search Result Found";
        }

        protected void btnSearchAll_Click(object sender, EventArgs e)
        {
            SearchType = 1;
            GridView1.DataSource = _db.GetData(string.Empty, SearchType);
            GridView1.DataBind();
            GridView1.EmptyDataText = "No data found";
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            var dataKey = GridView1.DataKeys[e.NewEditIndex];
            if (dataKey != null)
            {
                var id = Convert.ToInt32(dataKey.Value);
                SessionManager.DepartmentToEdit = _db.DepartmentById(id);
                Response.Redirect("DepartmentEdit.aspx");
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
            var department = new DepartmentBLL
            {
                Id = id
            };
            if (_db.Delete(department))
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

        }
    }
}