using System.Threading;

using System;
using System.IO;
using System.IO.Packaging;
using System.Web.UI;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Wordprocessing;

namespace ProjectManagementVerification.Dashboard
{
    public partial class WebForm1 : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            /*var userData = txtInfo.Text;

            var dataFile = Server.MapPath("~/DemoFiles/data.txt");
            File.WriteAllText(@dataFile, userData);
            string result = "Information saved.";*/
            /*FileGenerator fileGenerator = new FileGenerator();

            fileGenerator.CreateFile(txtInfo.Text);*/

            var dataFile = Server.MapPath("~/TextFiles/TranslationOne.docx");
            Thread.SpinWait(6000);
            string content = OpenWordprocessingDocumentReadonly(@"F:\VisualStudioProjects\ProjectWorks\AcademicProject\BackUpProjectOfFinalProject\ProjectManagementVerification-Working\ProjectManagementVerification\TextFiles\TranslationOne.docx");
            lblShow.Text = content; //"Hello World";
        }


        private static string GetWordDocContent(string doc)
        {
            //Stream stream = File.Open(doc, FileMode.Open);
            WordprocessingDocument wordprocessingDocument = WordprocessingDocument.Open(doc, true);
            Body body = wordprocessingDocument.MainDocumentPart.Document.Body;
            string content = body.InnerText;
            return content;
        }


        public static string OpenWordprocessingDocumentReadonly(string filepath)
        {
            // Open a WordprocessingDocument based on a filepath.
            using (WordprocessingDocument wordDocument =
                WordprocessingDocument.Open(filepath, false))
            {
                // Assign a reference to the existing document body.  
                Body body = wordDocument.MainDocumentPart.Document.Body;

                // Attempt to add some text.
                /*Paragraph para = body.AppendChild(new Paragraph());
                Run run = para.AppendChild(new Run());
                run.AppendChild(new Text("Append text in body, but text is not saved - OpenWordprocessingDocumentReadonly"));
                */
                string content = body.InnerXml;
                return content;
                // Call Save to generate an exception and show that access is read-only.
                // wordDocument.MainDocumentPart.Document.Save();
            }
        }

        public static void OpenWordprocessingPackageReadonly(string filepath)
        {
            // Open System.IO.Packaging.Package.
            Package wordPackage = Package.Open(filepath, FileMode.Open, FileAccess.Read);

            // Open a WordprocessingDocument based on a package.
            using (WordprocessingDocument wordDocument =
                WordprocessingDocument.Open(wordPackage))
            {
                // Assign a reference to the existing document body. 
                Body body = wordDocument.MainDocumentPart.Document.Body;

                // Attempt to add some text.
                Paragraph para = body.AppendChild(new Paragraph());
                Run run = para.AppendChild(new Run());
                run.AppendChild(new Text("Append text in body, but text is not saved - OpenWordprocessingPackageReadonly"));

                // Call Save to generate an exception and show that access is read-only.
                // wordDocument.MainDocumentPart.Document.Save();
            }

            // Close the package.
            wordPackage.Close();
        }



    }
}