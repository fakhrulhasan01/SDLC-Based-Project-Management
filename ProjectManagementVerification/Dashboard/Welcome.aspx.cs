using System;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI.WebControls;
using ProjectManagementVerification.DAL;
using TeacherBLL = ProjectManagementVerification.BLL.Teacher;
using ProjectRequestBLL = ProjectManagementVerification.BLL.ProjectRequest;



namespace ProjectManagementVerification.Dashboard
{
    public partial class Welcome : System.Web.UI.Page
    {
        private readonly CityDb _dbCity = new CityDb();
        private readonly DepartmentDb _dbDepartment = new DepartmentDb();
        private readonly TeacherDb _dbTeacher = new TeacherDb();
        private readonly ProjectRequestDb _dbProjectRequest = new ProjectRequestDb();

        public void LoadDepartments()
        {
            var dept = _dbDepartment.GetData(string.Empty, 1);
            if (dept != null)
            {
                for (int i = 0; i < dept.Rows.Count; i++)
                {
                    ddlDepartment.Items.Insert(i, new ListItem(dept.Rows[i][1].ToString(), dept.Rows[i][0].ToString()));
                }
            }
            ddlDepartment.SelectedValue = SessionManager.CurrentLoginTeacher.DepartmentId.ToString();
        }

        public void LoadPageData()
        {
            var currentTeacher = SessionManager.CurrentLoginTeacher;
            if (currentTeacher != null)
            {
                lblFullName.Text = currentTeacher.FullName;
                lblEmail.Text = currentTeacher.Email;
                lblAddress.Text = currentTeacher.Address == string.Empty ? "Not Mentioned" : currentTeacher.Address;
                lblContact.Text = currentTeacher.Mobile == string.Empty ? "Not Mentioned, " : currentTeacher.Mobile + ",";
                lblContact.Text += currentTeacher.Telephone == string.Empty ? "Not Mentioned" : currentTeacher.Telephone;
                
                //Get City Name ..
                var city = _dbCity.CityById(currentTeacher.CityId);
                lblCity.Text = city.Name;
                lblGender.Text = currentTeacher.Gender;

                txtEmployeeId.Text = currentTeacher.EmployeeId;
                txtDesignation.Text = currentTeacher.Designation;
                if (currentTeacher.Picture != string.Empty)
                {
                    imgProfilePic.ImageUrl = "../Dashboard/"+currentTeacher.Picture;
                }
                LoadDepartments();

                lblEmployeeId.Text = currentTeacher.EmployeeId;
                lblDesignation.Text = currentTeacher.Designation;

                //Get Department Name ..
                var department = _dbDepartment.DepartmentById(currentTeacher.DepartmentId);
                lblDepartment.Text = department.Name;


                //A confirmation message
                WelcomeMessage.InnerText = "Welcome "+currentTeacher.FullName;
                WelcomeMessage.InnerText += currentTeacher.UserType == "t"
                    ? "You are login as teacher"
                    : "You are login as admin";

                //To Know different Type of Approval status such as Approved, Pending and Banned Numbers
                ApprovalNumbers();
            }
        }


        private void ApprovalNumbers()
        {

            //Total New Requests
            var newRequests = _dbProjectRequest.Search(string.Empty, "Pending", SessionManager.CurrentLoginTeacher.Email, 
                                string.Empty, string.Empty);
            lnkBtnNewMessages.Text = newRequests.Rows.Count > 0 ? newRequests.Rows.Count.ToString() : "0";


            //Total Approved Request
            var approvedRequests = _dbProjectRequest.Search(string.Empty, "Approved", SessionManager.CurrentLoginTeacher.Email, 
                string.Empty, string.Empty);
            lnkBtnApprovedRequest.Text = approvedRequests.Rows.Count > 0 ? approvedRequests.Rows.Count.ToString() : "0";



            //Total Approved Request
            var bannedRequests = _dbProjectRequest.Search(string.Empty, "Banned", SessionManager.CurrentLoginTeacher.Email, 
                                string.Empty, string.Empty);
            lnkBtnBannedRequest.Text = bannedRequests.Rows.Count > 0 ? bannedRequests.Rows.Count.ToString() : "0";

        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPageData();
                
            }
        }


