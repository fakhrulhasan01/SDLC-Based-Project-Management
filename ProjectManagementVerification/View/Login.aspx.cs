using System;
using ProjectManagementVerification.BLL;
using ProjectManagementVerification.DAL;

namespace ProjectManagementVerification.View
{
    public partial class Login : System.Web.UI.Page
    {
        private readonly StudentDb _db = new StudentDb();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SessionManager.StudentToEdit = null;
                SessionManager.CurrentLoginStudent = null;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Student student = _db.LoginStudent(txtEmail.Text.Replace("'", "`"), txtPassword.Text.Replace("'", "`"));
            if (student != null)
            {
                SessionManager.CurrentLoginStudent = student;
                Response.Redirect("../Students/Welcome.aspx");
            }
            else
            {
                SessionManager.CurrentLoginStudent = null;
                lblMessage.Text = "Email or Password error";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                ClientScript.RegisterStartupScript(GetType(), "id", "showStudentLogin()", true);
            }
        }


    }
}