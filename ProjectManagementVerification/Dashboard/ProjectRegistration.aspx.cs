using System;
using System.Drawing;
using System.Globalization;
using System.Web.UI.WebControls;
using ProjectManagementVerification.DAL;
using ProjectRegistrationBLL = ProjectManagementVerification.BLL.ProjectRegistration;

namespace ProjectManagementVerification.Dashboard
{
    public partial class ProjectRegistration : System.Web.UI.Page
    {
        private readonly ProjectRegistrationDb _db = new ProjectRegistrationDb();
        private readonly ProjectTypeDb _dbProjectType = new ProjectTypeDb();
        private readonly CreateProjectGroupDb _dbCreateProjectGroup = new CreateProjectGroupDb();
        private static int SearchType { get;set; }
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
            txtProjectTitle.Text = "";
            txtProjectSummary.Text = "";
            if (currentLoginTeacher != null)
            {
                var dtProjectType = _dbProjectType.GetData(string.Empty, 1);
                if (dtProjectType.Rows.Count > 0)
                {
                    for (int i = 0; i < dtProjectType.Rows.Count; i++)
                    {
                        ddlProjectType.Items.Insert(i, new ListItem(dtProjectType.Rows[i]["Name"].ToString(),
                            dtProjectType.Rows[i]["Id"].ToString()));
                    }
                    ddlProjectType.Items.Insert(0, "Select Project Type");
                }

                var dtProjectGroup = _dbCreateProjectGroup.GetData(string.Empty, 1, currentLoginTeacher.Id);
                if (dtProjectGroup.Rows.Count > 0)
                {
                    for (int i = 0; i < dtProjectGroup.Rows.Count; i++)
                    {
                        ddlProjectGroup.Items.Insert(i, new ListItem(dtProjectGroup.Rows[i]["GroupId"].ToString(),
                            dtProjectGroup.Rows[i]["Id"].ToString()));
                    }
                    ddlProjectGroup.Items.Insert(0, "Select Project Group");
                }
                //Response.Write(_dbCreateProjectGroup.Search(currentLoginTeacher.Id, "Active", string.Empty,
                  //  string.Empty, string.Empty, string.Empty));
            }
        }


        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (_db.ExistingValidationProjectRegistration(Convert.ToInt32(ddlProjectGroup.SelectedValue)))
            {
                var projectRegistration = new ProjectRegistrationBLL
                {
                    ProjectTitle = txtProjectTitle.Text.Replace("'","`"),
                    ProjectSummary = txtProjectSummary.Text.Replace("'","`"),
                    GroupId = Convert.ToInt32(ddlProjectGroup.SelectedValue),
                    TeacherId = SessionManager.CurrentLoginTeacher.Id,
                    ProjectTypeId = Convert.ToInt32(ddlProjectType.SelectedValue),
                    RegistrationDate = DateTime.Now.ToString(CultureInfo.InvariantCulture),
                    Status = "Active",
                    ProgressStatus = 0
                };
                if (_db.Save(projectRegistration))
                {
                    lblMessage.Text = "Successfully Saved";
                    lblMessage.ForeColor = Color.Green;
                }
                else
                {
                    lblMessage.Text = "Sorry! Failed";
                    lblMessage.ForeColor = Color.Red;
                }
            }
            else
            {
                lblMessage.Text = "Sorry! The group <b>\""+ddlProjectGroup.SelectedItem.Text+"\"</b> is already registered";
                lblMessage.ForeColor = Color.Red;
            }
            ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + lblMessage.ClientID +
                "').style.display='none'\",6000)</script>");
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int id = Convert.ToInt32(GridView1.DataKeys[e.NewEditIndex].Value);
            SessionManager.ProjectRegistrationToEdit = _db.ProjectRegistrationById(id);
            Response.Redirect("EditProjectRegistration.aspx");
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            if (SearchType == 0)
            {
                GridView1.DataSource = _db.GetData(txtSearch.Text, 0,
                    SessionManager.CurrentLoginTeacher.Id);
                GridView1.DataBind();
            }
            else
            {
                GridView1.DataSource = _db.GetData(string.Empty, 1,
                    SessionManager.CurrentLoginTeacher.Id);
                GridView1.DataBind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            SearchType = 0;
            GridView1.DataSource = _db.GetData(txtSearch.Text.Replace("'", "`"), SearchType,
                SessionManager.CurrentLoginTeacher.Id);
            GridView1.DataBind();
        }

        protected void btnSearchAll_Click(object sender, EventArgs e)
        {
            SearchType = 1;
            GridView1.DataSource = _db.GetData(string.Empty, SearchType, SessionManager.CurrentLoginTeacher.Id);
            GridView1.DataBind();
        }


    }
}