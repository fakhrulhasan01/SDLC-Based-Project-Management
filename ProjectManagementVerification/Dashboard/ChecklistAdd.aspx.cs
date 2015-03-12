using System;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Web.UI.WebControls;
using ProjectManagementVerification.DAL;
using ChecklistBLL = ProjectManagementVerification.BLL.Checklist;

namespace ProjectManagementVerification.Dashboard
{
    public partial class ChecklistAdd : System.Web.UI.Page
    {
        private static int SearchType { get; set; }
        private readonly ChecklistDb _dbChecklist = new ChecklistDb();
        private readonly ProjectPhaseDb _dbProjectPhase = new ProjectPhaseDb();
        private readonly ProjectTypeDb _dbProjectType = new ProjectTypeDb();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var currentLoginTeacher = SessionManager.CurrentLoginTeacher;
                if (currentLoginTeacher != null)
                {
                    LoadPageData();
                }
            }
        }


        private void LoadPageData()
        {
            var currentLoginTeacher = SessionManager.CurrentLoginTeacher;
            LoadProjectType();
            if (currentLoginTeacher.UserType == "t")
            {
                ddlChecklistType.Visible = false;
            }
            
        }


        private void LoadProjectType()
        {
            ddlProjectType.Items.Clear();
            DataTable dtProjectType = _dbProjectType.GetData(string.Empty, 1);
            for (int i = 0; i < dtProjectType.Rows.Count; i++)
            {
                ddlProjectType.Items.Insert(i, new ListItem(dtProjectType.Rows[i]["Name"].ToString(), dtProjectType.Rows[i]["Id"].ToString()));
            }
            ddlProjectType.Items.Insert(0, "Select Project Type");
        }


        private void LoadProjectPhase(int projectTypeId)
        {
            ddlProjectPhase.Items.Clear();
            DataTable dtProjectPhase = _dbProjectPhase.Search(projectTypeId, string.Empty, 0);
            if (dtProjectPhase.Rows.Count > 0)
            {
                for (int i = 0; i < dtProjectPhase.Rows.Count; i++)
                {
                    ddlProjectPhase.Items.Insert(i,
                        new ListItem(dtProjectPhase.Rows[i]["PhaseName"].ToString(), dtProjectPhase.Rows[i]["Id"].ToString()));
                }
                ddlProjectPhase.Items.Insert(0, "Select Project Phase");
            }
            else
            {
                ddlProjectPhase.Items.Insert(0, "No Phases exist");
            }
            
        }


        protected void btnSave_Click(object sender, EventArgs e)
        {
            var currentLoginTeacher = SessionManager.CurrentLoginTeacher;
            string checklistType = currentLoginTeacher.UserType == "a"?ddlChecklistType.SelectedValue:"Custom";
            if (_dbChecklist.ExistingValidationChecklist(Convert.ToInt32(ddlProjectPhase.SelectedValue),
                txtChecklistName.Text.Replace("'", "`"), checklistType))
            {
                var checklist = new ChecklistBLL
                {
                    ProjectPhaseId = Convert.ToInt32(ddlProjectPhase.SelectedValue),
                    ChecklistName = txtChecklistName.Text.Replace("'", "`"),
                    ChecklistDescription = txtChecklistDescription.Text.Replace("'", "`"),
                    ChecklistType = currentLoginTeacher.UserType == "a" ? ddlChecklistType.SelectedValue : "Custom",
                    CreationDate = DateTime.Now.ToString(CultureInfo.InvariantCulture),
                    CreatedBy = currentLoginTeacher.Id,
                    Status = ddlStatus.SelectedValue
                };
                if (_dbChecklist.Save(checklist))
                {
                    lblMessage.Text = "Successfully Saved";
                    lblMessage.ForeColor = Color.Green;
                }
                else
                {
                    lblMessage.Text = "Failed to save";
                    lblMessage.ForeColor = Color.Red;
                }
            }
            else
            {
                lblMessage.Text = "The Checklist <b>\""+txtChecklistName.Text+"\"</b> on Project Phase"+
                                    " <b>\""+ddlProjectPhase.SelectedItem.Text+"\"</b> already exist";
                lblMessage.ForeColor = Color.Red;
            }
            
        }


        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }


        protected void btnSearchAll_Click(object sender, EventArgs e)
        {
            SearchType = 1;
            GridView1.DataSource = _dbChecklist.GetData(string.Empty, SearchType, SessionManager.CurrentLoginTeacher.Id);
            GridView1.DataBind();
        }


        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            var checklistToDelete = new ChecklistBLL
            {
                Id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value)
            };
            if (_dbChecklist.Delete(checklistToDelete))
            {
                lblMessage.Text = "Successfully Deleted";
                lblMessage.ForeColor = Color.Green;
            }
        }


        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int id = Convert.ToInt32(GridView1.DataKeys[e.NewEditIndex].Value);
            SessionManager.ChecklistToEdit = _dbChecklist.ChecklistById(id);
            Response.Redirect("EditChecklist.aspx");
        }


        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void ddlProjectType_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadProjectPhase(Convert.ToInt32(ddlProjectType.SelectedValue));
        }

    }
}