using System;

namespace ProjectManagementVerification.Users
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Response.Write(Session["Hello"]);
                Response.Write("<br/>How Are You??");
            }
        }
    }
}