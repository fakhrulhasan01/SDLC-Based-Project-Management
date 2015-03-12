l<%@ Page Title="" Language="C#" MasterPageFile="~/ViewMaster/Dashboard.Master" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="ProjectPhaseAdd.aspx.cs" Inherits="ProjectManagementVerification.Dashboard.ProjectPhaseAdd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    Add Project Phase
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
                }else if (!projectPhasePattern.test(projectPhaseName)) {
                    message = "<font color='red'>Special Character is not allowed</font>";
                } else {
                    message = "<font color='green'>Correct</font>";
                }
                $("#msgProjectPhaseName").html(message);
            });


            $("#<%=txtPhaseDescription.ClientID%>").keyup(function () {
                projectPhaseDescription = $(this).val();
                var message = "";
                if (!projectPhaseDescriptionPattern.test(projectPhaseDescription)) {
                    message = "<font color='red'>Special Character is not allowed</font>";
                } else {
                    if (projectPhaseDescription != "") {
                        message = "<font color='green'>Correct</font>";
                    }
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
						<h2><i class="halflings-icon white edit"></i><span class="break"></span>Add Project Phases</h2>
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
                            <asp:DropDownList ID="ddlProjectType" data-rel="chosen" runat="server">
                            </asp:DropDownList>
                            <span id="msgProjectTypeId"></span>
                        </div>
                    </div>
                    <div class="span12">
                        <div class="span6">
                            <asp:TextBox ID="txtProjectPhaseName" runat="server" CssClass="form-control" placeholder="Enter Project Phase Name"></asp:TextBox>
                            <span id="msgProjectPhaseName"></span>
                        </div>
                    </div>
                    <div class="span12">
                        <div class="span6">
                            <asp:TextBox ID="txtPhaseDescription" runat="server" TextMode="MultiLine" CssClass="form-control" placeholder="Write Phase Description"></asp:TextBox>
                            <span id="msgPhaseDescription"></span>
                        </div>
                    </div>
                    <div class="span12">
                        <div class="span6">
                            <asp:DropDownList ID="ddlPriority" data-rel="chosen" runat="server">
                                <asp:ListItem Text="Select Priority"></asp:ListItem>
                                <asp:ListItem Text="First" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Second" Value="2"></asp:ListItem>
                                <asp:ListItem Text="Third" Value="3"></asp:ListItem>
                                <asp:ListItem Text="Fourth" Value="4"></asp:ListItem>
                                <asp:ListItem Text="Fifth" Value="5"></asp:ListItem>
                                <asp:ListItem Text="Sixth" Value="6"></asp:ListItem>
                            </asp:DropDownList>
                            <span id="msgPriority"></span>
                        </div>
                    </div>
                    <div class="span12">
                        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" OnClientClick="return valid()" style="margin-left: 172px;" Text="SAVE" ValidationGroup="ReqGroup" />
                    </div>
                    <div class="span12">
                        <div class="span11">
                            <span style="margin:auto; float: right">
                                <asp:TextBox ID="txtModifyId" runat="server" style="display:none"></asp:TextBox>
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="marg"></asp:TextBox>
                                <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-default" OnClick="btnSearch_Click" Text="SEARCH" />
                                <asp:Button ID="btnSearchAll" runat="server" CssClass="btn btn-default" OnClick="btnSearchAll_Click" Text="SEARCH ALL" />
                            </span>
                        </div>
                    </div>

                    
                    <div class="search_section">
                        

                            <asp:GridView ID="GridView1" PageSize="6" AllowPaging="true" AutoGenerateColumns="false" 
                                PagerStyle-CssClass="paging" class="table table-hover table-bordered" DataKeyNames="Id" runat="server" 
                                OnPageIndexChanging="GridView1_PageIndexChanging" OnRowEditing="GridView1_RowEditing" OnRowDeleting="GridView1_RowDeleting" >
                                    <Columns>
                                       <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Edit" ItemStyle-Width="30px">
                                            <ItemTemplate>
                                                <asp:ImageButton Text="Hi" ID="imgEdit" runat="server" CausesValidation="false"                                      
                                                    CommandArgument = '<%#Eval("Id")%>'
                                                    CommandName="Edit" data-rel="tooltip"
                                                    ImageUrl="../assets/img/edit.png"                                                         
                                                    ToolTip="Edit" />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                       
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Delete" ItemStyle-Width="30px">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgDel" runat="server" CausesValidation="false"                                      
                                                    CommandArgument = '<%#Eval("Id")%>' onClientClick="return confirm('Are you sure??')"
                                                    CommandName="Delete" ImageUrl="../assets/img/delete.png"  data-rel="tooltip"                                                         
                                                    ToolTip="Delete"></asp:ImageButton>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>

                                        <asp:BoundField ReadOnly="True" DataField="ProjectTypeName" HeaderText="Project Type Name" />
                                        <asp:BoundField ReadOnly="True" DataField="PhaseName" HeaderText="Project Phase Name" />
                                        <asp:BoundField ReadOnly="True" DataField="PhaseDescription" HeaderText="Description" />
                                        
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Delete" ItemStyle-Width="30px">
                                            <ItemTemplate>
                                                    <%# Eval("Priority").ToString()=="1"?"First"
                                                           :Eval("Priority").ToString()=="2"?"Second" 
                                                               :Eval("Priority").ToString()=="3"?"Third"
                                                                   :Eval("Priority").ToString()=="4"?"Fourth"
                                                                       :Eval("Priority").ToString()=="5"?"Fifth":"" %>
                                                
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        
                                        <asp:BoundField ReadOnly="True" DataField="CreationDate" HeaderText="Creation Date" />
                                        
                                    </Columns>
                                    <PagerStyle BackColor="#EAEAEA" ForeColor="Black" HorizontalAlign="Left" Font-Size="Large"  />
                                    <HeaderStyle BackColor="" ForeColor=""></HeaderStyle>
                                </asp:GridView>         
                    
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
