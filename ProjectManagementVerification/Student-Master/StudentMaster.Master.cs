using System;
using System.Data;
using ProjectManagementVerification.BLL;
using ProjectManagementVerification.DAL;


namespace ProjectManagementVerification.Student_Master
{
    public partial class StudentMaster : System.Web.UI.MasterPage
    {
        private readonly StudentAssignToGroupDb _dbStudentToGroup = new StudentAssignToGroupDb();
        private readonly ProjectRegistrationDb _dbProjectRegistration = new ProjectRegistrationDb();
        private readonly AssignTaskDb _dbAssignTask = new AssignTaskDb();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (SessionManager.CurrentLoginStudent != null)
                {
                    lblCurrentUserName.Text = SessionManager.CurrentLoginStudent.FullName;
                    PageData();
                }
                else
                {
                    Response.Redirect("../View/Login.aspx");
                }
            }
        }


        private void PageData()
        {
            var currentStudent = SessionManager.CurrentLoginStudent;
            if (currentStudent != null)
            {
                DataTable dtFindProjects = _dbStudentToGroup.Search(0, SessionManager.CurrentLoginStudent.Id, "Active",
                                                string.Empty, string.Empty, 0, string.Empty);
                int countNewlyAssigned = 0;
                int countWorkingTask = 0;
                int countCompletedTask = 0;

                for (int i = 0; i < dtFindProjects.Rows.Count; i++)
                {
                    ProjectRegistration project = _dbProjectRegistration.ProjectRegistrationByGroupId(Convert.ToInt32(dtFindProjects.Rows[i]["ProjectGroupId"]));//BLL Class
                    if (project != null)
                    {
                        countCompletedTask = _dbAssignTask.Search(0, 0, 0, "Completed", project.Id).Rows.Count;
                        countWorkingTask = _dbAssignTask.Search(0, 0, 0, "Working", project.Id).Rows.Count;
                        countNewlyAssigned = _dbAssignTask.Search(0, 0, 0, "Assigned", project.Id).Rows.Count;

                        assignedTask.InnerText = countNewlyAssigned.ToString();
                        completedTask.InnerText = countCompletedTask.ToString();
                        workingTask.InnerText = countWorkingTask.ToString();
                    }
                }

            }
        }


    }
}