using System;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Web.UI.WebControls;
using ProjectManagementVerification.DAL;
using ProjectPhaseBLL = ProjectManagementVerification.BLL.ProjectPhase;

namespace ProjectManagementVerification.Dashboard
{
    public partial class ProjectPhaseAdd : System.Web.UI.Page
    {
        private readonly ProjectPhaseDb _dbProjectPhase = new ProjectPhaseDb();
        private readonly ProjectTypeDb _dbProjectType = new ProjectTypeDb();
        private static int SearchType { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (SessionManager.CurrentLoginTeacher != null)
                {
                    if (SessionManager.CurrentLoginTeacher.UserType != "a")
                    {
                        Response.Redirect("../View/Login.aspx");
                    }
                    else
                    {
                        PageData();
                    }
                }
                else
                {
                    Response.Redirect("../View/Login.aspx");
                }
            }
        }

        private void PageData()
        {
            DataTable dtProjectType = _dbProjectType.GetData(string.Empty, 1);
            for (int i = 0; i < dtProjectType.Rows.Count; i++)
            {
                ddlProjectType.Items.Insert(i, new ListItem(dtProjectType.Rows[i]["Name"].ToString(), 
                    dtProjectType.Rows[i]["Id"].ToString()));
            }
            ddlProjectType.Items.Insert(0, "Select Project Type");
            txtProjectPhaseName.Text = "";
            txtPhaseDescription.Text = "";
            GridView1.DataSource = null;
            GridView1.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            SearchType = 0;
            GridView1.DataSource = _dbProjectPhase.GetData(txtSearch.Text.Replace("'", "`"), SearchType);
            GridView1.DataBind();
        }

        protected void btnSearchAll_Click(object sender, EventArgs e)
        {
            SearchType = 1;
            GridView1.DataSource = _dbProjectPhase.GetData(string.Empty, SearchType);
            GridView1.DataBind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (_dbProjectPhase.ExistingValidationProjectPhase(Convert.ToInt32(ddlProjectType.SelectedValue),
                txtProjectPhaseName.Text.Replace("'", "`")))
            {
                DataTable dtCheckPriorityExist = _dbProjectPhase.Search(Convert.ToInt32(ddlProjectType.SelectedValue),
                    string.Empty, Convert.ToInt32(ddlPriority.SelectedValue));
                if (dtCheckPriorityExist.Rows.Count > 0)
                {
                    lblMessage.Text = "The priority <b>\"" + ddlPriority.SelectedItem.Text +
                                      "\"</b> is already set for <b>\"" + ddlProjectType.SelectedItem.Text + "\"</b>";
                    lblMessage.ForeColor = Color.Red;
                }
                else
                {
                    var projectPhase = new ProjectPhaseBLL
                    {
                        ProjectTypeId = Convert.ToInt32(ddlProjectType.SelectedValue),
                        PhaseName = txtProjectPhaseName.Text.Replace("'", "`"),
                        PhaseDescription = txtPhaseDescription.Text.Replace("'", "`"),
                        Priority = Convert.ToInt32(ddlPriority.SelectedValue),
                        CreationDate = DateTime.Now.ToString(CultureInfo.InvariantCulture)
                    };
                    if (_dbProjectPhase.Save(projectPhase))
                    {
                        lblMessage.Text = "Successfully Saved";
                        lblMessage.ForeColor = Color.Green;
                        PageData();
                    }
                    else
                    {
                        lblMessage.Text = "Failed to insert";
                        lblMessage.ForeColor = Color.Red;
                    }
                }
            }
            else
            {
                lblMessage.Text = "Sorry! The Project Phase <b>\""+txtProjectPhaseName.Text+"\"</b> under <b>\""+ddlProjectType.SelectedItem.Text+"\"</b> already exist";
                lblMessage.ForeColor = Color.Red;
            }
            ClientScript.RegisterStartupScript(GetType(), "HideLabel",
            "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + lblMessage.ClientID +
            "').style.display='none'\",10000)</script>");
            
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
            var projectPhaseToDelete = new ProjectPhaseBLL
            {
                Id = id
            };
            if (_dbProjectPhase.Delete(projectPhaseToDelete))
            {
                lblMessage.Text = "Successfully Deleted";
                lblMessage.ForeColor = Color.Green;
                PageData();
            }
            else
            {
                lblMessage.Text = "Sorry! Can't delete. May be used in some projects";
                lblMessage.ForeColor = Color.Red;
            }
            ClientScript.RegisterStartupScript(GetType(), "HideLabel",
            "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + lblMessage.ClientID +
            "').style.display='none'\",10000)</script>");
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int id = Convert.ToInt32(GridView1.DataKeys[e.NewEditIndex].Value);
            SessionManager.ProjectPhaseToEdit = _dbProjectPhase.ProjectPhaseById(id);
            Response.Redirect("EditProjectPhase.aspx");
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            if (SearchType == 0)
            {
                GridView1.DataSource = _dbProjectPhase.GetData(txtSearch.Text, 0);
                GridView1.DataBind();
            }
            else
            {
                GridView1.DataSource = _dbProjectPhase.GetData(string.Empty, 1);
                GridView1.DataBind();
            }
        }




    }
}