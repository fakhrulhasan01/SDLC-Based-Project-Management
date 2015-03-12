using System;
using System.Drawing;
using System.Web.UI.WebControls;
using ProjectManagementVerification.DAL;

namespace ProjectManagementVerification.Dashboard
{
    public partial class EditChecklist : System.Web.UI.Page
    {
        private readonly ChecklistDb _dbChecklist = new ChecklistDb();
        private readonly ProjectPhaseDb _dbProjectPhase = new ProjectPhaseDb();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPageData();
            }
        }

        private void LoadPageData()
        {
            var currentLoginTeacher = SessionManager.CurrentLoginTeacher;
            var checklistToEdit = SessionManager.ChecklistToEdit;
            if (checklistToEdit != null)
            {
                var dtProjectPhases = _dbProjectPhase.GetData(string.Empty, 1);
                for (int i = 0; i < dtProjectPhases.Rows.Count; i++)
                {
                    ddlProjectPhase.Items.Insert(0, new ListItem(dtProjectPhases.Rows[i]["PhaseName"].ToString(),
                        dtProjectPhases.Rows[i]["Id"].ToString()));
                }
                ddlProjectPhase.SelectedValue = checklistToEdit.ProjectPhaseId.ToString();


                txtChecklistName.Text = checklistToEdit.ChecklistName;
                if (checklistToEdit.ChecklistDescription == string.Empty)
                {
                    txtChecklistDescription.Attributes["placeholder"] = "No Description added";
                }
                else
                {
                    txtChecklistDescription.Text = checklistToEdit.ChecklistDescription;
                }

                ddlChecklistType.SelectedItem.Text = checklistToEdit.ChecklistType;
                ddlStatus.SelectedItem.Text = checklistToEdit.Status;
            }

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            var checklistToEdit = SessionManager.ChecklistToEdit;
            var currentLoginTeacher = SessionManager.CurrentLoginTeacher;
            string checklistType = currentLoginTeacher.UserType == "a" ? ddlChecklistType.SelectedValue : "Custom";


            checklistToEdit.ProjectPhaseId = Convert.ToInt32(ddlProjectPhase.SelectedValue);
            checklistToEdit.ChecklistName = txtChecklistName.Text.Replace("'", "`");
            checklistToEdit.ChecklistDescription = txtChecklistDescription.Text.Replace("'", "`");
            checklistToEdit.ChecklistType = checklistType;
            checklistToEdit.CreatedBy = SessionManager.CurrentLoginTeacher.Id;
            checklistToEdit.Status = ddlStatus.SelectedValue;
                
            if (_dbChecklist.ExistingValidationChecklist(Convert.ToInt32(ddlProjectPhase.SelectedValue),
                txtChecklistName.Text.Replace("'", "`"), checklistType))
            {
                if (_dbChecklist.Update(checklistToEdit, "No"))
                {
                    lblMessage.Text = "Successfully Updated";
                    lblMessage.ForeColor = Color.Green;
                    SessionManager.ChecklistToEdit = _dbChecklist.ChecklistById(checklistToEdit.Id);
                    LoadPageData();
                }
                else
                {
                    lblMessage.Text = "Failed to update";
                    lblMessage.ForeColor = Color.Red;
                }
            }
            else
            {
                if (_dbChecklist.Update(checklistToEdit, "Yes"))
                {
                    lblMessage.Text = "Successfully Updated";
                    lblMessage.ForeColor = Color.Green;
                    SessionManager.ChecklistToEdit = _dbChecklist.ChecklistById(checklistToEdit.Id);
                    LoadPageData();
                }
                else
                {
                    lblMessage.Text = "Failed to update";
                    lblMessage.ForeColor = Color.Red;
                }
            }

        }



    }
}