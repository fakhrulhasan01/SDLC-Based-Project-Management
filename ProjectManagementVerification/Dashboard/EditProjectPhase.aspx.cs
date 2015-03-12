using System;
using System.Data;
using System.Drawing;
using System.Web.UI.WebControls;
using ProjectManagementVerification.DAL;
using ProjectPhaseBLL = ProjectManagementVerification.BLL.ProjectPhase;

namespace ProjectManagementVerification.Dashboard
{
    public partial class EditProjectPhase : System.Web.UI.Page
    {
        private readonly ProjectPhaseDb _dbProjectPhase = new ProjectPhaseDb();
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
            var projectPhaseToEdit = SessionManager.ProjectPhaseToEdit;
            if (projectPhaseToEdit != null)
            {
                DataTable dtProjectType = _dbProjectType.GetData(string.Empty, 1);
                for (int i = 0; i < dtProjectType.Rows.Count; i++)
                {
                    ddlProjectType.Items.Insert(i, new ListItem(dtProjectType.Rows[i][1].ToString(),
                        dtProjectType.Rows[i][0].ToString()));
                }
                ddlProjectType.SelectedValue = projectPhaseToEdit.ProjectTypeId.ToString();

                txtProjectPhaseName.Text = projectPhaseToEdit.PhaseName;
                if (projectPhaseToEdit.PhaseDescription == string.Empty)
                {
                    txtPhaseDescription.Attributes["placeholder"] = "Not Mentioned";
                }
                else
                {
                    txtPhaseDescription.Text = projectPhaseToEdit.PhaseDescription;
                }
                ddlPriority.SelectedValue = projectPhaseToEdit.Priority.ToString();
            }
        }


        protected void btnSave_Click(object sender, EventArgs e)
        {
                var projectPhaseToEdit = SessionManager.ProjectPhaseToEdit;
                projectPhaseToEdit.ProjectTypeId = Convert.ToInt32(ddlProjectType.SelectedValue);
                projectPhaseToEdit.PhaseName = txtProjectPhaseName.Text.Replace("'", "`");
                projectPhaseToEdit.PhaseDescription = txtPhaseDescription.Text.Replace("'", "`");
                projectPhaseToEdit.Priority = Convert.ToInt32(ddlPriority.SelectedValue);
                
                if (_dbProjectPhase.ExistingValidationProjectPhase(Convert.ToInt32(ddlProjectType.SelectedValue),
                    ddlPriority.SelectedValue.ToString()))
                {
                    if (_dbProjectPhase.Update(projectPhaseToEdit, "No"))
                    {
                        lblMessage.Text = "Successfully Updated";
                        lblMessage.ForeColor = Color.ForestGreen;
                    }
                    else
                    {
                        lblMessage.Text = "Failed to Update";
                        lblMessage.ForeColor = Color.Red;
                    }
                }
                else
                {
                    if (_dbProjectPhase.Update(projectPhaseToEdit, "Yes"))
                    {
                        lblMessage.Text = "Successfully Updated";
                        lblMessage.ForeColor = Color.ForestGreen;
                    }
                    else
                    {
                        lblMessage.Text = "Failed to Update";
                        lblMessage.ForeColor = Color.Red;
                    }    
                }
            
                ClientScript.RegisterStartupScript(GetType(), "HideLabel",
               "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + lblMessage.ClientID +
               "').style.display='none'\",10000)</script>");
        }




    }
}