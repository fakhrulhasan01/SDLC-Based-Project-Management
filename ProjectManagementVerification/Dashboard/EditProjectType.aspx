<%@ Page Title="" Language="C#" MasterPageFile="../ViewMaster/Dashboard.Master" AutoEventWireup="true" CodeBehind="EditProjectType.aspx.cs" Inherits="ProjectManagementVerification.Dashboard.EditProjectType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    Edit Project Type
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        input[type="text"], textarea {
            margin-left: 0;
        }

        textarea {
             -webkit-transition: all 0.7s ease;
            transition: all 0.7s ease;
        }

        textarea:focus {
            width: 300px; 
        }

         .hideGridColumn {
             display: none
         }
    </style>    
    

    <script>
        var projectTypePattern = /^[a-zA-Z0-9-_,. ]*$/i;
        var projectType;

        var projectTypeDescriptionPattern = /^[a-zA-Z0-9-_,. ]*$/i;
        var projectTypeDescription;

        $(document).ready(function () {

           

            $('#<%=txtProjectTypeName.ClientID%>').on('input', function (e) {
                $(this).keyup();
            });


            $('#<%=txtProjectTypeDescription.ClientID%>').on('input', function (e) {
                $(this).keyup();
            });



            $("#<%=txtProjectTypeName.ClientID%>").keyup(function () {
                projectType = $(this).val();
                var message;
                if (projectType == "") {
                    message = "";
                }
                else if (!projectTypePattern.test(projectType)) {
                    message = "<font color='red'>Special Characters not allowed</font>";
                } else if (projectType.length < 4) {
                    message = "<font color='red'>Minimum 4 Characters</font>";
                }
                else {
                    message = "<font color='green'>Correct</font>";
                }
                $("#msgProjectTypeName").html(message);
            });



            $("#<%=txtProjectTypeDescription.ClientID%>").keyup(function () {
                projectTypeDescription = $(this).val();
                var message;
                if (!projectTypeDescriptionPattern.test(projectTypeDescription)) {
                    message = "<font color='red'>Special Characters not allowed</font>";
                } else {
                    message = "<font color='green'>Correct</font>";
                }
                $("#msgProjectTypeDescription").html(message);
            });


        });


        function hi() {
            alert("hi");
            return false;
        }

        function valid() {
            var error = 0;
            var projectTypePattern = /([0-9a-zA-Z.\s])$/;
            var projectType = $("#<%=txtProjectTypeName.ClientID%>").val();

            var projectTypeDescriptionPattern = /([0-9a-zA-Z.\s])$/;
            var projectTypeDescription = $("#<%=txtProjectTypeDescription.ClientID%>").val();


            if (!projectTypePattern.test(projectType) || projectType.length < 4) {
                var message;
                if (projectType == "") {
                    message = "<font color='red'>Can't leave this field blank</font>";
                }
                else if (!projectTypePattern.test(projectType)) {
                    message = "<font color='red'>Special Characters not allowed</font>";
                } else if (projectType.length < 4) {
                    message = "<font color='red'>Minimum 4 Characters</font>";
                }
                $("#msgProjectTypeName").html(message);
                error++;
            }

            else if (projectTypeDescription.val() == "") {

            } else if (!projectTypeDescriptionPattern.test(projectTypeDescription)) {
                $("#msgProjectTypeDescription").html("<font color='red'>Special Characters is not allowed</font>");
                error++;
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
                            <div>Project Type Name</div>
                            <asp:TextBox ID="txtProjectTypeName" runat="server" CssClass="form-control" placeholder="Enter Project Type Name"></asp:TextBox>
                            <span id="msgProjectTypeName"></span>
                        </div>
                    </div>
                    <div class="span12">
                        <div class="span6">
                            <div>Project Type Description</div>
                            <asp:TextBox ID="txtProjectTypeDescription" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" placeholder="Write some description about project type"></asp:TextBox>
                            <span id="msgProjectTypeDescription"></span>
                        </div>
                    </div>

                    <div class="span12">
                        <a href="ProjectTypeAdd.aspx" data-rel="tooltip" title="" data-original-title="Go Back"><i class="glyphicons-icon circle_arrow_left"></i></a>
                        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" OnClientClick="return valid()" style="margin-left: 128px;" Text="SAVE" ValidationGroup="ReqGroup" />
                    </div>
                    

                </div>
                    
                    

				</div><!--/span-->

			</div><!--/row-->
        
        
        
    
			
			
			
    

	</div><!--/.fluid-container-->
	
			<!-- end: Content -->
    
</asp:Content>
