<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Operations.aspx.cs" Inherits="ProjectManagementVerification.View.AjaxRequestPages.Operations" %>
<%@ Import Namespace="ProjectManagementVerification.BLL" %>
<%@ Import Namespace="ProjectManagementVerification.DAL" %>




<%
            ProjectRequestDb _dbProjectRequest = new ProjectRequestDb();
            

            if (Request.HttpMethod == "GET")
            {
                if (Request.QueryString["studentIdToConfirm"] != null)
                {
                    if (Request.QueryString["studentIdToConfirm"] == "")
                    {
                        
                    }
                    else
                    {
                        //Response.Write(Request.QueryString["studentIdToConfirm"]);
                        int studentId = Convert.ToInt32(Request.QueryString["studentIdToConfirm"]);
                        int teacherId = SessionManager.CurrentLoginTeacher.Id;
                        var projectInfo = _dbProjectRequest.ProjectRequestById(studentId, teacherId);
                        projectInfo.ApprovalStatus = "Approved";
                        projectInfo.ConfirmationDate = DateTime.Now.ToString();

                        
                        if (_dbProjectRequest.Update(projectInfo, studentId, teacherId))
                        {
                            Response.Write("Success");
                        }
                        else
                        {
                            Response.Write("Fail");
                        }
                    }
                    
                }
            }
    %>

