<%@ Page Title="" Language="C#" MasterPageFile="../ViewMaster/Dashboard.Master" AutoEventWireup="true" CodeBehind="ProjectTypeAdd.aspx.cs" Inherits="ProjectManagementVerification.Dashboard.ProjectTypeAdd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <style>
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

            $("#<%=GridView1.ClientID%> td").click(function() {
                if ($(this).index() == 1) {
                    $("#<%=txtModifyId.ClientID%>").val($(this).next().text());
                }
            });

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
                }else {
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

            }else if (!projectTypeDescriptionPattern.test(projectTypeDescription)) {
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
                            <asp:TextBox ID="txtProjectTypeName" runat="server" CssClass="form-control" placeholder="Enter Project Type Name"></asp:TextBox>
                            <span id="msgProjectTypeName"></span>
                        </div>
                    </div>
                    <div class="span12">
                        <div class="span6">
                            <asp:TextBox ID="txtProjectTypeDescription" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" placeholder="Write some description about project type"></asp:TextBox>
                            <span id="msgProjectTypeDescription"></span>
                        </div>
                    </div>

                    <div class="span12">
                        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" OnClick="btnSave_Click" OnClientClick="return valid()" style="margin-left: 182px;" Text="SAVE" ValidationGroup="ReqGroup" />
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

                    <div class="span12" style="margin-left: 0">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" PageSize="3" AllowPaging="true"
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
                                        <asp:ImageButton ID="imgDel" CssClass="btn-setting" runat="server" CausesValidation="false" CommandArgument='<%#Eval("Id")%>' CommandName="Delete" ImageUrl="../assets/img/delete.png"  ToolTip="Delete" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="Id" HeaderText="Id" HeaderStyle-CssClass = "hideGridColumn" ItemStyle-CssClass="hideGridColumn"/>
                                <asp:BoundField DataField="Name" HeaderText="Project Type Name"/>
                                <asp:BoundField DataField="Description" HeaderText="Description"/>
                            </Columns>
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
			<asp:Button ID="btnDelete" Text="Delete" CssClass="btn btn-action btn-info" runat="server" OnClick="btnDelete_Click"/>
			<a href="#" class="btn" data-dismiss="modal" id="close">Close</a>
		</div>
	</div>
    <!--Modal End-->


</asp:Content>
