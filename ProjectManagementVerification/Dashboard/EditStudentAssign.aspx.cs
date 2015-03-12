using System;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Web.UI.WebControls;
using ProjectManagementVerification.DAL;
using AddStudentToGroupBLL = ProjectManagementVerification.BLL.StudentAssignToGroup;

namespace ProjectManagementVerification.Dashboard
{
    public partial class EditStudentAssign : System.Web.UI.Page
    {
        private readonly StudentAssignToGroupDb _dbStudentAssignToGroup = new StudentAssignToGroupDb();
        private readonly ProjectRequestDb _dbProjectRequest = new ProjectRequestDb();
        private readonly CreateProjectGroupDb _dbCreateProjectGroup = new CreateProjectGroupDb();        

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCreatedProjectGroupWithSelected();
                LoadApprovedStudentWithSelected();
            }
        }


        private void LoadApprovedStudentWithSelected()
        {
            var studentToGroupEdit = SessionManager.StudentAssignToGroupEdit;
            if (studentToGroupEdit != null)
            {
                var dtApprovedStudents = _dbProjectRequest.Search(string.Empty, "Approved",
                    SessionManager.CurrentLoginTeacher.Email, string.Empty, string.Empty);
                ddlStudent.Items.Clear();
                if (dtApprovedStudents.Rows.Count > 0)
                {
                    for (int i = 0; i < dtApprovedStudents.Rows.Count; i++)
                    {
                        ddlStudent.Items.Insert(i, new ListItem(dtApprovedStudents.Rows[i]["StudentName"].ToString(),
                                                                dtApprovedStudents.Rows[i]["StudentId"].ToString()));
                    }
                    ddlStudent.SelectedValue = studentToGroupEdit.StudentId.ToString(CultureInfo.InvariantCulture);
                }
                else
                {
                    ddlStudent.Items.Insert(0, "No Approved Students");
                }

            }
        }


        private void LoadCreatedProjectGroupWithSelected()
        {
            var studentToGroupEdit = SessionManager.StudentAssignToGroupEdit;
            if (studentToGroupEdit != null)
            {
                var dtCreatedProjectGroup = _dbCreateProjectGroup.Search(SessionManager.CurrentLoginTeacher.Id,
                    "Active", string.Empty, string.Empty, string.Empty, string.Empty);
                ddlProjectGroup.Items.Clear();
                if (dtCreatedProjectGroup.Rows.Count > 0)
                {
                    for (int i = 0; i < dtCreatedProjectGroup.Rows.Count; i++)
                    {
                        ddlProjectGroup.Items.Insert(i,
                            new ListItem(dtCreatedProjectGroup.Rows[i]["GroupId"].ToString(),
                                dtCreatedProjectGroup.Rows[i]["Id"].ToString()));
                    }
                    ddlProjectGroup.SelectedValue =
                        studentToGroupEdit.ProjectGroupId.ToString(CultureInfo.InvariantCulture);
                }
                else
                {
                    ddlProjectGroup.Items.Insert(0, "No Project Group Created");
                }

                ddlStatus.Items.Insert(0, studentToGroupEdit.StudentStatus);
            }
            //Response.Write(dtApprovedStudents);
        }




        

        protected void btnSave_Click(object sender, EventArgs e)
        {
            var currentAssignStudentToEdit = SessionManager.StudentAssignToGroupEdit;
            if (currentAssignStudentToEdit != null)
            {   int groupId = currentAssignStudentToEdit.ProjectGroupId;
                int studentId = currentAssignStudentToEdit.StudentId;
                //Response.Write(groupId.ToString() + "<br/>" + ddlProjectGroup.SelectedValue);
                if (_dbStudentAssignToGroup.ExistingValidationStudentAssignToGroup(Convert.ToInt32(ddlProjectGroup.SelectedValue), 
                    Convert.ToInt32(ddlStudent.SelectedValue)))
                {
                    Response.Write("Not Exist<br/>");
                    if (groupId != Convert.ToInt32(ddlProjectGroup.SelectedValue))
                    {
                        Response.Write("Miley Ne");
                        DataTable dtCheckSingleGroup =
                            _dbStudentAssignToGroup.Search(SessionManager.CurrentLoginTeacher.Id,
                                0, "Active", string.Empty, string.Empty, Convert.ToInt32(ddlProjectGroup.SelectedValue),
                                "Single");
                        if (dtCheckSingleGroup.Rows.Count > 0)
                        {
                            lblMessage.Text = "\"" + ddlProjectGroup.SelectedItem.Text +
                                              "\" is a single. Already contain student";
                            lblMessage.ForeColor = Color.Red;
                        }
                        else
                        {
                            currentAssignStudentToEdit.ProjectGroupId = Convert.ToInt32(ddlProjectGroup.SelectedValue);
                            currentAssignStudentToEdit.StudentId = Convert.ToInt32(ddlStudent.SelectedValue);
                            currentAssignStudentToEdit.StudentStatus = ddlStatus.SelectedValue;
                            Response.Write(_dbStudentAssignToGroup.Update(currentAssignStudentToEdit, groupId, studentId,
                                "No"));
                            if (_dbStudentAssignToGroup.Update(currentAssignStudentToEdit, groupId, studentId, "No"))
                            {
                                lblMessage.Text = "Successfully updated";
                                lblMessage.ForeColor = Color.Green;
                            }
                            else
                            {
                                lblMessage.Text = "Failed to update";
                                lblMessage.ForeColor = Color.Red;
                            }
                        }
                    }
                    else
                    {
                        currentAssignStudentToEdit.ProjectGroupId = Convert.ToInt32(ddlProjectGroup.SelectedValue);
                        currentAssignStudentToEdit.StudentId = Convert.ToInt32(ddlStudent.SelectedValue);
                        currentAssignStudentToEdit.StudentStatus = ddlStatus.SelectedValue;
                        Response.Write(_dbStudentAssignToGroup.Update(currentAssignStudentToEdit, groupId, studentId,
                            "No"));
                        if (_dbStudentAssignToGroup.Update(currentAssignStudentToEdit, groupId, studentId, "No"))
                        {
                            lblMessage.Text = "Successfully updated";
                            lblMessage.ForeColor = Color.Green;
                        }
                        else
                        {
                            lblMessage.Text = "Failed to update";
                            lblMessage.ForeColor = Color.Red;
                        }
                    }
                }
                else
                {
                    Response.Write("Exist");
                    currentAssignStudentToEdit.StudentStatus = ddlStatus.SelectedValue;
                    if (_dbStudentAssignToGroup.Update(currentAssignStudentToEdit, groupId, studentId, "Yes"))
                    {
                         lblMessage.Text = "Successfully updated";
                         lblMessage.ForeColor = Color.Green;
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
}