<%@ Page Title="" Language="C#" MasterPageFile="~/ViewMaster/Dashboard.Master" AutoEventWireup="true" CodeBehind="EditStudentGroup.aspx.cs" Inherits="ProjectManagementVerification.Dashboard.EditStudentGroup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    Edit Student Group
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<style type="text/css">
        input[type="text"], select {
            margin-left: 0;
        }
        .left-text {
            text-align: left;
        }

        
        
    </style>
    
    <script>
        $(document).ready(function () {
            $("#extendedSearchSection").hide();


            var groupIdPattern = /([0-9a-zA-Z-.\s])$/;
            var groupId;

            var groupNamePattern = /([0-9a-zA-Z-.\s])$/;
            var groupName;


            $('#<%=txtGroupId.ClientID%>').on('input', function (e) {
                $(this).keyup();
            });


            $('#<%=txtGroupName.ClientID%>').on('input', function (e) {
                $(this).keyup();
            });



            $("#<%=txtGroupId.ClientID%>").keyup(function () {
                groupId = $(this).val();
                var message;
                if (!groupIdPattern.test(groupId)) {
                    message = "<font color='red'>Special Characters not allowed</font>";
                } else if (groupId.length < 4) {
                    message = "<font color='red'>Minimum 4 Characters</font>";
                }
                else {
                    message = "<font color='green'>Correct</font>";
                }
                $("#msgGroupId").html(message);
            });


            $("#<%=txtGroupName.ClientID%>").keyup(function () {
                groupName = $(this).val();
                var message;
                if (!groupNamePattern.test(groupName)) {
                    message = "<font color='red'>Special Characters not allowed</font>";
                } else if (groupName.length < 4) {
                    message = "<font color='red'>Minimum 4 Characters</font>";
                }
                else {
                    message = "<font color='green'>Correct</font>";
                }
                $("#msgGroupName").html(message);
            });


            $("#clExtencedSearch").click(function () {
                if ($(this).text() == "Extended Search") {
                    $(this).text("Hide");
                    $("#extendedSearchSection").fadeIn(1000);
                } else {
                    $(this).text("Extended Search");
                    $("#extendedSearchSection").fadeOut(1000);
                }

            });


        });



        function validate() {
            var error = 0;
            var groupIdPattern = /([0-9a-zA-Z.\s])$/;
            var groupId = $("#<%=txtGroupId.ClientID%>").val();
            var student = $("#<%=ddlStudent.ClientID%>").val();
            var groupNamePattern = /([0-9a-zA-Z.\s])$/;
            var groupName = $("#<%=txtGroupName.ClientID%>").val();
            var groupType = $("#<%=ddlGroupType.ClientID%>").val();

            if (!groupIdPattern.test(groupId) || groupId.length < 4) {
                error++;
            }
            if (!groupNamePattern.test(groupName) || groupName.length < 4) {
                error++;
            }

            if ((student == "Select Students") || student == "No Approved Students") {
                error++;
                if (student == "Select Students") {
                    $("#msgStudents").html("<font color='red'>Please select a student</font>");
                } else {
                    $("#msgStudents").html("<font color='red'>Sorry! No approved students</font>");
                }
            }

            if (groupType == "Select Group Type") {
                error++;
                $("#msgGroupType").html("<font color='red'>Please select group type</font>");
            }

            if (error == 0) {
                return true;
            } else {
                $("#msgError").html("<font color='red'>Please correct the errors</font>");
                return false;
            }

        }
    </script>

    <!-- start: Content -->
    <div id="content" class="span10">
			
			
			<ul class="breadcrumb">
				<li>
					<i class="icon-home"></i>
					<a href="index.html">Home</a>
					<i class="icon-angle-right"></i> 
				</li>
				<li>
					<i class="icon-edit"></i>
					<a href="#">Forms</a>
				</li>
			</ul>
			
			<div class="row-fluid sortable">
				<div class="box span12">
					<div class="box-header" data-original-title>
						<h2><i class="halflings-icon white edit"></i><span class="break"></span>Create Student Group</h2>
						<div class="box-icon">
							<a href="#" class="btn-setting"><i class="halflings-icon white wrench"></i></a>
							<a href="#" class="btn-minimize"><i class="halflings-icon white chevron-up"></i></a>
							<a href="#" class="btn-close"><i class="halflings-icon white remove"></i></a>
						</div>
					</div>

					<div class="box-content">
							<div class="span12">
							    <div id="msgError"><asp:Label ID="lblMessage" runat="server"></asp:Label></div>
							</div>
                            <div class="span12">
                                <div class="span6">
                                    <asp:TextBox ID="txtGroupId" placeholder="Enter Group Id" CssClass="form-control" runat="server"></asp:TextBox>
                                    <span id="msgGroupId"></span>
                                </div>
                            </div>
                        
                            <div class="span12">
                                <div class="span6">
                                    <asp:TextBox ID="txtGroupName" placeholder="Enter Group Name" CssClass="form-control" runat="server"></asp:TextBox>
                                    <span id="msgGroupName"></span>
                                </div>
                            </div>
                        
                        
                            <div class="span12">
                                <div class="span6">
                                        <asp:DropDownList CssClass="form-control" ID="ddlStudent"  data-rel="chosen" runat="server">
                                            
                                        </asp:DropDownList>
                                        <span id="msgStudents">
                                            
                                        </span>                                     
                                </div>
                            </div>
                        
                        
                            <div class="span12">
                                <div class="span6">
                                        <asp:DropDownList CssClass="form-control" ID="ddlGroupType"  data-rel="chosen" runat="server">
                                            <asp:ListItem Text="Single"></asp:ListItem>
                                            <asp:ListItem Text="Multiple"></asp:ListItem>
                                        </asp:DropDownList>
                                        <span id="msgGroupType">
                                            
                                        </span>                                     
                                </div>
                            </div>
                        
                        

                            <div class="span12">
                                <asp:Button ID="btnSave" style="margin-left: 172px" CssClass="btn2 btn-primary" ValidationGroup="ReqGroup" Text="SAVE" runat="server" OnClientClick="return validate()" OnClick="btnSave_Click"/>
                            </div>
                        

                           						
                        
                        
                            

               	</div>
				</div><!--/span-->

			</div><!--/row-->
        
    

	</div><!--/.fluid-container-->
	
    
</asp:Content>
