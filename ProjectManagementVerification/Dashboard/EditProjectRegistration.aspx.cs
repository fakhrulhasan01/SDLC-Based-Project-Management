using System;
using System.Data;
using System.Drawing;
using System.Web.UI.WebControls;
using ProjectManagementVerification.DAL;
using ProjectRegistrationBLL = ProjectManagementVerification.BLL.ProjectRegistration;

namespace ProjectManagementVerification.Dashboard
{
    public partial class EditProjectRegistration : System.Web.UI.Page
    {
        private readonly ProjectRegistrationDb _db = new ProjectRegistrationDb();
        private readonly CreateProjectGroupDb _dbCreateProjectGroup = new CreateProjectGroupDb();
        private readonly ProjectTypeDb _dbProjectType = new ProjectTypeDb();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPageData();
            }
        }

        private void LoadPageData()
        {
            var projectToEdit = SessionManager.ProjectRegistrationToEdit;
            if (projectToEdit != null)
            {
                txtProjectTitle.Text = projectToEdit.ProjectTitle;
                if (projectToEdit.ProjectSummary != string.Empty)
                {
                    txtProjectSummary.Text = projectToEdit.ProjectSummary;
                }
                else
                {
                    txtProjectSummary.Attributes["placeholder"] = "Write Your Project Summary";
                }
                ddlStatus.SelectedValue = projectToEdit.Status;

                DataTable dtProjectGroup = _dbCreateProjectGroup.GetData(string.Empty, 1,
                    SessionManager.CurrentLoginTeacher.Id);
                if (dtProjectGroup.Rows.Count > 0)
                {
                    for (int i = 0; i < dtProjectGroup.Rows.Count; i++)
                    {
                        ddlProjectGroup.Items.Insert(i, new ListItem(dtProjectGroup.Rows[i]["GroupId"].ToString(),
                            dtProjectGroup.Rows[i]["Id"].ToString()));
                    }
                    ddlProjectGroup.SelectedValue = projectToEdit.GroupId.ToString();
                }


                var dtProjectType = _dbProjectType.GetData(string.Empty, 1);
                if (dtProjectType.Rows.Count > 0)
                {
                    for (int i = 0; i < dtProjectType.Rows.Count; i++)
                    {
                        ddlProjectType.Items.Insert(i, new ListItem(dtProjectType.Rows[i]["Name"].ToString(),
                            dtProjectType.Rows[i]["Id"].ToString()));
                    }
                    ddlProjectType.Items.Insert(0, "Select Project Type");
                    ddlProjectType.SelectedValue = projectToEdit.ProjectTypeId.ToString();
                }
            }


        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            var projectToEdit = SessionManager.ProjectRegistrationToEdit;
            projectToEdit.ProjectTitle = txtProjectTitle.Text.Replace("'", "`");
            projectToEdit.ProjectSummary = txtProjectSummary.Text.Replace("'", "`");
            projectToEdit.ProjectTypeId = Convert.ToInt32(ddlProjectType.SelectedValue);
            projectToEdit.GroupId = Convert.ToInt32(ddlProjectGroup.SelectedValue);
            projectToEdit.Status = ddlStatus.SelectedValue;

            if (_db.ExistingValidationProjectRegistration(Convert.ToInt32(ddlProjectGroup.SelectedValue)))
            {
                if (_db.Update(projectToEdit, "No"))
                {
                    lblMessage.Text = "Successfully Updated";
                    lblMessage.ForeColor = Color.Green;
                }
                else
                {
                    lblMessage.Text = "Failed to Update";
                    lblMessage.ForeColor = Color.Red;
                }
            }
            else
            {
                if (_db.Update(projectToEdit, "Yes"))
                {
                    lblMessage.Text = "Successfully Updated";
                    lblMessage.ForeColor = Color.Green;
                }
                else
                {
                    lblMessage.Text = "Failed to Update";
                    lblMessage.ForeColor = Color.Red;
                }   
            }

            ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + lblMessage.ClientID +
                "').style.display='none'\",6000)</script>");
        }
    }
}