        protected void btnAcademicInfoUpdate_Click(object sender, EventArgs e)
        {
            var currentTeacher = SessionManager.CurrentLoginTeacher;
            currentTeacher.EmployeeId = txtEmployeeId.Text;
            currentTeacher.Designation = txtDesignation.Text;
            currentTeacher.DepartmentId = Convert.ToInt32(ddlDepartment.SelectedValue);

            if (_dbTeacher.Update(currentTeacher))
            {
                SessionManager.CurrentLoginTeacher = _dbTeacher.TeacherById(currentTeacher.Id);
                LoadPageData();
                lblMessageUpdateAcademic.Text = "Academic Info Updated";
                lblMessageUpdateAcademic.ForeColor = System.Drawing.Color.Green;
                ClientScript.RegisterStartupScript(GetType(), "HideLabel",
                        "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + lblMessageUpdateAcademic.ClientID +
                        "').style.display='none'\",5000)</script>");
            }
        }


        public string GetUniqueKey(int maxSize)
        {
            var chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890".ToCharArray();
            var data = new byte[1];
            var crypto = new RNGCryptoServiceProvider();
            crypto.GetNonZeroBytes(data);
            data = new byte[maxSize];
            crypto.GetNonZeroBytes(data);
            var result = new StringBuilder(maxSize);
            foreach (var b in data)
            {
                result.Append(chars[b % (chars.Length)]);
            }
            return result.ToString();
        }


        private string _key;
        private string _imageRename;
        //Method for ImageUpload


        private string PhotoUpdate()
        {
            var photo = "";
            var currentTeacher = SessionManager.CurrentLoginTeacher;
            _key = GetUniqueKey(7);
            if (flTeacherImage.HasFile)
            {
                var path = Path.GetFileName(flTeacherImage.PostedFile.FileName);
                if (currentTeacher.Picture != string.Empty)
                {
                    File.Delete(Path.Combine(Server.MapPath("~/Dashboard/"), currentTeacher.Picture));
                }
                _imageRename = (_key + path).Replace("'", "`");
                flTeacherImage.SaveAs(Server.MapPath("~/Dashboard/Photo/" + _imageRename));
                photo = "Photo/" + _imageRename;
            }
            return photo;
            //return string.Empty;
        }

        
        protected void btnImageUpdate_Click(object sender, EventArgs e)
        {
            var currentTeacher = SessionManager.CurrentLoginTeacher;
            currentTeacher.Picture = PhotoUpdate();
            if (_dbTeacher.Update(currentTeacher))
            {
                SessionManager.CurrentLoginTeacher = _dbTeacher.TeacherById(currentTeacher.Id);
                LoadPageData();    
            }
            
        }

        
        protected void btnId_Click(object sender, EventArgs e)
        {
           btnId.Text = "You are yes";
        }

        
        private void LoadNewRequests()
        {
            var currentTeacher = SessionManager.CurrentLoginTeacher;
            if (currentTeacher != null)
            {
                var newRequests = _dbProjectRequest.Search(string.Empty, "Pending", currentTeacher.Email, string.Empty,
                    string.Empty);
                grdStudentRequests.DataSource = newRequests;
                grdStudentRequests.DataBind();

                grdStudentRequests.Columns[0].Visible = true;
                grdStudentRequests.Columns[1].Visible = false;
                grdStudentRequests.Columns[2].Visible = false;
                grdStudentRequests.Columns[6].Visible = false;
            }
        }


        private void LoadBannedRequests()
        {
            var currentTeacher = SessionManager.CurrentLoginTeacher;
            if (currentTeacher != null)
            {
                var newRequests = _dbProjectRequest.Search(string.Empty, "Banned", currentTeacher.Email, string.Empty,
                    string.Empty);
                grdStudentRequests.DataSource = newRequests;
                grdStudentRequests.DataBind();

                grdStudentRequests.Columns[0].Visible = false;
                grdStudentRequests.Columns[1].Visible = false;
                grdStudentRequests.Columns[2].Visible = true;
                grdStudentRequests.Columns[6].Visible = true;
            }
        }


