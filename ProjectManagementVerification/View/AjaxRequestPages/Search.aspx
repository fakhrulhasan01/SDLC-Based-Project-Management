<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="ProjectManagementVerification.View.AjaxRequestPages.Search" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="ProjectManagementVerification.DAL" %>
<%@ Import Namespace="ProjectManagementVerification.SecurityFiles" %>


 
        
<%
            StudentDb studentDb = new StudentDb();
            TeacherDb teacherDb = new TeacherDb();
            
             
            
            
            
            if (Request.HttpMethod == "GET")
            {
                if (Request.QueryString["search_term"] != null)
                {
                    if (Request.QueryString["search_term"] == "")
                    {
                        Response.Write("Please enter student id");
                    }
                    else
                    {
                        DataTable dt = studentDb.Search(string.Empty, string.Empty, Request.QueryString["search_term"], 0, 0);
                        if (Request.QueryString["search_term"] != SessionManager.CurrentLoginStudent.StudentId)
                        {
                            if (dt.Rows.Count > 0)
                            {
                                Response.Write("<font color='red'>Id is not available</font>");
                            }
                            else
                            {
                                Response.Write("<font color='green'>Available</font>");
                            }
                        }

                        //Response.Write(Request.QueryString["search_term"]);

                    }
                }

                if (Request.QueryString["searchTermEmployeeId"] != null)
                {
                    if (Request.QueryString["searchTermEmployeeId"] == "")
                    {
                        Response.Write("Please enter Employee ID");
                    }
                    else
                    {
                        DataTable dt = teacherDb.Search(string.Empty, string.Empty, Request.QueryString["searchTermEmployeeId"], 0, 0);
                        if (Request.QueryString["searchTermEmployeeId"] != SessionManager.CurrentLoginTeacher.EmployeeId)
                        {
                            if (dt.Rows.Count > 0)
                            {
                                Response.Write("<font color='red'>Employee Id is not available</font>");
                            }
                            else
                            {
                                Response.Write("<font color='green'>Available</font>");
                            }
                        }

                        //Response.Write(Request.QueryString["search_term"]);

                    }
                }


                if (Request.QueryString["search_teacher"] != null)
                {
                    if (Request.QueryString["search_teacher"] == "")
                    {
                        Response.Write("Please enter your query");
                    }
                    else
                    {
                        HashGenerator hg = new HashGenerator();
                        DataTable dt = teacherDb.GetData(Request.QueryString["search_teacher"], 0);
                        
                            if (dt.Rows.Count > 0)
                            {
                                for (int i=0; i<dt.Rows.Count; i++)
                                {
                                    var id = dt.Rows[i][0];
                                    var key = hg.Md5Hash(id.ToString());
                                    key = hg.Md5Hash(key);
                                    Response.Write("<div style='width:30%'>");
                                    Response.Write("<img src='../Dashboard/"+dt.Rows[i]["Picture"]+"' width='100%; display:block' />");
                                    Response.Write("<a style='display:block' href='../View/ViewTeacher.aspx?id="+id+"&key="+key+"'>"+dt.Rows[i][1]+"</a>");
                                    Response.Write("</div>");
                                }
                            }
                            else
                            {
                                Response.Write("<font color='green'>Available</font>");
                            }
                        }

                        //Response.Write(Request.QueryString["search_term"]);

                    
                }
                
                
            }
        %>
