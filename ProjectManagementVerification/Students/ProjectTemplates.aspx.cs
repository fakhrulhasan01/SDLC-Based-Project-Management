using System;
using System.Data;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text.pdf;
using ProjectManagementVerification.DAL;
using iTextSharp.tool.xml;
using iTextSharp.text;

namespace ProjectManagementVerification.Students
{
    public partial class ProjectTemplates : Page
    {
        private readonly ProjectTypeDb _dbProjectType = new ProjectTypeDb();
        private readonly ProjectPhaseDb _dbProjectPhase = new ProjectPhaseDb();
        private readonly ChecklistDb _dbcChecklist = new ChecklistDb();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProjectsType();
            }
        }

        private void LoadProjectsType()
        {
            DataTable dtProjectType = _dbProjectType.GetData(string.Empty, 1);
            for (int i = 0; i < dtProjectType.Rows.Count; i++)
            {
                radioTemplates.Items.Add(new System.Web.UI.WebControls.ListItem(dtProjectType.Rows[i]["Name"].ToString(), dtProjectType.Rows[i]["Id"].ToString()));
            }
        }


        private string TemplateTableOfContent(int projectTypeId)
        {
            DataTable dtProjectPhases = _dbProjectPhase.Search(projectTypeId, string.Empty, 0);


            string contents = @"<center><span style='text-align:center;font-size:28px; font-weight:bold'>TABLE OF CONTENTS FOR</span></center><br/>";
            contents += @"<center><span style='text-align:center; font-size:28px; font-weight:bold'>" + dtProjectPhases.Rows[0]["ProjectTypeName"] + "</span></center><br/><br/>";
            
            for (int i = 0; i < dtProjectPhases.Rows.Count; i++)
            {
                int number = i + 1;
                contents += "<h3>" + number + ". " + dtProjectPhases.Rows[i]["PhaseName"] + "</h3>";
                DataTable dtChecklists = _dbcChecklist.Search(0, Convert.ToInt32(dtProjectPhases.Rows[i]["Id"]), "Active", "Mandatory");
                for (int j = 0; j < dtChecklists.Rows.Count; j++)
                {
                    int subNumber = j + 1;
                    contents += "<h4 style='padding-left: 10px'>" + number + "." + subNumber + ". " + dtChecklists.Rows[j]["ChecklistName"] + "</h4>";
                }
            }
            string fileName = dtProjectPhases.Rows[0]["ProjectTypeName"] + ".pdf";
            GeneratePdf(contents, fileName);
            return fileName;
        }


        public void GeneratePdf(string content, string fileName)
        {
            //Create a byte array that will eventually hold our final PDF
            Byte[] bytes;

            //Boilerplate iTextSharp setup here
            //Create a stream that we can write to, in this case a MemoryStream
            using (var ms = new MemoryStream())
            {

                //Create an iTextSharp Document which is an abstraction of a PDF but **NOT** a PDF
                using (var doc = new Document())
                {

                    //Create a writer that's bound to our PDF abstraction and our stream
                    using (var writer = PdfWriter.GetInstance(doc, ms))
                    {

                        //Open the document for writing
                        doc.Open();

                        //Our sample HTML and CSS
                        /*var example_html = @"<table border='1'><tr><td><h2 style='font-size:40px'>Why Two Times</h2></td><td><h2>I am Sujon</h2></td></tr>";
                        example_html += @"<tr><td><p>Para One</p></td><td><img src='" + Server.MapPath("~/img/Desert.jpg") + "' width='200' height='100'/></td></tr></table>";*/
                        var example_css = @".headline{font-size:200%}";


                        /**************************************************
                         * Example #3                                     *
                         *                                                *
                         * Use the XMLWorker to parse HTML and CSS        *
                         * ************************************************/

                        //In order to read CSS as a string we need to switch to a different constructor
                        //that takes Streams instead of TextReaders.
                        //Below we convert the strings into UTF8 byte array and wrap those in MemoryStreams
                        using (var msCss = new MemoryStream(System.Text.Encoding.UTF8.GetBytes(example_css)))
                        {
                            using (var msHtml = new MemoryStream(System.Text.Encoding.UTF8.GetBytes(content)))
                            {
                                //Parse the HTML
                                XMLWorkerHelper.GetInstance().ParseXHtml(writer, doc, msHtml, msCss);

                            }
                        }



                        doc.Close();
                    }
                }

                //After all of the PDF "stuff" above is done and closed but **before** we
                //close the MemoryStream, grab all of the active bytes from the stream

                bytes = ms.ToArray();
            }

            
            var testFile = Path.Combine(Server.MapPath("~/ProjectFiles/"+fileName));
            System.IO.File.WriteAllBytes(testFile, bytes);

            

        }


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string fileName = TemplateTableOfContent(Convert.ToInt32(radioTemplates.SelectedValue));
            Response.Redirect("~/ProjectFiles/"+fileName);
            //Response.Write(Convert.ToInt32(radioTemplates.SelectedValue).ToString());
        }

        

        
    }
}