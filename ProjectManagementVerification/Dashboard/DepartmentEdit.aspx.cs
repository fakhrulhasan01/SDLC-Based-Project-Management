using System;
using System.Drawing;
using ProjectManagementVerification.DAL;

namespace ProjectManagementVerification.Dashboard
{
    public partial class DepartmentEdit : System.Web.UI.Page
    {

        private readonly DepartmentDb _db = new DepartmentDb();

        private void LoadPage()
        {
            var department = SessionManager.DepartmentToEdit;
            if (department != null)
            {
                txtDepartmentName.Text = department.Name;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPage();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            var department = SessionManager.DepartmentToEdit;
            department.Name = txtDepartmentName.Text;
            

            if (_db.ExistingValidationDepartment(txtDepartmentName.Text.Replace("'", "`")))
            {
                if (_db.Update(department))
                {
                    lblMessage.Text = "Department Name successfully updated";
                    lblMessage.ForeColor = Color.Green;
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                        "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" +
                        lblMessage.ClientID +
                        "').style.display='none'\",10000)</script>");

                    LoadPage();
                }
                else
                {
                    lblMessage.Text = "Sorry! May be database connection failure";
                    lblMessage.ForeColor = Color.Red;
                    ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                        "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" +
                        lblMessage.ClientID +
                        "').style.display='none'\",10000)</script>");

                    LoadPage();
                }
            }
            else
            {
                lblMessage.Text = "The Department name <b>" + txtDepartmentName.Text + "</b> is already exist";
                lblMessage.ForeColor = Color.Red;
                ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                    "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" +
                    lblMessage.ClientID +
                    "').style.display='none'\",10000)</script>");
                LoadPage();
            }

        }



    }
}