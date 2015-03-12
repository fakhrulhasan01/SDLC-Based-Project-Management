using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ProjectManagementVerification.DAL;

namespace ProjectManagementVerification.View
{
    public partial class BlogPosts : System.Web.UI.Page
    {
        private readonly BlogDb _dbBlog = new BlogDb();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                blogPosts.DataSource = _dbBlog.GetData(string.Empty, 1);
                blogPosts.DataBind();
            }
        }
    }
}