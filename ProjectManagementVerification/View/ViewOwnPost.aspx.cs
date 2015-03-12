using System;
using ProjectManagementVerification.DAL;

namespace ProjectManagementVerification.View
{
    public partial class ViewOwnPost : System.Web.UI.Page
    {
        private readonly BlogDb _dbBlog = new BlogDb();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (SessionManager.CurrentLoginTeacher != null || SessionManager.CurrentLoginStudent != null)
                {
                    LoadPageData();
                }
                else
                {
                    Response.Redirect("../View/Default");
                }
            }
        }

        private void LoadPageData()
        {
            if (SessionManager.CurrentLoginTeacher != null)
            {
                GridView1.DataSource = _dbBlog.Search(SessionManager.CurrentLoginTeacher.Id, "t");
                GridView1.DataBind();
            }
            else if (SessionManager.CurrentLoginStudent != null)
            {
                GridView1.DataSource = _dbBlog.Search(SessionManager.CurrentLoginStudent.Id, "s");
                GridView1.DataBind();                
            }
        }

        protected void GridView1_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {

        }

        protected void GridView1_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {

        }

        protected void GridView1_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
        {

        }
    }
}