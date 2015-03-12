using System;
using ProjectManagementVerification.BLL;
using ProjectManagementVerification.DAL;

namespace ProjectManagementVerification.Dashboard
{
    public partial class Default : System.Web.UI.Page
    {
        private readonly TeacherDb _dbTeacher = new TeacherDb();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

    

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Teacher teacher = _dbTeacher.LoginTeacher(txtUsername.Text.Replace("'", "`"),
                txtPassword.Text.Replace("'", "`"));
            if (teacher != null)
            {
                SessionManager.CurrentLoginTeacher = teacher;
                Response.Redirect("../Dashboard/Welcome.aspx");
            }
            else
            {
                SessionManager.CurrentLoginTeacher = null;
                txtUsername.Text = "";
                txtPassword.Text = "";
                lblMessage.Text = "Email or Password Error";
                lblMessage.ForeColor = System.Drawing.Color.Red;  
            }
        }
    }


}