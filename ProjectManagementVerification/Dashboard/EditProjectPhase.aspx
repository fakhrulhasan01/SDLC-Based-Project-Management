<%@ Page Title="" Language="C#" MasterPageFile="~/ViewMaster/Dashboard.Master" AutoEventWireup="true" CodeBehind="EditProjectPhase.aspx.cs" Inherits="ProjectManagementVerification.Dashboard.EditProjectPhase" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    Edit Project Phase
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="content" class="span10">
    <style>
        input[type="text"], textarea {
            margin-left: 0;   
        }

        .chzn-results li {
            border: 1px solid #ddd;
            border-bottom: none;
        } 
        .chzn-results li:last-child {
            border: 1px solid #ddd;
        }
    </style>			
    
    <script>
        $(document).ready(function () {
            var projectPhasePattern = /^[a-zA-Z0-9-_,. ]*$/i;
            var projectPhaseName;
            var projectPhaseDescriptionPattern = /^[a-zA-Z0-9-_,. ]*$/i;
            var projectPhaseDescription;

            $("#<%=txtProjectPhaseName.ClientID%>").keyup(function () {
                projectPhaseName = $(this).val();
                var message = "";
                if ((projectPhaseName.length < 3) || (projectPhaseName == "")) {
                    message = "<font color='red'>At least 3 characters required</font>";
                } else if (!projectPhasePattern.test(projectPhaseName)) {
                    message = "<font color='red'>Special Character is not allowed</font>";
                } else {
                    message = "<font color='green'></font>";
                }
                $("#msgProjectPhaseName").html(message);
            });


            $("#<%=txtPhaseDescription.ClientID%>").keyup(function () {
                projectPhaseDescription = $(this).val();
                var message = "";
                if (!projectPhaseDescriptionPattern.test(projectPhaseDescription)) {
                    message = "<font color='red'>Special Character is not allowed</font>";
                } else {
                    message = "<font color='green'>Correct</font>";
                }
                $("#msgPhaseDescription").html(message);
            });


        });


        function valid() {
            var error = 0;
            var projectType = $("#<%=ddlProjectType.ClientID%> option:selected").text();
            var projectPriority = $("#<%=ddlPriority.ClientID%> option:selected").text();

            var projectPhasePattern = /^[a-zA-Z0-9-_,. ]*$/i;
            var projectPhaseName = $("#<%=txtProjectPhaseName.ClientID%>").val();

            var projectPhaseDescriptionPattern = /^[a-zA-Z0-9-_,. ]*$/i;
            var projectPhaseDescription = $("#<%=txtPhaseDescription.ClientID%>").val();


            if (projectType == "Select Project Type") {
                error++;
                $("#msgProjectTypeId").html("<font color='red'>Please Select project type</font>");
            }

            if (projectPriority == "Select Priority") {
                error++;
                $("#msgPriority").html("<font color='red'>Please Select priority</font>");
            }

            if (!projectPhasePattern.test(projectPhaseName)) {
                error++;
                $("#msgProjectPhaseName").html("<font color='red'>Special Character is not allowed</font>");
            } else if (projectPhaseName.length < 3) {
                error++;
                $("#msgProjectPhaseName").html("<font color='red'>Minimum 3 characters required</font>");
            }

            if (!projectPhaseDescriptionPattern.test(projectPhaseDescription)) {
                error++;
                $("#msgPhaseDescription").html("<font color='red'>Special Characters is not allowed</font>");
            }
            if (error > 0) {
                return false;
            } else {
                return true;
            }

        }


    </script>
			
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
						<h2><i class="halflings-icon white edit"></i><span class="break"></span>Add Country</h2>
						<div class="box-icon">
							<a href="#" class="btn-setting"><i class="halflings-icon white wrench"></i></a>
							<a href="#" class="btn-minimize"><i class="halflings-icon white chevron-up"></i></a>
							<a href="#" class="btn-close"><i class="halflings-icon white remove"></i></a>
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
                            <div>Change Project Type</div>
                            <asp:DropDownList ID="ddlProjectType" data-rel="chosen" runat="server">
                            </asp:DropDownList>
                            <span id="msgProjectTypeId"></span>
                        </div>
                    </div>
                    <div class="span12">
                        <div class="span6">
                            <div>Project Phase Name</div>
                            <asp:TextBox ID="txtProjectPhaseName" runat="server" CssClass="form-control" placeholder="Enter Project Phase Name"></asp:TextBox>
                            <span id="msgProjectPhaseName"></span>
                        </div>
                    </div>
                    <div class="span12">
                        <div class="span6">
                            <div>Project Phase Description</div>
                            <asp:TextBox ID="txtPhaseDescription" runat="server" TextMode="MultiLine" CssClass="form-control" placeholder="Write Phase Description"></asp:TextBox>
                            <span id="msgPhaseDescription"></span>
                        </div>
                    </div>
                    <div class="span12">
                        <div class="span6">
                            <div>Change Priority</div>
                            <asp:DropDownList ID="ddlPriority" data-rel="chosen" runat="server">
                                <asp:ListItem Text="Select Priority"></asp:ListItem>
                                <asp:ListItem Text="First" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Second" Value="2"></asp:ListItem>
                                <asp:ListItem Text="Third" Value="3"></asp:ListItem>
                                <asp:ListItem Text="Fourth" Value="4"></asp:ListItem>
                                <asp:ListItem Text="Fifth" Value="5"></asp:ListItem>
                            </asp:DropDownList>
                            <span id="msgPriority"></span>
                        </div>
                    </div>
                    <div class="span12">
                        <a data-original-title="Go Back" data-rel="tooltip" href="ProjectPhaseAdd.aspx"><i class="glyphicons-icon circle_arrow_left"></i></a>
                        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" OnClientClick="return valid()" style="margin-left: 128px;" Text="SAVE" ValidationGroup="ReqGroup" />
                    </div>
                    
                    
                </div>
                    
                    

				</div><!--/span-->

			</div><!--/row-->
        
        

	</div><!--/.fluid-container-->
	
	<!-- end: Content -->
        
</asp:Content>
