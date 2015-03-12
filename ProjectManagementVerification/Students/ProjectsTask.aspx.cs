using System;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using ProjectManagementVerification.DAL;
using TaskFeedbackBLL = ProjectManagementVerification.BLL.TaskFeedback;

namespace ProjectManagementVerification.Students
{
    public partial class ProjectsTask : System.Web.UI.Page
    {
        private readonly TaskFeedbackDb _db = new TaskFeedbackDb();

        protected void Page_Load(object sender, EventArgs e)
        {

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
            if (flUploadFiles.HasFile)
            {
                var path = Path.GetFileName(flUploadFiles.PostedFile.FileName);
                _fileRename = (_key + path).Replace("'", "`");
                flUploadFiles.SaveAs(Server.MapPath("~/ProjectFiles/" + _fileRename));
                file = _fileRename;
            }
            else
            {
                file = string.Empty;
            }
            return file;
        }


        protected void btnSubmitFeedback_Click(object sender, EventArgs e)
        {
            TaskFeedbackBLL taskFeedback = new TaskFeedbackBLL
            {
                TaskId  =  Convert.ToInt32(txtTaskId.Text),
                FeedbackDescription = txtFeedback.Text.Replace("'","`"),
                FeedbackFile = FileUpload(),
                FeedbackDate = DateTime.Now.ToString(CultureInfo.InvariantCulture),
                UpdateDate = string.Empty,
                EvaluationStatus = "New",
                StudentId = SessionManager.CurrentLoginStudent.Id
            };

            if (_db.Save(taskFeedback))
            {
                lblMessage.Text = "Feedback Successfully Submitted";
                lblMessage.ForeColor = Color.Green;
            }
            else
            {
                lblMessage.Text = "Failed to Submit";
                lblMessage.ForeColor = Color.Red;
            }
            
            //lblMessage.Text = _db.Save(taskFeedback);

        }




        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            TaskFeedbackBLL taskFeedback = _db.TaskFeedbackById(Convert.ToInt32(txtFeedbackId.Text.Replace("'", "")));
            taskFeedback.FeedbackDescription = txtFeedback.Text.Replace("'", "`");
            taskFeedback.UpdateDate = DateTime.Now.ToString(CultureInfo.InvariantCulture);
            if (flUploadFiles.HasFile)
            {
                if (taskFeedback.FeedbackFile != string.Empty)
                {
                    File.Delete(Path.Combine(Server.MapPath("~/ProjectFiles/"), taskFeedback.FeedbackFile));
                }
                taskFeedback.FeedbackFile = FileUpload();
            }
            if (_db.Update(taskFeedback, "No"))
            {
                lblMessage.Text = "Successfully Updated";
                lblMessage.ForeColor = Color.ForestGreen;
            }
            else
            {
                lblMessage.Text = "Failed to update";
                lblMessage.ForeColor = Color.Red;
            }
        }

        protected void btnDeleteFeedback_Click(object sender, EventArgs e)
        {
            TaskFeedbackBLL taskFeedback = _db.TaskFeedbackById(Convert.ToInt32(txtFeedbackId.Text.Replace("'", "")));
            if (_db.Delete(Convert.ToInt32(txtFeedbackId.Text.Replace("'", ""))))
            {
                File.Delete(Path.Combine(Server.MapPath("~/ProjectFiles/"), taskFeedback.FeedbackFile));
                lblMessage.Text = "Task successfully deleted";
                lblMessage.ForeColor = Color.Green;
            }
            else
            {
                lblMessage.ForeColor = Color.Red;
            }
        }

        

    }
}