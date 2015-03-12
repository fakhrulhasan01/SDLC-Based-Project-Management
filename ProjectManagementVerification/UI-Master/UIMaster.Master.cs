using System;
using System.IO;

namespace ProjectManagementVerification
{
    public partial class UiMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //string pageName = Path.GetFileNameWithoutExtension(Request.Path);
                //Response.Write(pageName);
            }
        }
    }
}