<%@ Page Title="" Language="C#" MasterPageFile="~/UI-Master/UIMaster.Master" AutoEventWireup="true" CodeBehind="ViewProjectDetails.aspx.cs" Inherits="ProjectManagementVerification.View.ViewProjectDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Main" runat="server">
    <style>
        .description h1, h2, h3, h4, h5, h6, p, b{
            font-family: 'Times New Roman', Georgia, Serif;
        }
    </style>
    <div class="row boxed">
        <form id="form1" runat="server">
        <h1 runat="server" ID="projectTitle"></h1>
        <div runat="server" ID="tableOfContent">
            
        </div> 
            
            
        <div runat="server" ID="tableDescription" class="description">
            
        </div>
            
            
            <embed style="width: 80%; min-height: 600px" name='plugin' src="../ProjectFiles/mPTI5wb1fgtvEkDesignReport.pdf" type='application/pdf'>
        </form>
    </div>
</asp:Content>