        private void LoadApprovedRequests()
        {
            var currentTeacher = SessionManager.CurrentLoginTeacher;
            if (currentTeacher != null)
            {
                var newRequests = _dbProjectRequest.Search(string.Empty, "Approved", currentTeacher.Email, string.Empty,
                    string.Empty);
                grdStudentRequests.DataSource = newRequests;


                grdStudentRequests.Columns[0].Visible = false;
                grdStudentRequests.Columns[1].Visible = true;
                grdStudentRequests.Columns[2].Visible = false;
                grdStudentRequests.Columns[6].Visible = true;

                grdStudentRequests.DataBind();

            }
        }


        protected void btnNewMessage_Click(object sender, EventArgs e)
        {
            LoadNewRequests();
        }
        protected void lnkBtnNewMessages_Click(object sender, EventArgs e)
        {
            LoadNewRequests();
        }

        protected void btnBannedRequest_Click(object sender, EventArgs e)
        {
            LoadBannedRequests();
        }
        protected void lnkBtnBannedRequest_Click(object sender, EventArgs e)
        {
            LoadBannedRequests();
        }

        protected void btnApprovedRequest_Click(object sender, EventArgs e)
        {
            LoadApprovedRequests();
        }

        protected void lnkBtnApprovedRequest_Click(object sender, EventArgs e)
        {
            LoadApprovedRequests();
        }

        protected void grdStudentRequests_RowEditing(object sender, GridViewEditEventArgs e)
        {
            var dataKey = grdStudentRequests.DataKeys[e.NewEditIndex];
            if (dataKey != null)
            {
                int studentId = Convert.ToInt32(dataKey.Value);
                var requestApproval = _dbProjectRequest.ProjectRequestById(studentId, SessionManager.CurrentLoginTeacher.Id);
                requestApproval.ApprovalStatus = "Approved";
                requestApproval.ConfirmationDate = DateTime.Now.ToString(CultureInfo.InvariantCulture);
                if (_dbProjectRequest.Update(requestApproval, studentId, SessionManager.CurrentLoginTeacher.Id))
                {
                    lblApprovalStatus.Text = "Successfully Approved";
                    lblApprovalStatus.ForeColor = Color.Green;
                    LoadNewRequests();
                    ApprovalNumbers();
                }
            }
            

        }

        protected void grdStudentRequests_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            var dataKey = grdStudentRequests.DataKeys[e.RowIndex];
            if (dataKey != null)
            {
                int studentId = Convert.ToInt32(dataKey.Value);
                var requestBan = _dbProjectRequest.ProjectRequestById(studentId, SessionManager.CurrentLoginTeacher.Id);
                requestBan.ApprovalStatus = "Banned";
                requestBan.ConfirmationDate = DateTime.Now.ToString(CultureInfo.InvariantCulture);
                if (_dbProjectRequest.Update(requestBan, studentId, SessionManager.CurrentLoginTeacher.Id))
                {
                    lblApprovalStatus.Text = "Request successfully banned";
                    lblApprovalStatus.ForeColor = Color.Green;
                    LoadBannedRequests();
                    ApprovalNumbers();
                }
            }
            
        }



        protected void grdStudentRequests_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            var dataKey = grdStudentRequests.DataKeys[e.RowIndex];
            if (dataKey != null)
            {
                int studentId = Convert.ToInt32(dataKey.Value);
                var requestDeny = _dbProjectRequest.ProjectRequestById(studentId, SessionManager.CurrentLoginTeacher.Id);

                requestDeny.StudentId = studentId;
                requestDeny.TeacherId = SessionManager.CurrentLoginTeacher.Id;
                if (_dbProjectRequest.Delete(requestDeny))
                {
                    lblApprovalStatus.Text = "Successfully Successfully Deleted";
                    lblApprovalStatus.ForeColor = Color.Green;
                    LoadNewRequests();
                    ApprovalNumbers();
                }
            }
        }


    }
}