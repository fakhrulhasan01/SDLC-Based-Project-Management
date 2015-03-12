<%@ Page Title="" Language="C#" MasterPageFile="~/ViewMaster/Dashboard.Master" AutoEventWireup="true" CodeBehind="EditProjectGroup.aspx.cs" Inherits="ProjectManagementVerification.Dashboard.EditProjectGroup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    Edit Project Group
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        input[type="text"], textarea, select {
            margin-left: 0;
        }
    </style>
    
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
                            <div>Group Id</div>
                            <asp:TextBox ID="txtGroupId" runat="server" CssClass="form-control" placeholder="Enter Group Id"></asp:TextBox>
                            <span id="msgGroupId"></span>
                        </div>
                    </div>
                    <div class="span12">
                        <div class="span6">
                            <div>Group Description</div>
                            <asp:TextBox ID="txtGroupDescription" runat="server" TextMode="MultiLine" CssClass="form-control" placeholder="Write Description"></asp:TextBox>
                            <span id="msgGroupName"></span>
                        </div>
                    </div>

                    <div class="span12">
                        <div class="span6">
                            <div>Group Type</div>
                            <asp:DropDownList ID="ddlGroupType" runat="server" CssClass="form-control" data-rel="chosen">
                                <asp:ListItem Text="Select Group Type"></asp:ListItem>
                                <asp:ListItem Text="Single"></asp:ListItem>
                                <asp:ListItem Text="Multiple"></asp:ListItem>
                            </asp:DropDownList>
                            <span id="msgGroupType"></span>
                        </div>
                    </div>
                    <div class="span12">
                        <a href="CreateProjectGroup.aspx" data-rel="tooltip" title="Go Back"><i class="glyphicons-icon circle_arrow_left"></i></a>
                        <asp:Button ID="btnSave" runat="server" CssClass="btn2 btn-primary" OnClick="btnSave_Click" OnClientClick="return validate()" style="margin-left: 128px; margin-top: 6px" Text="SAVE" ValidationGroup="ReqGroup" />
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
