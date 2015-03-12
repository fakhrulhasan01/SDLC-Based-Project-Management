<%@ Page Title="" Language="C#" MasterPageFile="~/ViewMaster/Dashboard.Master" AutoEventWireup="true" CodeBehind="ProjectRegistration.aspx.cs" Inherits="ProjectManagementVerification.Dashboard.ProjectRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    Project Registration
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">
        input[type="text"],textarea {
            margin-left: 0;
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
                }else {
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
                    <h2><i class="halflings-icon white edit"></i><span class="break"></span>Register Group to Project</h2>
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
                            <asp:TextBox ID="txtProjectTitle" placeholder="Enter Project Title" runat="server"></asp:TextBox>
                            <span id="msgProjectTitle"></span>
                        </div>
                    </div>
                    <div class="span12">
                        <div class="span6">
                            <asp:TextBox ID="txtProjectSummary" TextMode="MultiLine" placeholder="Write Project Summary/Description" runat="server"></asp:TextBox>
                            <span id="msgProjectSummary"></span>
                        </div>
                    </div>
                    <div class="span12">
                        <div class="span6">
                            <asp:DropDownList ID="ddlProjectGroup"  data-rel="chosen" runat="server">
                            </asp:DropDownList>
                            <span id="msgProjectGroup"></span>
                        </div>
                    </div>
                    <div class="span12">
                        <div class="span6">
                            <asp:DropDownList ID="ddlProjectType"  data-rel="chosen" runat="server">
                            </asp:DropDownList>
                            <span id="msgProjectType"></span>
                        </div>
                    </div>
                    <div class="span12">
                        <asp:Button ID="btnSave" runat="server" CssClass="btn2 btn-primary" OnClick="btnSave_Click" 
                            OnClientClick="return valid()" style="margin-left: 172px; margin-top: 6px" Text="SAVE" 
                            ValidationGroup="ReqGroup" />
                    </div>
                    
                    
                    <div class="span12">
                        <div class="span11">
                            <span style="margin:auto; float: right">
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="marg"></asp:TextBox>
                                <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-default" OnClick="btnSearch_Click" Text="SEARCH" />
                                <asp:Button ID="btnSearchAll" runat="server" CssClass="btn btn-default" OnClick="btnSearchAll_Click" Text="SEARCH ALL" />
                            </span>
                        </div>
                    </div>

                    <div class="search_section">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" PageSize="8" AllowPaging="true"
                            CssClass="table table-bordered table-hover" DataKeyNames="Id" EmptyDataText="No Search Result Found" 
                            OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing"  PagerStyle-CssClass="paging"
                            OnPageIndexChanging="GridView1_PageIndexChanging">
                            <Columns>
                                <asp:TemplateField HeaderText="Edit" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="30px">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgEdit" runat="server" CausesValidation="false" CommandArgument='<%#Eval("Id")%>' CommandName="Edit" ImageUrl="../assets/img/edit.png" Text="Hi" ToolTip="Edit" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="30px">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgDel" runat="server" CausesValidation="false" CommandArgument='<%#Eval("Id")%>' CommandName="Delete" ImageUrl="../assets/img/delete.png" onClientClick="return confirm('Are you sure??')" ToolTip="Delete" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="ProjectTitle" HeaderText="Project Title" ReadOnly="True" />
                                <asp:BoundField DataField="ProjectSummary" HeaderText="Project Summary" ReadOnly="True" />
                                <asp:BoundField DataField="ProjectTypeName" HeaderText="Project Type" ReadOnly="True" />
                                <asp:BoundField DataField="GGroupId" HeaderText="Group ID" ReadOnly="True" />
                                <asp:BoundField DataField="TeacherName" HeaderText="Registered By" ReadOnly="True" />
                                <asp:BoundField DataField="RegistrationDate" HeaderText="Registration Date" ReadOnly="True" />
                                <asp:BoundField DataField="Status" HeaderText="Status" ReadOnly="True" />
                            </Columns>
                        </asp:GridView>
                    </div>
                    
                    
                    

                </div>
            </div>
            
            
            
         </div>
     </div>
    
</asp:Content>
