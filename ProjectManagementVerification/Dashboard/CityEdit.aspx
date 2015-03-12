<%@ Page Title="" Language="C#" MasterPageFile="~/ViewMaster/DashBoard.Master" AutoEventWireup="true" CodeBehind="CityEdit.aspx.cs" Inherits="ProjectManagementVerification.Dashboard.CityEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    Edit City
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    

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
							        <td valign="middle" class="auto-style1"><b>City Name</b></td>
                                    <td><asp:TextBox  ID="txtCityName" CssClass="form-control adj" runat="server"></asp:TextBox></td>
                                    <td>
                                        <asp:RequiredFieldValidator runat="server" id="ReqdName" ValidationGroup="ReqGroup" controltovalidate="txtCityName"  ForeColor="Red" errormessage="*Enter City Name" />
                                        <asp:RegularExpressionValidator ID="RegFullNamet" ForeColor="Red" runat="server" ControlToValidate="txtCityName"
            ErrorMessage="Enter Valid Name" ValidationExpression="^[a-zA-Z'.\s]{1,50}" ValidationGroup="ReqGroup"></asp:RegularExpressionValidator>
                                    </td>
							    </tr>
                                
                                <tr>
                                    <td><b>Country</b></td>
                                    <td>
                                        <asp:DropDownList ID="ddlCountry" data-rel="chosen" runat="server">
                                                
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator runat="server" id="ReqddlClass" ValidationGroup="ReqGroup" controltovalidate="ddlCountry" InitialValue="Select"  ForeColor="Red" errormessage="*Select Country" />
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td class="auto-style1">
                                        <a href="CityAdd.aspx" title="Back">
                                            <div class="glyphicons-icon circle_arrow_left">
                                            </div>
                                        </a>
                                    </td>
                                    <td><asp:Button ID="btnSave" ValidationGroup="ReqGroup" style="margin-left: 172px" CssClass="btn2 btn-primary" Text="SAVE" runat="server" OnClick="btnSave_Click" /></td>
                                </tr>
                                
							</table>
                            
                        
                            
                            
                            

					</div>
				</div><!--/span-->

			</div><!--/row-->
        
        
        
    
			
			
			
    

	</div><!--/.fluid-container-->
	
			<!-- end: Content -->
    
    
    
    <!--Modal Start-->
    <div class="modal hide fade" id="myModal">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>Settings</h3>
            <asp:TextBox ID="txtId" Visible="True" class="form-control" Width="200" runat="server"></asp:TextBox>
		</div>
		<div class="modal-body">
			<p>Are you sure to delete</p>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal" id="close">Close</a>
			<a class="btn" id="yes">Yes</a>
		</div>
	</div>
    <!--Modal End-->


    

</asp:Content>
