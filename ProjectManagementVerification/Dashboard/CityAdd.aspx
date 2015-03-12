<%@ Page Title="" Language="C#" MasterPageFile="~/ViewMaster/DashBoard.Master" AutoEventWireup="true" CodeBehind="CityAdd.aspx.cs" Inherits="ProjectManagementVerification.Dashboard.CityAdd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    Add City
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <script>


        $(document).ready(function () {

        });
    </script>
    <style type="text/css">
        .adj {
            margin-left:0px
        }
         .paging
         {
            
         }
        
        .paging a
        {
            background-color: #00C157;
            padding: 2px 7px;
            margin-left: -10px;
            text-decoration: none;
            border: 1px solid #00C157;
        }

         
        .paging a:hover
        {
            background-color: #E1FFEF;
            color: #00C157;
            border: 1px solid #00C157;
        }

         
        .paging span
        {
            background-color: #E1FFEF;
            padding: 2px 7px;
            color: #00C157;
            border: 1px solid #00C157;
        }

         
        tr.paging
        {
            background: none !important;
            border-left: 1px #dddddd solid;
        }

         
        tr.paging tr
        {
            background: none !important;
            
        }

        tr.paging td
        {
            border: none;
            
        }

        .auto-style1 {
            width: 90px;
        }
    </style>
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
							        <td valign="middle" class="auto-style1"><b>City Name</b></td>
                                    <td><asp:TextBox  ID="txtCityName" CssClass="form-control adj" runat="server"></asp:TextBox></td>
                                    <td>
                                        <asp:RequiredFieldValidator runat="server" id="ReqdName" ValidationGroup="ReqGroup" controltovalidate="txtCityName"  ForeColor="Red" errormessage="*Enter City Name" />
                                        <asp:RegularExpressionValidator ID="RegFullNamet" ForeColor="Red" runat="server" ControlToValidate="txtCityName"
            ErrorMessage="Enter Valid Name" ValidationExpression="^[a-zA-Z'.\s]{1,50}" ValidationGroup="ReqGroup"></asp:RegularExpressionValidator>
                                    </td>
							    </tr>
                                
                                <tr>
                                    <td class="auto-style1"><b>Country</b></td>
                                    <td>
                                        <asp:DropDownList ID="ddlCountry" data-rel="chosen" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:RequiredFieldValidator runat="server" id="ReqddlClass" ValidationGroup="ReqGroup" controltovalidate="ddlCountry" InitialValue="Select"  ForeColor="Red" errormessage="*Select Class" />
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td class="auto-style1"></td>
                                    <td><asp:Button ID="btnSave" ValidationGroup="ReqGroup" style="margin-left: 172px" CssClass="btn2 btn-primary" Text="SAVE" runat="server" OnClick="btnSave_Click" /></td>
                                </tr>
                                
							</table>
                            
                        
                            <div class="search_section">
                                <div class="right_alignment">
                                        <asp:TextBox ID="txtSearch" CssClass="marg" runat="server"></asp:TextBox>
                                        <asp:Button ID="btnSearch" CssClass="btn btn-default right" Text="SEARCH" runat="server" OnClick="btnSearch_Click" />
                                        <asp:Button ID="btnSearchAll" CssClass="btn btn-success right" Text="SEARCH ALL" runat="server" OnClick="btnSearchAll_Click" />
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
                                                    CommandName="Edit" 
                                                    ImageUrl="../assets/img/edit.png"                                                         
                                                    ToolTip="Edit" />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                       
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Delete" ItemStyle-Width="30px">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgDel" runat="server" CausesValidation="false"                                      
                                                    CommandArgument = '<%#Eval("Id")%>' onClientClick="return confirm('Are you sure??')"
                                                    CommandName="Delete" ImageUrl="../assets/img/delete.png"                                                         
                                                    ToolTip="Delete"></asp:ImageButton>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>

                                        <asp:BoundField ReadOnly="True" DataField="CityName" HeaderText="City Name" />
                                        <asp:BoundField ReadOnly="True" DataField="CountryName" HeaderText="Country Name" />
                                        
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
