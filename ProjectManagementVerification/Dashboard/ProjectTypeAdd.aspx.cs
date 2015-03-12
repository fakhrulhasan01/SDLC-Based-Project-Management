using System;
using System.Drawing;
using System.Web.UI.WebControls;
using ProjectManagementVerification.DAL;
using ProjectTypeBLL = ProjectManagementVerification.BLL.ProjectType;

namespace ProjectManagementVerification.Dashboard
{
    public partial class ProjectTypeAdd : System.Web.UI.Page
    {
        private readonly ProjectTypeDb _db = new ProjectTypeDb();
        private static int SearchType { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (SessionManager.CurrentLoginTeacher != null)
                {
                    if (SessionManager.CurrentLoginTeacher.UserType != "a")
                    {
                        Response.Redirect("../View/Login.aspx");
                    }
                    else
                    {
                        PageData();
                    }
                }
                else
                {
                    Response.Redirect("../View/Login.aspx");
                }
            }
        }

        private void PageData()
        {
            txtProjectTypeName.Text = "";
            txtProjectTypeDescription.Text = "";
            txtSearch.Text = "";
            txtModifyId.Text = "";
            GridView1.DataSource = null;
            GridView1.DataBind();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int id = Convert.ToInt32(GridView1.DataKeys[e.NewEditIndex].Value);
            SessionManager.ProjectTypeToEdit = _db.ProjectTypeById(id);
            Response.Redirect("EditProjectType.aspx");
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (_db.ExistingValidationProjectType(txtProjectTypeName.Text.Replace("'", "`")))
            {
                var projectType = new ProjectTypeBLL
                {
                    Name = txtProjectTypeName.Text.Replace("'", "`"),
                    Description = txtProjectTypeDescription.Text.Replace("'", "`")
                };
                if (_db.Save(projectType))
                {
                    lblMessage.Text = "Successfully Added";
                    lblMessage.ForeColor = Color.Green;
                    PageData();
                }
                else
                {
                    lblMessage.Text = "Failed to Add";
                    lblMessage.ForeColor = Color.Red;
                }

            }
            else
            {
                lblMessage.Text = "The Project Type \"<b>"+txtProjectTypeName.Text.Replace("'","`")+"</b>\" already exist";
                lblMessage.ForeColor = Color.Red;
            }
            ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                            "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" +
                            lblMessage.ClientID +
                            "').style.display='none'\",8000)</script>");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            //Response.Write(txtModifyId.Text);
            SearchType = 0;
            GridView1.DataSource = _db.GetData(txtSearch.Text.Replace("'", "`"), SearchType);
            GridView1.DataBind();
            //Response.Write(_db.GetData(txtSearch.Text.Replace("'","`"), SearchType));
        }

        protected void btnSearchAll_Click(object sender, EventArgs e)
        {
            SearchType = 1;
            GridView1.DataSource = _db.GetData(txtSearch.Text.Replace("'", "`"), SearchType);
            GridView1.DataBind();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            var projectType = new ProjectTypeBLL
            {
                Id = Convert.ToInt32(txtModifyId.Text)
            };
            if (_db.Delete(projectType))
            {
                lblMessage.Text = "Successfully Deleted";
                lblMessage.ForeColor = Color.Green;
                PageData();
            }
            else
            {
                lblMessage.Text = "Failed to delete";
                lblMessage.ForeColor = Color.Red;
            }
            ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                            "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" +
                            lblMessage.ClientID +
                            "').style.display='none'\",8000)</script>");
        }


    }
}