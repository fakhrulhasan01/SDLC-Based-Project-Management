using System;
using System.Drawing;
using System.Globalization;
using ProjectManagementVerification.DAL;
using ProjectManagementVerification.SecurityFiles;
using DepartmentBLL = ProjectManagementVerification.BLL.Department;
using ProjectRequestBLL = ProjectManagementVerification.BLL.ProjectRequest;


namespace ProjectManagementVerification.View
{
    public partial class ViewTeacher : System.Web.UI.Page
    {
        private readonly TeacherDb _dbTeacher = new TeacherDb();
        private readonly DepartmentDb _dbDepartment = new DepartmentDb();
        private readonly ProjectRequestDb _dbProjectRequest = new ProjectRequestDb();
        private readonly CityDb _dbcCity = new CityDb();
        private readonly HashGenerator _hashGenerator = new HashGenerator();


        private void LoadData()
        {
            if (SessionManager.CurrentLoginStudent != null || SessionManager.CurrentLoginTeacher != null)
            {
                if (Request.QueryString["id"] != null && Request.QueryString["key"] != null)
                {
                    if (_hashGenerator.Md5Hash(_hashGenerator.Md5Hash(Request.QueryString["id"])) == Request.QueryString["key"])
                    {

                        txtTeacherId.Text = Request.QueryString["id"];
                        var teacher = _dbTeacher.TeacherById(Convert.ToInt32(Request.QueryString["id"]));
                        lblTeacherName.InnerText = teacher.FullName + "'s Profile";
                        DepartmentBLL department =
                            _dbDepartment.DepartmentById(teacher.DepartmentId);
                        lblDepartment.Text = department.Name;
                        lblDesignation.Text = teacher.Designation;
                        lblEmail.Text = teacher.Email;
                        lblEmployeeId.Text = teacher.EmployeeId;
                        imgProfilePic.ImageUrl = "../Dashboard/" + teacher.Picture;

                        var existing = _dbProjectRequest.ProjectRequestById(SessionManager.CurrentLoginStudent.Id,
                            Convert.ToInt32(Request.QueryString["id"]));
                        if (existing != null)
                        {
                            txtMessage.Visible = false;
                            btnSendRequest.Visible = false;
                            btnRequested.Visible = true;

                            if (existing.ApprovalStatus == "Approved")
                            {
                                CancelRequest.Attributes.Remove("href");
                                CancelRequest.InnerText = "Your request is Approved";
                            }
                            else if (existing.ApprovalStatus == "Banned")
                            {
                                CancelRequest.Attributes.Remove("href");
                                CancelRequest.InnerText = "Your request is Banned";
                            }
                            
                        }
                        else
                        {
                            txtMessage.Visible = true;
                            btnSendRequest.Visible = true;
                            btnRequested.Visible = false;
                        }
                        
                    }
                    else
                    {
                        Response.Redirect("../View/Default.aspx");
                    }
                }
            }
            else
            {
                Response.Redirect("../View/Default.aspx");
            }            
        }
        
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
                //CancelRequest.Attributes.Remove("href");
            }

        }



        protected void btnSendRequest_Click(object sender, EventArgs e)
        {
            if (_hashGenerator.Md5Hash(_hashGenerator.Md5Hash(Request.QueryString["id"])) == Request.QueryString["key"])
            {
                string message = txtMessage.Text.Replace("'", "`");
                message = message.Replace("--", "-");
                var projectRequest = new ProjectRequestBLL
                {
                    StudentId = SessionManager.CurrentLoginStudent.Id, 
                    TeacherId = Convert.ToInt32(Request.QueryString["id"]),
                    StudentMessage = message,
                    ApprovalStatus = "Pending",
                    RequestDate = DateTime.Now.ToString(CultureInfo.InvariantCulture),
                    ConfirmationDate = string.Empty,
                    Status = 0
                };

                

                if (_dbProjectRequest.Save(projectRequest))
                {
                    lblMessage.Text = "Your Request Succesfully Send";
                    lblMessage.ForeColor = Color.FromArgb(6, 166, 6);
                    LoadData();
                }
                else
                {
                    lblMessage.Text = "Sorry! Failed to sent";
                    lblMessage.ForeColor = Color.Red;
                }
                Response.Write(Request.QueryString["id"]);
            }
        }

        protected void btnCancelRequest_Click(object sender, EventArgs e)
        {
            var projectRequest = new ProjectRequestBLL
            {
                StudentId = SessionManager.CurrentLoginStudent.Id,
                TeacherId = Convert.ToInt32(Request.QueryString["id"])
            };
            if (_dbProjectRequest.Delete(projectRequest))
            {
                lblMessage.Text = "Project Request Successfully Canceled";
                lblMessage.ForeColor = Color.FromArgb(6, 166, 6);
                LoadData();
            }
        }

       



    }
}