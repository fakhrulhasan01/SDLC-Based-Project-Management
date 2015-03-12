<%@ Page Title="" Language="C#" MasterPageFile="~/ViewMaster/Dashboard.Master" AutoEventWireup="true" CodeBehind="SearchProjectToAssignTask.aspx.cs" Inherits="ProjectManagementVerification.Dashboard.SearchProjectToAssignTask" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    
    <script>
        $(document).ready(function () {
            $("#<%=txtDateFrom.ClientID%>").keyup(function (e) {
                //alert(e.keyCode);
                $(this).val('');
            });
            $("#<%=txtDateTo.ClientID%>").keyup(function (e) {
                //alert(e.keyCode);
                $(this).val('');
            });
        });


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
						<h2><i class="halflings-icon white edit"></i><span class="break"></span>Add Department</h2>
						<div class="box-icon">
							<a href="#" class="btn-setting"><i class="halflings-icon white wrench"></i></a>
							<a href="#" class="btn-minimize"><i class="halflings-icon white chevron-up"></i></a>
							<a href="#" class="btn-close"><i class="halflings-icon white remove"></i></a>
						</div>
					</div>

					<div class="box-content">
					    
		                    <div class="span12">
		                        <asp:TextBox ID="txtDateFrom" placeholder="Date From" style="margin-top: 8px" CssClass="datepicker" runat="server"></asp:TextBox>
		                        <asp:TextBox ID="txtDateTo" placeholder="Date From" style="margin-top: 8px" CssClass="datepicker" runat="server"></asp:TextBox>
		                        <asp:Button ID="btnSearchProjects" CssClass="btn btnme-success" Text="SEARCH PROJECTS" runat="server"/>
		                    </div>					
                            
                        
                            <div class="search_section">
                                <div class="right_alignment">
                                        
                                </div>
                            </div>    						
                            
                            <div class="search_section">
        
                                
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

			<a href="#" class="btn" data-dismiss="modal" id="close">Close</a>
		</div>
	</div>
    <!--Modal End-->
            
</asp:Content>