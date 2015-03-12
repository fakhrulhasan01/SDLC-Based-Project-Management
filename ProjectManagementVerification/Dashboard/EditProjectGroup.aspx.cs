using System;
using System.Data;
using System.Drawing;
using ProjectManagementVerification.DAL;
using CreateProjectGroupBLL = ProjectManagementVerification.BLL.CreateProjectGroup;

namespace ProjectManagementVerification.Dashboard
{
    public partial class EditProjectGroup : System.Web.UI.Page
    {
        private readonly CreateProjectGroupDb _dbCreateProjectGroup = new CreateProjectGroupDb();
        private readonly StudentAssignToGroupDb _dbStudentAssignToGroup = new StudentAssignToGroupDb();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPageData();
            }
        }

        private void LoadPageData()
        {
            CreateProjectGroupBLL projectGroup = SessionManager.CreateProjectGroupToEdit;
            if (projectGroup != null)
            {
                txtGroupId.Text = projectGroup.GroupId;
                if (projectGroup.Description == string.Empty)
                {
                    txtGroupDescription.Attributes["placeholder"] = "No Description saved";
                }
                else
                {
                    txtGroupDescription.Text = projectGroup.Description;
                }
                ddlGroupType.SelectedValue = projectGroup.GroupType;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            var projectGroup = SessionManager.CreateProjectGroupToEdit;
            if (_dbCreateProjectGroup.ExistingValidationCreateProjectGroup(txtGroupId.Text.Replace("'", "`")) || 
                (projectGroup.GroupId == txtGroupId.Text.Replace("'", "`")))
            {
                DataTable dtCheckMultipleStudentInMultiple =
                    _dbStudentAssignToGroup.Search(SessionManager.CurrentLoginTeacher.Id,
                        0, "Active", string.Empty, string.Empty, projectGroup.Id, string.Empty);
                if (ddlGroupType.SelectedItem.Text == "Single" && dtCheckMultipleStudentInMultiple.Rows.Count > 1)
                {
                    lblMessage.Text = "This group contains multiple students. Can't Change Mode to Single";
                    lblMessage.ForeColor = Color.Red;
                }
                else
                {
                    projectGroup.GroupId = txtGroupId.Text.Replace("'", "`");
                    projectGroup.Description = txtGroupDescription.Text.Replace("'", "`");
                    projectGroup.GroupType = ddlGroupType.SelectedValue;

                    if (_dbCreateProjectGroup.Update(projectGroup))
                    {
                        lblMessage.Text = "Successfully Updated";
                        lblMessage.ForeColor = Color.Green;
                    }
                    else
                    {
                        lblMessage.Text = "Failed to update";
                        lblMessage.ForeColor = Color.Red;
                    }
                }
                //Response.Write(_dbCreateProjectGroup.Update(projectGroup));
            }
            else
            {
                lblMessage.Text = "The Group Id is already exist";
                lblMessage.ForeColor = Color.Red;
            }


            ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" +
                lblMessage.ClientID +
                "').style.display='none'\",8000)</script>");
        }


    }
}