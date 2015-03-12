﻿<%@ Page Title="" Language="C#" MasterPageFile="~/ViewMaster/Dashboard.Master" AutoEventWireup="true" CodeBehind="EditProjectRegistration.aspx.cs" Inherits="ProjectManagementVerification.Dashboard.EditProjectRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    Edit Project Registration
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <style type="text/css">
        input[type="text"],textarea {
            margin-left: 0;
        }

        #icol16 {
            width: 18px;margin: -8px 0px 0px 0px; cursor: pointer
        }
    </style>    
    
        <script>
            var projectTitlePattern = /^[a-zA-Z0-9-_,. ]*$/i;
            var projectTitle;

            var projectSummaryPattern = /^[a-zA-Z0-9-_,. ]*$/i;
            var projectSummary;

            $(document).ready(function () {


                $('#<%=txtProjectTitle.ClientID%>').on('input', function (e) {
                    $(this).keyup();
                });


                $('#<%=txtProjectTitle.ClientID%>').on('input', function (e) {
                    $(this).keyup();
                });



                $("#<%=txtProjectTitle.ClientID%>").keyup(function () {
                    projectTitle = $(this).val();
                    var message;
                    if (projectTitle < 3) {
                        message = "<font color='red'>Minimum Three characters required</font>";
                    }
                    else if (!projectTitlePattern.test(projectTitle)) {
                        message = "<font color='red'>Special Characters not allowed</font>";
                    } else {
                        message = "<font color='green'>Correct</font>";
                    }
                    $("#msgProjectTitle").html(message);
                });



                $("#<%=txtProjectSummary.ClientID%>").keyup(function () {
                    projectSummary = $(this).val();
                    var message;
                    if (!projectSummaryPattern.test(projectSummary)) {
                        message = "<font color='red'>Special Characters not allowed</font>";
                    } else {
                        if (projectSummary == "") {
                            message = "";
                        } else {
                            message = "<font color='green'>Correct</font>";
                        }
                    }
                    $("#msgProjectSummary").html(message);
                });


            });




            function valid() {
                var error = 0;
                var projectTitlePattern = /([0-9a-zA-Z.\s])$/;
                var projectTitle = $("#<%=txtProjectTitle.ClientID%>").val();
            var projectSummaryPattern = /([0-9a-zA-Z.\s])$/;
            var projectSummary = $("#<%=txtProjectSummary.ClientID%>").val();
            var projectGroup = $("#<%=ddlProjectGroup.ClientID%>").val();
            var projectType = $("#<%=ddlProjectType.ClientID%>").val();

            if (!projectTitlePattern.test(projectTitle) || projectTitle.length < 3) {
                error++;
                var message;
                if (projectTitle < 3) {
                    message = "<font color='red'>Minimum Three characters required</font>";
                }
                else if (!projectTitlePattern.test(projectTitle)) {
                    message = "<font color='red'>Special Characters not allowed</font>";
                } else {
                    message = "<font color='green'>Correct</font>";
                }
                $("#msgProjectTitle").html(message);
            }

            if (!projectSummaryPattern.test(projectSummary)) {
                error++;
                message = "<font color='red'>Special Characters not allowed</font>";
                $("#msgProjectSummary").html(message);
            }


            if (projectGroup == "Select Project Group") {
                error++;
                $("#msgProjectGroup").html("<font color='red'>Please select group type</font>");
            }

            if (projectType == "Select Project Type") {
                error++;
                $("#msgProjectType").html("<font color='red'>Please select project type</font>");
            }

            if (error == 0) {
                return true;
            } else {
                $("#msgError").html("<font color='red'>Please correct the errors</font>");
                return false;
            }
        }
    </script>

    <div id="content" class="span10">
        <ul class="breadcrumb">
            <li><i class="icon-home"></i><a href="index.html">Home</a> <i class="icon-angle-right"></i></li>
            <li><i class="icon-edit"></i><a href="#">Project Registration</a> </li>
        </ul>
        <div class="row-fluid sortable">
            <div class="box span12">
                <div class="box-header" data-original-title="">
                    <h2><i class="halflings-icon white edit"></i><span class="break"></span>Edit Registered Project</h2>
                    <div class="box-icon">
                        <a class="btn-setting" href="#"><i class="halflings-icon white wrench"></i></a><a class="btn-minimize" href="#"><i class="halflings-icon white chevron-up"></i></a><a class="btn-close" href="#"><i class="halflings-icon white remove"></i></a>
                    </div>
                </div>    
                <div class="box-content">
                    <div class="span12">
                        <div id="msgError">
                            <asp:Label ID="lblMessage" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="span12">
                        <div class="span6">
                            <div><b>Project Title</b></div>
                            <asp:TextBox ID="txtProjectTitle" placeholder="Enter Project Title" runat="server"></asp:TextBox>
                            <span id="msgProjectTitle"></span>
                        </div>
                        <div class="span6">
                            <div><b>Project Summary</b></div>
                            <asp:TextBox ID="txtProjectSummary" TextMode="MultiLine" placeholder="Write Project Summary/Description" runat="server"></asp:TextBox>
                            <span id="msgProjectSummary"></span>
                        </div>
                    </div>
                    
                    <div class="span12 marg">
                        <div class="span6">
                            <div><b>Change Project Group</b></div>
                            <asp:DropDownList ID="ddlProjectGroup"  data-rel="chosen" runat="server">
                            </asp:DropDownList>
                            <span id="msgProjectGroup"></span>
                        </div>
                        <div class="span6" style="margin-top: 6px">
                            <div><b>Change Project Type</b></div>
                            <asp:DropDownList ID="ddlProjectType"  data-rel="chosen" runat="server">
                            </asp:DropDownList>
                            <span id="msgProjectType"></span>
                        </div>
                    </div>
                    <div class="span12 marg">
                        <div class="span6">
                            <div><b>Project Status</b></div>
                            <asp:DropDownList ID="ddlStatus"  data-rel="chosen" runat="server">
                                <asp:ListItem Text="Active"></asp:ListItem>
                                <asp:ListItem Text="Inactive"></asp:ListItem>
                            </asp:DropDownList>
                            <span id="msgStatus"></span>
                        </div>
                        <div class="span6" style="margin-top: 4px">
                            
                            <div class="span3">
                                <ul id="icol16">
                                    <li onclick="location.href='ProjectRegistration.aspx'" data-rel="tooltip" data-original-title="Go Back">
                                        <a class="icol-arrow-left" href="ProjectRegistration.aspx" title=""></a>
                                    </li>
                                </ul>       
                            </div>
                            <div class="span9">
                                <asp:Button ID="btnSave" runat="server" styles="margin-left: 20px" CssClass="btn btn-primary" OnClick="btnSave_Click" OnClientClick="return valid()" Text="SAVE" ValidationGroup="ReqGroup" />    
                            </div>
                            
                                 
                        </div>
                    </div>
                   


                </div>
            </div>
            
            
            
         </div>
     </div>
    
</asp:Content>
