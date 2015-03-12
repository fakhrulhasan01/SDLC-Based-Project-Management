using System;
using System.Drawing;
using System.Globalization;
using System.Web.UI.WebControls;
using ProjectManagementVerification.DAL;
using ProjectManagementVerification.SecurityFiles;
using StudentAssignToGroupBLL = ProjectManagementVerification.BLL.StudentAssignToGroup;


namespace ProjectManagementVerification.Dashboard
{
    public partial class AddStudentToGroup : System.Web.UI.Page
    {
        private readonly StudentAssignToGroupDb _dbStudentAssignToGroup = new StudentAssignToGroupDb();
        private readonly ProjectRequestDb _dbProjectRequest = new ProjectRequestDb();
        private readonly CreateProjectGroupDb _dbCreateProjectGroup = new CreateProjectGroupDb();
        private static int SearchType { get; set; }

        private void LoadPageData()
        {
            var currentTeacher = SessionManager.CurrentLoginTeacher;
            if (currentTeacher != null)
            {
                LoadApprovedStudents();
                LoadCreatedProjectGroup();
                LoadSearchStudents();
                LoadGroupForSearch();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPageData();
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
                ddlStudent.Items.Insert(0, "Select Students");
            }
            else
            {
                ddlStudent.Items.Insert(0, "No Approved Students");
            }

            //Response.Write(dtApprovedStudents);
        }



        private void LoadCreatedProjectGroup()
        {
            var dtCreatedProjectGroup = _dbCreateProjectGroup.Search(SessionManager.CurrentLoginTeacher.Id,
                "Active", string.Empty, string.Empty, string.Empty, string.Empty);
            ddlProjectGroup.Items.Clear();
            if (dtCreatedProjectGroup.Rows.Count > 0)
            {
                for (int i = 0; i < dtCreatedProjectGroup.Rows.Count; i++)
                {
                    ddlProjectGroup.Items.Insert(i, new ListItem(dtCreatedProjectGroup.Rows[i]["GroupId"].ToString(),
                                                            dtCreatedProjectGroup.Rows[i]["Id"].ToString()));
                }
                ddlProjectGroup.Items.Insert(0, "Select Project Group");
            }
            else
            {
                ddlProjectGroup.Items.Insert(0, "No Project Group Created");
            }

            //Response.Write(dtApprovedStudents);
        }


        private void LoadSearchStudents()
        {
            var dtApprovedStudents = _dbProjectRequest.Search(string.Empty, "Approved",
                SessionManager.CurrentLoginTeacher.Email, string.Empty, string.Empty);
            ddlSearchStudentList.Items.Clear();
            if (dtApprovedStudents.Rows.Count > 0)
            {
                for (int i = 0; i < dtApprovedStudents.Rows.Count; i++)
                {
                    ddlSearchStudentList.Items.Insert(i, new ListItem(dtApprovedStudents.Rows[i]["StudentName"].ToString(),
                                                            dtApprovedStudents.Rows[i]["StudentId"].ToString()));
                }
                ddlSearchStudentList.Items.Insert(0, "Select Students");
            }
            else
            {
                ddlSearchStudentList.Items.Insert(0, "No Approved Students");
            }

            //Response.Write(dtApprovedStudents);
        }


