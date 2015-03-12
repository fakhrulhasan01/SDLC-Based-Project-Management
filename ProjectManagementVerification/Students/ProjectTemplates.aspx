<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Student-Master/StudentMaster.Master" CodeBehind="ProjectTemplates.aspx.cs" Inherits="ProjectManagementVerification.Students.ProjectTemplates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="Slide" runat="server">
    <div class="row boxed">
    <form id="form1" runat="server">
        <asp:RadioButtonList ID="radioTemplates" runat="server">  
        </asp:RadioButtonList> 
        <asp:Button runat="server" CssClass="btn btn-circle btn-success" ID="btnSearch" Text="DOWNLOAD" OnClick="btnSearch_Click"/>
    </form>
    </div>
</asp:Content>