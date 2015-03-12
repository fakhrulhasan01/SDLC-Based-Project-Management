﻿<%@ Page Title="" Language="C#" MasterPageFile="~/ViewMaster/DashBoard.Master" AutoEventWireup="true" CodeBehind="CountryEdit.aspx.cs" Inherits="ProjectManagementVerification.Dashboard.CountryEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    Edit Country
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
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
					    
							<table>
							    <tr>
							        <td colspan="3">
							            <asp:Label ID="lblMessage" runat="server"></asp:Label>
							        </td>    
							    </tr>

							    <tr>
							        <td valign="middle" class="auto-style1"><b>Country Name</b></td>
                                    <td><asp:TextBox  ID="txtCountryName" CssClass="form-control" runat="server"></asp:TextBox></td>
                                    <td>
                                        <asp:RequiredFieldValidator runat="server" id="ReqdName" ValidationGroup="ReqGroup" controltovalidate="txtCountryName"  ForeColor="Red" errormessage="*" />
                                        <asp:RegularExpressionValidator ID="RegFullNamet" ForeColor="Red" runat="server" ControlToValidate="txtCountryName"
            ErrorMessage="Enter Valid Name" ValidationExpression="^[a-zA-Z'.\s]{1,50}" ValidationGroup="ReqGroup"></asp:RegularExpressionValidator>
                                    </td>
							    </tr>
                                
                                <tr>
                                    <td class="auto-style1"></td>
                                    <td><asp:Button ID="btnSave" ValidationGroup="ReqGroup" style="margin-left: 172px" CssClass="btn2 btn-primary" Text="SAVE" runat="server" OnClick="btnSave_Click" /></td>
                                </tr>
                                
							</table>
                            
                    </div>
                    <!--End of Box Content-->
            </div>
            <!--End of Box Span-->
        </div>
        <!--End of Fluid Sortable-->

    </div>

</asp:Content>