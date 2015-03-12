using System;
using System.Drawing;
using ProjectManagementVerification.DAL;

namespace ProjectManagementVerification.Dashboard
{
    public partial class EditProjectType : System.Web.UI.Page
    {
        private readonly ProjectTypeDb _db = new ProjectTypeDb();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PageData();
            }
        }

        private void PageData()
        {
            var projectTypeToEdit = SessionManager.ProjectTypeToEdit;
            if (projectTypeToEdit != null)
            {
                txtProjectTypeName.Text = projectTypeToEdit.Name;
                txtProjectTypeDescription.Text = projectTypeToEdit.Description;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            var projectTypeToUpdate = SessionManager.ProjectTypeToEdit;
            if (projectTypeToUpdate.Name != txtProjectTypeName.Text.Replace("'", "`"))
            {
                if (_db.ExistingValidationProjectType(txtProjectTypeName.Text.Replace("'", "`")))
                {
                    projectTypeToUpdate.Name = txtProjectTypeName.Text.Replace("'", "`");
                    projectTypeToUpdate.Description = txtProjectTypeDescription.Text.Replace("'", "`");
                    if (_db.Update(projectTypeToUpdate))
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
                else
                {
                    lblMessage.Text = "Sorry! The Project Type \"" + txtProjectTypeName.Text + "\" already exist";
                    lblMessage.ForeColor = Color.Red;
                }
            }
            else
            {
                projectTypeToUpdate.Name = txtProjectTypeName.Text.Replace("'", "`");
                projectTypeToUpdate.Description = txtProjectTypeDescription.Text.Replace("'", "`");
                if (_db.Update(projectTypeToUpdate))
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

            ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                            "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" +
                            lblMessage.ClientID +
                            "').style.display='none'\",8000)</script>");
            

        }

    }
}