using System;
using System.Data;
using System.IO;
using System.Web.UI;
using ProjectManagementVerification.BLL;
using ProjectManagementVerification.DAL;
using ProjectManagementVerification.SecurityFiles;

namespace ProjectManagementVerification.View
{
    public partial class ViewProjectDetails : Page
    {
        private readonly ProjectRegistrationDb _db = new ProjectRegistrationDb();
        private readonly ProjectPhaseDb _dbProjectPhase = new ProjectPhaseDb();
        private readonly ChecklistDb _dbChecklist = new ChecklistDb();
        private readonly AssignTaskDb _dbAssignTask = new AssignTaskDb();
        private readonly TaskFeedbackDb _dbTaskFeedback = new TaskFeedbackDb();
        private readonly WordToPdfConverter _pdfConverter = new WordToPdfConverter();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                HashGenerator hashGenerator = new HashGenerator();
                string id = Request.QueryString["id"];
                string key2 = hashGenerator.Md5Hash(hashGenerator.Md5Hash(id));
                string key3 = hashGenerator.Md5Hash(key2);

                if ((key2 == Request.QueryString["key2"]) && (key3 == Request.QueryString["key3"]))
                {
                    LoadProject();
                }
                else
                {
                    Response.Redirect("Default.aspx");
                }
            }
        }


        private void LoadProject()
        {
            ProjectRegistration projectRegistration =
                _db.ProjectRegistrationById(Convert.ToInt32(Request.QueryString["id"]));
            projectTitle.InnerHtml = projectRegistration.ProjectTitle;

            DataTable dtProjectPhases = _dbProjectPhase.Search(projectRegistration.ProjectTypeId, string.Empty, 0);
            

            string contents = string.Empty;
            for (int i = 0; i < dtProjectPhases.Rows.Count; i++)
            {
                int number = i + 1;
                contents += "<h3>"+number+". "+dtProjectPhases.Rows[i]["PhaseName"]+"</h3>";
                DataTable dtChecklists = _dbChecklist.Search(projectRegistration.TeacherId, Convert.ToInt32(dtProjectPhases.Rows[i]["Id"]), 0, string.Empty);
                for (int j = 0; j < dtChecklists.Rows.Count; j++)
                {
                    int subNumber = j + 1;
                    contents += "<h4 style='padding-left: 10px'>" + number + "."+ subNumber +". "+ dtChecklists.Rows[j]["ChecklistName"] + "</h4>";
                }
            }
            tableOfContent.InnerHtml = contents;
            
            string description = "<div style='margin-top:80px'; font-family:'Times New Roman', Times, serif>"; 
            for (int i = 0; i < dtProjectPhases.Rows.Count; i++)
            {
                int number = i + 1;
                description += "<h3>" + number + ". " + dtProjectPhases.Rows[i]["PhaseName"] + "</h3>";
                DataTable dtChecklists = _dbChecklist.Search(projectRegistration.TeacherId, Convert.ToInt32(dtProjectPhases.Rows[i]["Id"]), 0, string.Empty);
                for (int j = 0; j < dtChecklists.Rows.Count; j++)
                {
                    int subNumber = j + 1;
                    description += "<h4>" + number + "." + subNumber + ". " + dtChecklists.Rows[j]["ChecklistName"] + "</h4>";
                    DataTable dtAssignTask = _dbAssignTask.Search(0, Convert.ToInt32(dtChecklists.Rows[j]["Id"]), projectRegistration.TeacherId, string.Empty, projectRegistration.Id);
                    for (int k = 0; k < dtAssignTask.Rows.Count; k++)
                    {
                        description += "<h5>" + dtAssignTask.Rows[k]["TaskTitle"] + "<h5>";
                        DataTable dtTaskFeedback = _dbTaskFeedback.Search(Convert.ToInt32(dtAssignTask.Rows[k]["Id"]), 0);
                        for (int l = 0; l < dtTaskFeedback.Rows.Count; l++)
                        {
                            if (dtTaskFeedback.Rows[l]["FeedbackFile"].ToString() != string.Empty)
                            {

                                string file = dtTaskFeedback.Rows[l]["FeedbackFile"].ToString();
                                string ext =  file.Substring(file.Length - 4, 4);
                                string fileWithoutExt = file.Substring(0, file.Length - 4);
                                if (ext == ".doc")
                                {
                                    string source = Server.MapPath("~/ProjectFiles/" + file);
                                    string destination = Server.MapPath("~/ProjectFiles/" + fileWithoutExt + ".pdf");
                                    _pdfConverter.Convert(source, destination);
                                    file = fileWithoutExt + ".pdf";
                                }
                                else if (ext == "docx")
                                {

                                    string source = Server.MapPath("~/ProjectFiles/" + file);
                                    string destination = Server.MapPath("~/ProjectFiles/" + fileWithoutExt + "pdf");
                                    if (!File.Exists(destination))
                                    {
                                        _pdfConverter.Convert(source, destination);
                                    }
                                    file = fileWithoutExt + "pdf";
                                }
                                description += "";
                                description +=
                                        @"<div class='row'>
                                            <div class='col-lg-12' style='margin-top: 40px'>
                                                    <p>" + dtTaskFeedback.Rows[l]["FeedbackDescription"] + "</p>"+
                                                    "<embed style='width:90%; min-height:1000px' name='plugin' src='../ProjectFiles/" +
                                                    file + @"' type='application/pdf'>
                                                </div>
                                            </div>
                                        </div>";
                                
                                //description += file+" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + file.Length+"<br/>";
                            }//End of if feedback file is not empty
                        }
                    }
                }
            }
            description += "</div>";
            tableDescription.InnerHtml = description;
            Console.WriteLine();
        }


    }
}