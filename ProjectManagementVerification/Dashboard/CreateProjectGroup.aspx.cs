using System;
using System.Drawing;
using System.Globalization;
using System.Web.UI.WebControls;
using ProjectManagementVerification.DAL;
using CreateProjectGroupBLL = ProjectManagementVerification.BLL.CreateProjectGroup;

namespace ProjectManagementVerification.Dashboard
{
    public partial class CreateProjectGroup : System.Web.UI.Page
    {
        private readonly CreateProjectGroupDb _dbCreateProjectGroup = new CreateProjectGroupDb();
        private static int SearchType { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            var projectGroup = new CreateProjectGroupBLL
            {
                Id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value)
            };
            if (_dbCreateProjectGroup.Delete(projectGroup))
            {
                lblMessage.Text = "Successfully Deleted";
                lblMessage.ForeColor = Color.Green;
            }
            else
            {
                lblMessage.Text = "Sorry! Can't delete. May used somewhere";
                lblMessage.ForeColor = Color.Red;
            }
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int id = Convert.ToInt32(GridView1.DataKeys[e.NewEditIndex].Value);
            SessionManager.CreateProjectGroupToEdit = _dbCreateProjectGroup.CreateProjectGroupById(id);
            Response.Redirect("EditProjectGroup.aspx");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            
        }

        protected void btnSearchAll_Click(object sender, EventArgs e)
        {
            SearchType = 1;
            GridView1.DataSource = _dbCreateProjectGroup.GetData(string.Empty, SearchType, 
                SessionManager.CurrentLoginTeacher.Id);
            GridView1.DataBind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            var projectGroup = new CreateProjectGroupBLL
            {
                GroupId = txtGroupId.Text.Replace("'", "`"),
                Description = txtGroupDescription.Text.Replace("'", "`"),
                GroupType = ddlGroupType.SelectedValue,
                CreatedBy = SessionManager.CurrentLoginTeacher.Id,
                CreationDate = DateTime.Now.ToString(CultureInfo.InvariantCulture),
                Status = "Active"
            };
            if (_dbCreateProjectGroup.ExistingValidationCreateProjectGroup(txtGroupId.Text.Replace("'", "`")))
            {
                if (_dbCreateProjectGroup.Save(projectGroup))
                {
                    lblMessage.Text = "Group Successfully Saved";
                    lblMessage.ForeColor = Color.Green;
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                        "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + lblMessage.ClientID +
                        "').style.display='none'\",5000)</script>");

                }
                else
                {
                    lblMessage.Text = "Sorry! Failed";
                    lblMessage.ForeColor = Color.Green;
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                        "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + lblMessage.ClientID +
                        "').style.display='none'\",5000)</script>");

                }
            }
            else
            {
                lblMessage.Text = "Sorry! This group is already exist";
                lblMessage.ForeColor = Color.Red;
                ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                        "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + lblMessage.ClientID +
                        "').style.display='none'\",5000)</script>");

            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            if (SearchType == 0)
            {
                GridView1.DataSource = _dbCreateProjectGroup.GetData(txtSearch.Text, 0, 
                    SessionManager.CurrentLoginTeacher.Id);
                GridView1.DataBind();
            }
            else
            {
                GridView1.DataSource = _dbCreateProjectGroup.GetData(string.Empty, 1, 
                    SessionManager.CurrentLoginTeacher.Id);
                GridView1.DataBind();
            }
        }


    }
}