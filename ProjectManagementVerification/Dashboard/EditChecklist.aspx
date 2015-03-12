<%@ Page Title="" Language="C#" MasterPageFile="~/ViewMaster/Dashboard.Master" AutoEventWireup="true" CodeBehind="EditChecklist.aspx.cs" Inherits="ProjectManagementVerification.Dashboard.EditChecklist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    Edit Checklist</asp:Content>

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
            var checklistNamePattern = /^[a-zA-Z0-9-_,. ]*$/i;
            var checklistName;
            var checklistDescriptionPattern = /^[a-zA-Z0-9-_,. ]*$/i;
            var checklistDescription;

            $("#<%=txtChecklistName.ClientID%>").keyup(function () {
                checklistName = $(this).val();
                var message = "";
                if ((checklistName.length < 3) || (checklistName == "")) {
                    message = "<font color='red'>At least 3 characters required</font>";
                } else if (!checklistNamePattern.test(checklistName)) {
                    message = "<font color='red'>Special Character is not allowed</font>";
                } else {
                    message = "<font color='green'>Correct</font>";
                }
                $("#msgChecklistName").html(message);
            });


            $("#<%=txtChecklistDescription.ClientID%>").keyup(function () {
                checklistDescription = $(this).val();
                var message = "";
                if (!checklistDescriptionPattern.test(checklistDescription)) {
                    message = "<font color='red'>Special Character is not allowed</font>";
                } else {
                    if (checklistDescription != "") {
                        message = "<font color='green'>Correct</font>";
                    }
                }
                $("#msgChecklistDescription").html(message);
            });

            $("#<%=ddlStatus.ClientID%>").hover(function () {

            });
        });


        function valid() {
            var error = 0;
            var projectPhase = $("#<%=ddlProjectPhase.ClientID%> option:selected").text();
            var checklistType = $("#<%=ddlChecklistType.ClientID%> option:selected").text();

            var projectPhasePattern = /^[a-zA-Z0-9-_,. ]*$/i;
            var checklistName = $("#<%=txtChecklistName.ClientID%>").val();

            var checklistDescriptionPattern = /^[a-zA-Z0-9-_,. ]*$/i;
            var checklistDescription = $("#<%=txtChecklistDescription.ClientID%>").val();


            if (projectPhase == "Select Project Phase") {
                error++;
                $("#msgProjectTypeId").html("<font color='red'>Please Select project type</font>");
            }

            if (checklistType == "Select Checklist Type") {
                error++;
                $("#msgChecklistType").html("<font color='red'>Please Select priority</font>");
            }

            if (!projectPhasePattern.test(checklistName)) {
                error++;
                $("#msgChecklistName").html("<font color='red'>Special Character is not allowed</font>");
            } else if (checklistName.length < 3) {
                error++;
                $("#msgChecklistName").html("<font color='red'>Minimum 3 characters required</font>");
            }

            if (!checklistDescriptionPattern.test(checklistDescription)) {
                error++;
                $("#msgChecklistDescription").html("<font color='red'>Special Characters is not allowed</font>");
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
						<h2><i class="halflings-icon white edit"></i><span class="break"></span>Edit Checklist</h2>
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
                            <asp:DropDownList ID="ddlProjectPhase" data-rel="chosen" runat="server">
                            </asp:DropDownList>
                            <span id="msgProjectPhase"></span>
                        </div>
                    </div>
                    <div class="span12">
                        <div class="span6">
                            <asp:TextBox ID="txtChecklistName" runat="server" CssClass="form-control" placeholder="Write Checklist Name"></asp:TextBox>
                            <span id="msgChecklistName"></span>
                        </div>
                    </div>
                    <div class="span12">
                        <div class="span6">
                            <asp:TextBox ID="txtChecklistDescription" runat="server" TextMode="MultiLine" CssClass="form-control" placeholder="Write Description about checklist"></asp:TextBox>
                            <span id="msgChecklistDescription"></span>
                        </div>
                    </div>

                    <div class="span12">
                        <div class="span6">
                               <asp:DropDownList  ID="ddlStatus" data-rel="tooltip" ToolTip="Select Status" runat="server">
                                    <asp:ListItem Text="Active"></asp:ListItem>
                                    <asp:ListItem Text="Inactive"></asp:ListItem>
                                </asp:DropDownList>
                                <span id="msgStatus"></span>
                        </div>
                    </div>

                    
                    <div class="span12">
                        <div class="span6">
                            <asp:DropDownList ID="ddlChecklistType" data-rel="chosen" runat="server">
                                <asp:ListItem Text="Select Checklist Type"></asp:ListItem>
                                <asp:ListItem Text="Mandatory"></asp:ListItem>
                                <asp:ListItem Text="Optional"></asp:ListItem>
                            </asp:DropDownList>
                            <span id="msgChecklistType"></span>
                        </div>
                    </div>
                    
                    <div class="span12">
                        <a href="ChecklistAdd.aspx" data-rel="tooltip" title="" data-original-title="Go Back"><i class="glyphicons-icon circle_arrow_left"></i></a>
                        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" OnClientClick="return valid()" style="margin-left: 130px;" Text="SAVE" ValidationGroup="ReqGroup" />
                    </div>
                    
                    
                    
                </div>
                    
                    

				</div><!--/span-->

			</div><!--/row-->
        
        

	</div><!--/.fluid-container-->
	
			<!-- end: Content -->
    

    
    
    <!--Modal Start-->
    <div class="modal hide fade" id="myModal">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			
            <h3><i class="glyphicons-icon warning_sign" style="margin-left: 6px; margin-top: -8px"></i> Confirmation</h3>
            
		</div>
		<div class="modal-body">
			<p>Are you sure to delete</p>
		</div>
		<div class="modal-footer">

			<a href="#" class="btn" data-dismiss="modal" id="close">Close</a>
		</div>
	</div>
    <!--Modal End-->
</asp:Content>
