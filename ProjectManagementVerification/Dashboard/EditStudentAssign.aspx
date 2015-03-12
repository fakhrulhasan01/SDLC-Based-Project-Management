<%@ Page Title="" Language="C#" MasterPageFile="~/ViewMaster/Dashboard.Master" AutoEventWireup="true" CodeBehind="EditStudentAssign.aspx.cs" Inherits="ProjectManagementVerification.Dashboard.EditStudentAssign" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    Edit Student Assign
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <div id="content" class="span10">
        <ul class="breadcrumb">
            <li><i class="icon-home"></i><a href="index.html">Home</a> <i class="icon-angle-right"></i></li>
            <li><i class="icon-edit"></i><a href="#">Forms</a> </li>
        </ul>
        <div class="row-fluid sortable">
            <div class="box span12">
                <div class="box-header" data-original-title="">
                    <h2><i class="halflings-icon white edit"></i><span class="break"></span>Edit Assigned Student to Group</h2>
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
                            <asp:DropDownList ID="ddlProjectGroup" data-rel="chosen" runat="server">
                            </asp:DropDownList>
                            <span id="msgProjectGroup"></span>
                        </div>
                    </div>
                    <div class="span12">
                        <div class="span6">
                            <asp:DropDownList CssClass="form-control" ID="ddlStudent"  data-rel="chosen" runat="server">
                            </asp:DropDownList>
                            <span id="msgStudent"></span>
                        </div>
                    </div>
                    <div class="span12">
                        <div class="span6">
                            <asp:DropDownList CssClass="form-control" ID="ddlStatus"  data-rel="chosen" runat="server">
                                <asp:ListItem Text="Active"></asp:ListItem>
                                <asp:ListItem Text="Inactive"></asp:ListItem>
                            </asp:DropDownList>
                            <span id="msgStatus"></span>
                        </div>
                    </div>
                    <div class="span12">
                        <a href="AddStudentToGroup.aspx" data-rel="tooltip" title="" data-original-title="Go Back"><i class="glyphicons-icon circle_arrow_left"></i></a>
                        <asp:Button ID="btnSave" runat="server" CssClass="btn2 btn-primary" OnClick="btnSave_Click" OnClientClick="return valid()" style="margin-left: 128px; margin-top: 6px" Text="SAVE" ValidationGroup="ReqGroup" />
                    </div>
                </div>
            </div>
         </div>
     </div>
    
</asp:Content>