        private void LoadGroupForSearch()
        {
            //Load ddlSearchGroupId for searching 
            var dtCreatedProjectGroup = _dbCreateProjectGroup.Search(SessionManager.CurrentLoginTeacher.Id,
                "Active", string.Empty, string.Empty, string.Empty, string.Empty);
            ddlSearchGroupList.Items.Clear();
            if (dtCreatedProjectGroup.Rows.Count > 0)
            {
                for (int i = 0; i < dtCreatedProjectGroup.Rows.Count; i++)
                {
                    ddlSearchGroupList.Items.Insert(i, new ListItem(dtCreatedProjectGroup.Rows[i]["GroupId"].ToString(),
                                                            dtCreatedProjectGroup.Rows[i]["Id"].ToString()));
                }
                ddlSearchGroupList.Items.Insert(0, "Select Project Group");
            }
            else
            {
                ddlSearchGroupList.Items.Insert(0, "No Project Group Created");
            }

        }


        

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            var addStudentToGroup = new StudentAssignToGroupBLL
            {
                StudentId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value),
                ProjectGroupId = Convert.ToInt32(GridView1.Rows[e.RowIndex].Cells[2].Text)
            };
            if (_dbStudentAssignToGroup.Delete(addStudentToGroup))
            {
                lblMessage.Text = "Successfully Deleted";
                lblMessage.ForeColor = Color.Green;
            }
            else
            {
                lblMessage.Text = "Can't delete! May be used by other property";
                lblMessage.ForeColor = Color.Red;
            }
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            //Response.Write(GridView1.Rows[e.NewEditIndex].Cells[2].Text);
            int studentId = Convert.ToInt32(GridView1.DataKeys[e.NewEditIndex].Value);
            int projectGroupId = Convert.ToInt32(GridView1.Rows[e.NewEditIndex].Cells[2].Text);
            SessionManager.StudentAssignToGroupEdit = _dbStudentAssignToGroup.StudentAssignToGroupById(projectGroupId,
                studentId);
            Response.Redirect("EditStudentAssign.aspx");
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (
                _dbStudentAssignToGroup.ExistingValidationStudentAssignToGroup(
                    Convert.ToInt32(ddlProjectGroup.SelectedValue),
                    Convert.ToInt32(ddlStudent.SelectedValue)))
            {
                //Checking if the group is single and if single then check any students added to it
                var dtCheckStudentsToSingleGroup = _dbStudentAssignToGroup.Search(SessionManager.CurrentLoginTeacher.Id,
                                0, "Active", string.Empty, string.Empty, Convert.ToInt32(ddlProjectGroup.SelectedValue),
                                "Single");

                if (dtCheckStudentsToSingleGroup.Rows.Count > 0)
                {
                    lblMessage.Text = "You can't add more students to single group \"<b>" +
                                      ddlProjectGroup.SelectedItem.Text + "</b>\"";
                    lblMessage.ForeColor = Color.Red;
                }
                else
                {
                    var addStudentToGroup = new StudentAssignToGroupBLL
                    {
                        AddedBy = SessionManager.CurrentLoginTeacher.Id,
                        AddedDate = DateTime.Now.ToString(CultureInfo.InvariantCulture),
                        ProjectGroupId = Convert.ToInt32(ddlProjectGroup.SelectedValue),
                        StudentId = Convert.ToInt32(ddlStudent.SelectedValue),
                        StudentStatus = "Active"
                    };
                    if (_dbStudentAssignToGroup.Save(addStudentToGroup))
                    {
                        lblMessage.Text = "The Student \"" + ddlStudent.SelectedItem.Text +
                                          "\" Successfully Added to Group " +
                                          "\"" + ddlProjectGroup.SelectedItem.Text + "\"";
                        lblMessage.ForeColor = Color.Green;
                    }
                    else
                    {
                        lblMessage.Text = "Failed to ADD";
                        lblMessage.ForeColor = Color.Red;
                    }
                }
            }
            else
            {
                lblMessage.Text = "The Student is already added to this group";
                lblMessage.ForeColor = Color.Red;
            }
            ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + lblMessage.ClientID +
                "').style.display='none'\",6000)</script>");

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }

        protected void btnSearchAll_Click(object sender, EventArgs e)
        {
            SearchType = 1;
            GridView1.DataSource = _dbStudentAssignToGroup.GetData(string.Empty, SearchType,
                SessionManager.CurrentLoginTeacher.Id);
            GridView1.DataBind();
        }

        protected void btnSearchSpecific_Click(object sender, EventArgs e)
        {
            string student = ddlSearchStudentList.SelectedValue;
            int studentId = student == "Select Students"
                ? 0
                : student == "No Approved Students"
                    ? 0
                    : Convert.ToInt32(ddlSearchStudentList.SelectedValue);



            string GroupId = ddlSearchGroupList.SelectedValue;
            int groupId = GroupId == "Select Project Group"
                ? 0
                : GroupId == "No Project Group Created"
                    ? 0
                    : Convert.ToInt32(ddlSearchGroupList.SelectedValue);

            string groupType = ddlSearchGroupType.SelectedItem.Text == "Select Group Type"
                ? string.Empty : ddlSearchGroupType.SelectedItem.Text;



            //Response.Write(groupId);
            GridView1.DataSource = _dbStudentAssignToGroup.Search(SessionManager.CurrentLoginTeacher.Id, studentId,
                "Active", string.Empty, string.Empty, groupId, groupType);
            GridView1.DataBind();
            LoadPageData();

        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            HashGenerator hg = new HashGenerator();
            string studentId = GridView1.DataKeys[e.RowIndex].Value.ToString();
            string hashTwo = hg.Md5Hash(hg.Md5Hash(studentId));
            string hashThree = hg.Md5Hash(hashTwo);
            Response.Redirect("../View/ViewStudent.aspx?id="+studentId+"&key="+hashTwo+"&key2="+hashThree);
            //Response.Write(studentId.ToString());
        }

    }
}