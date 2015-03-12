using System;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Web;
using System.Web.UI.WebControls;
using ProjectManagementVerification.BLL;
using ProjectManagementVerification.DAL;
using StudentGroupBLL = ProjectManagementVerification.BLL.StudentGroup;


namespace ProjectManagementVerification.Dashboard
{
    public partial class EditStudentGroup : System.Web.UI.Page
    {
        private readonly ProjectRequestDb _dbProjectRequest = new ProjectRequestDb();
        private readonly StudentGroupDb _dbStudentGroup = new StudentGroupDb();

        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (SessionManager.StudentGroupToEdit != null)
                {
                    PageData();
                }
            }
        }

        private void LoadApprovedStudents()
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
                ddlStudent.SelectedValue = SessionManager.StudentGroupToEdit.StudentId.ToString();
            }
            else
            {
                ddlStudent.Items.Insert(0, "No Approved Students");
            }

            //Response.Write(dtApprovedStudents);
        }


        private void PageData()
        {
            var currentTeacher = SessionManager.CurrentLoginTeacher;
            var studentGroup = SessionManager.StudentGroupToEdit;
            if (studentGroup != null)
            {
                //Load Approved Students
                LoadApprovedStudents();
                txtGroupId.Text = studentGroup.GroupId;
                txtGroupName.Text = studentGroup.GroupTitle;
                ddlGroupType.SelectedValue = studentGroup.GroupType;
            }

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

        }
    }
}