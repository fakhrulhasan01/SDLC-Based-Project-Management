<%@ Page Language="C#" MasterPageFile="../ViewMaster/DashBoard.Master" AutoEventWireup="true" CodeBehind="ProductsEdit.aspx.cs" Inherits="ProjectManagementVerification.Dashboard.ProductsEdit" %>

<asp:Content ID="Head" ContentPlaceHolderID="head" runat="server">
        Product Add
</asp:Content>
<asp:Content ID="Body" ContentPlaceHolderID="MainContent" runat="server">
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
						<h2><i class="halflings-icon white edit"></i><span class="break"></span>Create Products</h2>
						<div class="box-icon">
							<a href="#" class="btn-setting"><i class="halflings-icon white wrench"></i></a>
							<a href="#" class="btn-minimize"><i class="halflings-icon white chevron-up"></i></a>
							<a href="#" class="btn-close"><i class="halflings-icon white remove"></i></a>
						</div>
					</div>

					<div class="box-content">
					        <table>
					            <tr>
					                <td colspan="2"><asp:Label ID="lblMessage" runat="server"></asp:Label></td>  
					            </tr>

							    <tr>
							        <td>Product Name</td>
                                    <td><asp:TextBox ID="txtProductName" CssClass="form-control" runat="server"></asp:TextBox></td>
							    </tr>
                                
							    <tr>
							        <td>Product Price</td>
                                    <td><asp:TextBox ID="txtProductPrice" CssClass="form-control" runat="server"></asp:TextBox></td>
							    </tr>
                                
                                <tr>
                                    <td>Product Quantity</td>
                                    <td>
                                        <div class="controls">
                                            <asp:TextBox ID="txtProductQuantity" CssClass="form-control" runat="server"></asp:TextBox> 
                                        </div>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td><a title="Back" href="ProductsAdd.aspx"><div class="glyphicons-icon circle_arrow_left"></div></a></td>
                                    <td><asp:Button ID="btnUpdate" style="margin-left: 150px" CssClass="btn2 btn-primary" Text="UPDATE" runat="server" OnClick="btnUpdate_Click"/></td>
                                </tr>
							</table>
                            
                        
                            <div class="search_section">
                                <div class="right_alignment">
                                        <asp:TextBox ID="txtSearch" CssClass="marg" runat="server"></asp:TextBox>
                                        <asp:Button ID="btnSearch" CssClass="btn btn-default right" Text="SEARCH" runat="server"/>
                                </div>
                            </div>    						
                            
                            <div class="search_section">
                            </div>    


					</div>
				</div><!--/span-->

			</div><!--/row-->
        
        
        
        


			
			
			
    

	</div><!--/.fluid-container-->
	
			<!-- end: Content -->
</asp:Content>

