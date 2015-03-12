using System;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using ProjectManagementVerification.DAL;
using ProjectManagementVerification.SecurityFiles;
using AssignTaskBLL = ProjectManagementVerification.BLL.AssignTask;
using TaskFeedbackBLL = ProjectManagementVerification.BLL.TaskFeedback;

namespace ProjectManagementVerification.Dashboard
{
    public partial class AssignTask : System.Web.UI.Page
    {
        private readonly AssignTaskDb _db = new AssignTaskDb();
        private readonly TaskFeedbackDb _dbFeedback = new TaskFeedbackDb();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                txtClickCheckProject.Text = "";
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
        private string _fileRename;
        //Method for FileUpload
        private string FileUpload()
        {
            var file = "";
            _key = GetUniqueKey(7);
            if (flTaskUploadFiles.HasFile)
            {
                var path = Path.GetFileName(flTaskUploadFiles.PostedFile.FileName);
                _fileRename = (_key + path).Replace("'", "`");
                flTaskUploadFiles.SaveAs(Server.MapPath("~/ProjectFiles/" + _fileRename));
                file = _fileRename;
            }
            else
            {
                file = string.Empty;
            }
            return file;
        }



        protected void btnAssignTask_Click(object sender, EventArgs e)
        {
            //FileUpload()
            FileGenerator fileGenerator = new FileGenerator();
            AssignTaskBLL assignTask = new AssignTaskBLL
            {
                ChecklistId = Convert.ToInt32(Request.Form["txtChecklistId"]),
                TeacherId = SessionManager.CurrentLoginTeacher.Id,
                ProjectId = Convert.ToInt32(Request.Form["txtProjectId"]),
                StudentGroupId = Convert.ToInt32(Request.Form["txtGroupId"]),
                TaskDescription = fileGenerator.CreateFile(txtTaskDescription.Text),
                TaskFile = FileUpload(),
                AssignDate = DateTime.Now.ToString(CultureInfo.InvariantCulture),
                Deadline = txtDeadline.Text,
                TaskStatus = "Assigned"
            };
            
            if (_db.Save(assignTask))
            {
                lblMessage.Text = "Task Successfully Assigned";
                lblMessage.ForeColor = Color.Green;
            }
            else
            {
                lblMessage.Text = "Failed to assign task";
                lblMessage.ForeColor = Color.Red;
            }

        }

        protected void btnUpdateTask_Click(object sender, EventArgs e)
        {
            FileGenerator fileGenerator = new FileGenerator();
            AssignTaskBLL assignTask = _db.AssignTaskById(Convert.ToInt32(Request.Form["txtTaskId"]));
            /*Response.Write(assignTask.ProjectId + "<br/>");
            Response.Write(assignTask.StudentGroupId + "<br/>");
            Response.Write(assignTask.TeacherId + "<br/>");
            Response.Write(assignTask.TaskTitle + "<br/>");
            Response.Write(assignTask.TaskDescription + "<br/>");
            Response.Write(assignTask.TaskStatus + "<br/>");
            Response.Write(assignTask.ProjectId + "<br/>");*/
            string previousDescriptionFile = assignTask.TaskDescription;
            string previousAttachment = assignTask.TaskFile;
            assignTask.TaskDescription = fileGenerator.CreateFile(txtTaskDescription.Text);
            assignTask.Deadline = txtDeadline.Text;
            assignTask.TaskStatus = ddlTaskStatus.SelectedItem.Text;
            if (flTaskUploadFiles.HasFile)
            {
                assignTask.TaskFile = FileUpload();
            }

            if (_db.Update(assignTask))
            {
                 lblMessage.Text = "Successfully Updated";
                 lblMessage.ForeColor = Color.ForestGreen;
                 try
                 {
                     File.Delete(Path.Combine(Server.MapPath("~/TextFiles/"), previousDescriptionFile));
                 }
                 catch (Exception)
                 {

                 }
                 try
                 {
                     File.Delete(Path.Combine(Server.MapPath("~/ProjectFiles/"), previousAttachment));
                 }
                 catch (Exception)
                 {

                 }
            }
            else
            {
                 lblMessage.Text = "Failed to update";
                 lblMessage.ForeColor = Color.Red;
            }
                      
            
            //lblMessage.Text = _db.Update(assignTask);
            //Response.Write(task);
        }

        protected void btnUpdateFeedbackStatus_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(txtFeedbackId.Text);
            TaskFeedbackBLL taskFeedback = _dbFeedback.TaskFeedbackById(id);
            if (_dbFeedback.Update(taskFeedback, "No"))
            {
                lblMessage.Text = "Task feedback Status Successfully Updated";
                lblMessage.ForeColor = Color.Green;
            }
            else
            {
                lblMessage.Text = "Failed to update task feedback";
                lblMessage.ForeColor = Color.Red;
            }
        }

        protected void btnSearchProjects_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
        }

        protected void btnDeleteTask_Click(object sender, EventArgs e)
        {
            AssignTaskBLL assignTask = _db.AssignTaskById(Convert.ToInt32(Request.Form["txtTaskId"]));
            string textFile = assignTask.TaskDescription;
            string docFile = assignTask.TaskFile;
            lblMessage.Text = textFile;
            if (_db.Delete(assignTask))
            {
                lblMessage.Text = "Task Successfully Deleted";
                lblMessage.ForeColor = Color.ForestGreen;
                try
                {
                    File.Delete(Path.Combine(Server.MapPath("~/TextFiles/"), textFile));
                }
                catch (Exception)
                {
                }
                try
                {
                    File.Delete(Path.Combine(Server.MapPath("~/ProjectFiles/"), docFile));
                }
                catch (Exception)
                {
                }
            }
            else
            {
                lblMessage.Text = "Failed to delete";
                lblMessage.ForeColor = Color.Red;
            }


        }

    }
}