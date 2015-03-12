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
    public partial class CreateStudentGroup : System.Web.UI.Page
    {
        private readonly ProjectRequestDb _dbProjectRequest = new ProjectRequestDb();
        private readonly StudentGroupDb _dbStudentGroup = new StudentGroupDb();
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


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PageData();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (_dbStudentGroup.ExistingValidationStudentGroup(txtGroupId.Text,
                Convert.ToInt32(ddlStudent.SelectedValue)))
            {
                //Response.Write("DataBase e Nai");
                var studentGroup = new StudentGroupBLL
                {
                    GroupId = txtGroupId.Text.Replace("'", "`"),
                    StudentId = Convert.ToInt32(ddlStudent.SelectedValue),
                    GroupTitle = txtGroupName.Text.Replace("'", "`"),
                    CreatedBy = SessionManager.CurrentLoginTeacher.Id,
                    CreationDate = DateTime.Now.ToString(CultureInfo.InvariantCulture),
                    GroupType = ddlGroupType.SelectedItem.Text,
                    GroupStatus = "Active"
                };


                DataTable dtCheckGroupCreatedBy = _dbStudentGroup.Search(SessionManager.CurrentLoginTeacher.Id,
                    txtGroupId.Text.Replace("'", "`"));
                if (dtCheckGroupCreatedBy.Rows.Count > 0) //Checking if the group ID is taken by other teacher
                {
                    lblMessage.Text = "This Group ID already taken by another teacher";
                    lblMessage.ForeColor = Color.Red;
                }
                else
                {
                    DataTable dtCheckGroup = _dbStudentGroup.Search(0, string.Empty, string.Empty,
                        string.Empty,
                        string.Empty, txtGroupId.Text.Replace("'", "`"), "Single");
                    if (dtCheckGroup.Rows.Count > 0) //Checking is the Group Single
                    {
                        lblMessage.Text = "Sorry! You can't add more students in a single group";
                        lblMessage.ForeColor = Color.Red;
                    }
                    else
                    {
                        if (_dbStudentGroup.Save(studentGroup))
                        {
                            lblMessage.Text = "Successfully Saved";
                            lblMessage.ForeColor = Color.Green;
                        }
                        else
                        {
                            lblMessage.Text = "Failed";
                            lblMessage.ForeColor = Color.Red;
                        }
                    }
                }

            }
            else
            {
                lblMessage.Text = "Sorry! The student is already registered under your supervison";
                lblMessage.ForeColor = Color.Red;
            }
            
            
        }


        private void PageData()
        {
            var currenTeacher = SessionManager.CurrentLoginTeacher;
            if (currenTeacher != null)
            {
                //Load Approved Students
                LoadApprovedStudents();

                //Load Approved Students for searching purpose
                LoadSearchStudents();

                //Load ddlSearchGroupId for searching 
                var dtGroupId = _dbStudentGroup.Search(0, "Active", currenTeacher.Email, string.Empty,
                    string.Empty, string.Empty, string.Empty);
                if (dtGroupId.Rows.Count > 0)
                {
                    for (int i = 0; i < dtGroupId.Rows.Count; i++)
                    {
                        ddlSearchGroupList.Items.Insert(i, dtGroupId.Rows[i]["GroupId"].ToString());
                    }
                    ddlSearchGroupList.Items.Insert(0, "Select Group");
                }
                else
                {
                    ddlSearchGroupList.Items.Insert(0, "No Group Created");
                }

            }

            txtGroupId.Text = "";
            txtGroupName.Text = "";

        }


       
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            GridView1.DataSource = _dbStudentGroup.GetData(string.Empty, 1);
            GridView1.DataBind();
            PageData();
        }

        protected void btnSearchSpecific_Click(object sender, EventArgs e)
        {
            string student = ddlSearchStudentList.SelectedValue;
            int studentId = student == "Select Students"
                ? 0
                : student == "No Approved Students"
                    ? 0
                    : Convert.ToInt32(ddlSearchStudentList.SelectedValue);



            string groupId = ddlSearchGroupList.SelectedValue;
            groupId = groupId == "Select Group"
                ? string.Empty
                : groupId == "No Group Created"
                    ? string.Empty
                    : ddlSearchGroupList.SelectedValue;

            string groupType = ddlSearchGroupType.SelectedItem.Text == "Select Group Type" 
                ? string.Empty : ddlSearchGroupType.SelectedItem.Text;
            
            

            //Response.Write(groupId);
            GridView1.DataSource = 
                _dbStudentGroup.Search(studentId, "Active", SessionManager.CurrentLoginTeacher.Email,
                string.Empty, string.Empty, groupId, groupType);
            GridView1.DataBind();
            PageData();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int studentId = Convert.ToInt32(GridView1.DataKeys[e.NewEditIndex].Value.ToString());
            string groupId = HttpUtility.HtmlDecode(GridView1.Rows[e.NewEditIndex].Cells[2].Text);
            SessionManager.StudentGroupToEdit = _dbStudentGroup.StudentGroupById(groupId, studentId);
            Response.Redirect("EditStudentGroup.aspx");
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Response.Write(GridView1.DataKeys[e.RowIndex].Value);
            string groupId = HttpUtility.HtmlDecode(GridView1.Rows[e.RowIndex].Cells[2].Text);
        }


    }
}