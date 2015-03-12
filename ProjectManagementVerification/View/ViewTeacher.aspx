<%@ Page Title="" Language="C#" MasterPageFile="~/UI-Master/UIMaster.Master" AutoEventWireup="true" CodeBehind="ViewTeacher.aspx.cs" Inherits="ProjectManagementVerification.View.ViewTeacher" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    View Teacher's Profile
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    
    <style type="text/css">
        
        .personal-info p{
            padding: 0;
            margin: 0;
            vertical-align: bottom;
        }

    </style>
    
    
    <script>
        $(document).ready(function () {
            
        });


    </script>
    
    

        
        
    
    <form id="form1" runat="server">
    
    <div class="row boxed">
                   <div class="col-lg-12 profile-header">
                        <div class="stats">
                            <p class="stat"><span class="label label-info">5</span> Tickets</p>
                            <p class="stat"><span class="label label-success">27</span> Tasks</p>
                            <p class="stat"><span class="label label-danger">15</span> Overdue</p>
                        </div>
                        <h1>
                            <span id="lblTeacherName" runat="server"></span>
                        </h1>
                        
                        <ul class="breadcrumb">
                            <li><a href="../View/Default.aspx">Home</a> </li>
                            <li class="active">Breanna Hayward</li>
                        </ul>
                    </div>
        
    </div>
    
    <div class="row boxed">
        <div class="col-lg-12">
            <div class="col-lg-2">
                <asp:Image ID="imgProfilePic" Width="100%" Height="100px" runat="server"/>
            </div>
            
            <div class="col-lg-4">
                <span class="personal-info">
                    <p>Employee ID: <asp:Label ID="lblEmployeeId" runat="server"></asp:Label></p>
                    <p>Designation: <asp:Label ID="lblDesignation" runat="server"></asp:Label></p>
                    <p>Email: <asp:Label ID="lblEmail" runat="server"></asp:Label></p>
                    <p>Department: <asp:Label ID="lblDepartment" runat="server"></asp:Label></p>
                    <p>Online Status: <asp:Label ID="lblOnlineStatus" runat="server"></asp:Label></p>
                </span>
            </div>
            
            
        </div>
        <div class="col-lg-12">
            <div class="col-lg-6">
                <asp:TextBox ID="txtMessage" placeholder="Write your message" CssClass="form-control top-margin" style="height: 80px" TextMode="MultiLine" runat="server"></asp:TextBox>
                <asp:TextBox ID="txtTeacherId" Visible="False" runat="server"></asp:TextBox>
                
                
                <asp:Button ID="btnSendRequest" CssClass="btn2 btn-success top-margin" Text="SEND REQUEST FOR PROJECT" style="float: right" runat="server" OnClick="btnSendRequest_Click"/>
                <h4 ID="btnRequested" runat="server">
                     <a runat="server" ID="CancelRequest" href="#contact" data-toggle="modal" style="float: right; margin-left: 10px" class="btnme btn-danger btnme-xs btnme-line">Cancel Request</a>
                     <span class="label label-info" style="float:right">Request Already Sent</span> 
                </h4>
                
                <span class="col-lg-12 top-margin"><asp:Label ID="lblMessage" runat="server"></asp:Label></span>
                <span class="col-lg-12 top-margin"></span>
            </div>
        </div>
    </div>




    
    <div class="modal fade" id="contact" role="dialog">
    	<div class="modal-dialog">
        	
            <div class="modal-content">
            	<div class="modal-header">
                	<h2>Confirmation</h2>
                </div>
                <div class="modal-body" style="border-bottom: none">
                	Are You Sure to Cancel Request?<br/>
                    
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnCancelRequest" CssClass="btn2 btn-danger top-margin" style="float: left" Text="CONFIRM" runat="server" OnClick="btnCancelRequest_Click"/>
                	<a class="btn2 btn-info" style="margin-top: 20px" data-dismiss="modal">Close</a>
                </div>
            </div>

        </div>
    </div>




</form>    
    
    

</asp:Content>
