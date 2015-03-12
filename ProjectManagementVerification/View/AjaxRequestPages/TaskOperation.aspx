<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TaskOperation.aspx.cs" Inherits="ProjectManagementVerification.View.AjaxRequestPages.TaskOperation" %>
<%@ Import Namespace="ProjectManagementVerification.BLL" %>
<%@ Import Namespace="ProjectManagementVerification.DAL" %>
<%
    TaskFeedbackDb _dbFeedbackTask = new TaskFeedbackDb();
    PhaseCompletionDb _dbPhaseCompletion = new PhaseCompletionDb();
    PhaseCompletion phaseCompletion = new PhaseCompletion();
    if (Request.HttpMethod == "GET")
    {
        if (Request.QueryString["PhaseStatus"] != null)
        {
            phaseCompletion.PhaseId = Convert.ToInt32(Request.QueryString["phaseId"]);
            phaseCompletion.ProjectId = Convert.ToInt32(Request.QueryString["projectId"]);
            phaseCompletion.Status = "c";
            string status = Request.QueryString["PhaseStatus"];
            if (status == "Checked")
            {
                if (_dbPhaseCompletion.Save(phaseCompletion))
                {
                    Response.Write("Successful Save");
                }
                else
                {
                    Response.Write(phaseCompletion.PhaseId + " " + phaseCompletion.ProjectId + "Failed Save");
                }
            }
            else
            {
                if (_dbPhaseCompletion.Delete(Convert.ToInt32(Request.QueryString["projectId"]), Convert.ToInt32(Request.QueryString["phaseId"])))
                {
                    Response.Write("Successful Delete");
                }
                else
                {
                    Response.Write(phaseCompletion.PhaseId + phaseCompletion.ProjectId + "Failed Save");
                }
            }
        }else if (Request.QueryString["status"] != null)
        {
            string status = Request.QueryString["status"];
            int feedbackId = Convert.ToInt32(Request.QueryString["feedbackId"]);
            TaskFeedback taskFeedback = _dbFeedbackTask.TaskFeedbackById(feedbackId);
            taskFeedback.EvaluationStatus = status;
            if (_dbFeedbackTask.Update(taskFeedback, "No"))
            {
                Response.Write("Confirmed");
            }
            else
            {
                
            }
        }
    }
%>