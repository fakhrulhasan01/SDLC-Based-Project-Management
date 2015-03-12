<%@ Page Title="" Language="C#" MasterPageFile="~/ViewMaster/Dashboard.Master" AutoEventWireup="true" CodeBehind="CreateProjectGroup.aspx.cs" Inherits="ProjectManagementVerification.Dashboard.CreateProjectGroup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    Create Project Group
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        input[type="text"], textarea, select {
            margin-left: 0;
        }
        #msgError {
             margin-left: 3.2%;
        }
    </style>
    
    
    <script>
        var groupIdPattern = /^[a-zA-Z0-9-_,. ]*$/i;
        var groupId;

        var groupDescriptionPattern = /^[a-zA-Z0-9-_,. ]*$/i;
        var groupDescription;

        $(document).ready(function () {



            $('#<%=txtGroupId.ClientID%>').on('input', function (e) {
                $(this).keyup();
            });


            $('#<%=txtGroupDescription.ClientID%>').on('input', function (e) {
                $(this).keyup();
            });



            $("#<%=txtGroupId.ClientID%>").keyup(function () {
                groupId = $(this).val();
                var message;
                if (groupId == "") {
                    message = "";
                }
                else if (!groupIdPattern.test(groupId)) {
                    message = "<font color='red'>Special Characters not allowed</font>";
                } else if (groupId.length < 4) {
                    message = "<font color='red'>Minimum 4 Characters</font>";
                }
                else {
                    message = "<font color='green'>Correct</font>";
                }
                $("#msgGroupId").html(message);
            });



            $("#<%=txtGroupDescription.ClientID%>").keyup(function () {
                groupDescription = $(this).val();
                var message;
                if (!groupDescriptionPattern.test(groupDescription)) {
                    message = "<font color='red'>Special Characters not allowed</font>";
                }else {
                    message = "<font color='green'>Correct</font>";
                }
                $("#msgGroupName").html(message);
            });


        });


        function hi() {
            alert("hi");
            return false;
        }

        function valid() {
            var error = 0;
            var groupIdPattern = /([0-9a-zA-Z.\s])$/;
            var groupId = $("#<%=txtGroupId.ClientID%>").val();
            var groupDescriptionPattern = /([0-9a-zA-Z.\s])$/;
            var groupDescription = $("#<%=txtGroupDescription.ClientID%>").val();
            var groupType = $("#<%=ddlGroupType.ClientID%>").val();

            if (!groupIdPattern.test(groupId) || groupId.length < 4) {
                error++;
            }
            if (!groupDescriptionPattern.test(groupDescription)) {
                error++;
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

    <div id="content" class="span10">
        <ul class="breadcrumb">
            <li><i class="icon-home"></i><a href="index.html">Home</a> <i class="icon-angle-right"></i></li>
            <li><i class="icon-edit"></i><a href="#">Forms</a> </li>
        </ul>
        <div class="row-fluid sortable">
            <div class="box span12">
                <div class="box-header" data-original-title="">
                    <h2><i class="halflings-icon white edit"></i><span class="break"></span>Create Student Group</h2>
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
                            <asp:TextBox ID="txtGroupId" runat="server" CssClass="form-control" placeholder="Enter Group Id"></asp:TextBox>
                            <span id="msgGroupId"></span>
                        </div>
                    </div>
                    <div class="span12">
                        <div class="span6">
                            <asp:TextBox ID="txtGroupDescription" runat="server" TextMode="MultiLine" CssClass="form-control" placeholder="Enter Group Name"></asp:TextBox>
                            <span id="msgGroupName"></span>
                        </div>
                    </div>

                    <div class="span12">
                        <div class="span6">
                            <asp:DropDownList ID="ddlGroupType" runat="server" CssClass="form-control" data-rel="chosen">
                                <asp:ListItem Text="Select Group Type"></asp:ListItem>
                                <asp:ListItem Text="Single"></asp:ListItem>
                                <asp:ListItem Text="Multiple"></asp:ListItem>
                            </asp:DropDownList>
                            <span id="msgGroupType"></span>
                        </div>
                    </div>
                    <div class="span12">
                        <asp:Button ID="btnSave" runat="server" CssClass="btn2 btn-primary" OnClick="btnSave_Click" OnClientClick="return valid()" style="margin-left: 172px" Text="SAVE" ValidationGroup="ReqGroup" />
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
                                        <asp:ImageButton ID="imgDel" runat="server" CausesValidation="false" CommandArgument='<%#Eval("Id")%>' CommandName="Delete" ImageUrl="../assets/img/delete.png" onClientClick="return confirm('Are you sure??')" ToolTip="Delete" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="GroupId" HeaderText="Group ID" ReadOnly="True" />
                                <asp:BoundField DataField="Description" HeaderText="Group Description" ReadOnly="True" />
                                <asp:BoundField DataField="FullName" HeaderText="Teacher Name" ReadOnly="True" />
                                <asp:BoundField DataField="GroupType" HeaderText="Group Type" ReadOnly="True" />
                                <asp:BoundField DataField="Status" HeaderText="Group Status" ReadOnly="True" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
            <!--/span-->

			</div>
        <!--/row-->
        
        
        
        


			
			
			
    

	</div>
    <!--/.fluid-container-->
	
			<!-- end: Content -->
    

</asp:Content>
