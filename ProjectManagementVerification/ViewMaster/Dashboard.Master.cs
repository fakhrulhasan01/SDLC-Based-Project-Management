using System;
using ProjectManagementVerification.BLL;
using ProjectManagementVerification.DAL;

namespace ProjectManagementVerification.ViewMaster
{
    public partial class Dashboard : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (SessionManager.CurrentLoginTeacher != null)
                {
                    if (SessionManager.CurrentLoginTeacher.UserType == "a")
                    {
                        menuAdmin1.Visible = true;
                        menuTeacher1.Visible = false;
                    }
                    else
                    {
                        menuAdmin1.Visible = false;
                        menuTeacher1.Visible = true;
                    }
                    
                }
                else
                {
                    Response.Redirect("../View/Login.aspx");
                }
                LoadPageData();
            }
        }

        private void LoadPageData()
        {
            var currentLoginTeacher = SessionManager.CurrentLoginTeacher;
            if (currentLoginTeacher != null)
            {
                string imageLink = "";
                lblCurrentUser.Text = currentLoginTeacher.FullName;
                if (currentLoginTeacher.Picture == string.Empty)
                {
                    if (currentLoginTeacher.Gender == "Male")
                    {
                        imageLink = "../Dashboard/Photo/genderIcon/male-icon.png";
                    }
                    else
                    {
                        imageLink = "../Dashboard/Photo/genderIcon/female-icon.png";
                    }
                }
                else
                {
                    imageLink = "../Dashboard/" + currentLoginTeacher.Picture;
                }
                imgProfilePic.ImageUrl = imageLink;

            }
            else
            {
                Response.Redirect("../View/Login.aspx");
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            SessionManager.CurrentLoginTeacher = null;
            Response.Redirect("Default.aspx");
        }

       
    }
}