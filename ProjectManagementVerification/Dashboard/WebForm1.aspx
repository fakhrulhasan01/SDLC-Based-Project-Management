<%@ Page Title="" Language="C#" MasterPageFile="~/ViewMaster/Dashboard.Master" ValidateRequest="false" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="ProjectManagementVerification.Dashboard.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<script>
    $(document).ready(function() {
        $("#clickMe").click(function() {
            alert($("iframe").html());
        });
    });
</script>
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
                        <asp:Label ID="lblShow" runat="server"></asp:Label>
                        <asp:Button ID="btnSave" Text="CREATE" CssClass="btn btn-success" runat="server" OnClick="btnSave_Click"/>
                        <br/>
                        <iframe src="http://docs.google.com/gview?url=http://www.rahesunnahblog.com/TranslationOne.docx&embedded=true" style="width:800px; height:500px; background-color: none" frameborder="0">
                            
                        </iframe>
                        
                        <h2 id="clickMe">Click Me</h2>
                        
                    </div>
                </div>
            </div>

			
			
    

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
