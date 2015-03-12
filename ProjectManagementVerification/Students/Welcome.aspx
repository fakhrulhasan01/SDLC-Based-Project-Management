<%@ Page Title="" Language="C#" MasterPageFile="~/Student-Master/StudentMaster.Master" AutoEventWireup="true" CodeBehind="Welcome.aspx.cs" Inherits="ProjectManagementVerification.Students.Welcome" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="ProjectManagementVerification.BLL" %>
<%@ Import Namespace="ProjectManagementVerification.DAL" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    Welcome to Project Management
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Slide" runat="server">
    <style>
        .ss {
            display: block;
        }
        .right-border {
            border-right: 1px #b0c4de solid;
        }
        .topMargin {
            margin-top: 18px;
        }

        .list-group {
            cursor: pointer;
            text-decoration: underline;
            color: #4299d8;
        }


        ::-webkit-scrollbar {
            width: 12px;
        }
 
        ::-webkit-scrollbar-track {
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3); 
            border-radius: 10px;
        }
 
        ::-webkit-scrollbar-thumb {
            border-radius: 10px;
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5); 
        }


        ::-moz-scrollbar {
            width: 12px;
        }
 
        ::-moz-scrollbar-track {
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3); 
            border-radius: 10px;
        }
 



    </style>




    <script>
        
        


        var errorUpdate = 0;
        $(function () {

            //Checking if the StudentId is already exist
            $("#<%=txtStudentId.ClientID%>").focusout(function () {
                var search_term = $(this).val();
                $.get('../View/AjaxRequestPages/Search.aspx', { search_term: search_term }, function (data) {
                    if (data == "<font color='red'>Id is not available</font>") {
                        errorUpdate++;
                    } else {
                        errorUpdate = 0;
                    }
                    $("#search_result").html(data);
                });
                //alert("Hi");
            });

            

            $("#txtShow").hide();

            


            $("#<%=txtCurrentSemester.ClientID%>").keyup(function () {
                $("#search_result").html($(this).val());

            });


            $("#btnEditAcademicInfo").click(function () {
                $("#txtShow").val($(this).text());
                if ($(this).text() == "Edit Academic Info") {
                    $(this).text("Hide");
                } else {
                    $(this).text("Edit Academic Info");
                }
                $("#txtShow").toggle();
            });
                        

            $("#<%=flStudentImage.ClientID%>").change(function () {
                var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
                if (regex.test($(this).val().toLowerCase())) {
                    $("#<%=btnImageUpdate.ClientID%>").fadeIn(1000);

                } else {
                    alert("Please upload a valid image file.");
                }
            });

           



            //Control Modal
            //Searching Teacher In Modal
            $("#search_teacher").focusout(function () {
                var search_term = $(this).val();
                $.get('../View/AjaxRequestPages/Search.aspx', { search_teacher : search_term }, function (data) {
                    if (data == "<font color='red'>No teachers found</font>") {
                        //errorUpdate++;
                    } else {
                        //errorUpdate = 0;
                    }
                    $("#search_teacher_feedback").html(data).reload();
                });
            });


            

            //To load a specific client id of the page
            $("#approvedRequests").click(function () {
                $("#approved_request_container").show();
                $("#search_teacher_container").hide();
                $('#approvedRequestsValue').load(location.href + ' #approvedRequestsValue');
            });



            //To load a specific client id of the page
            $("#sendRequests").click(function () {
                $("#search_teacher_container").show();
                $("#approved_request_container").hide();
            });



        });



        function ShowMe() {
            alert($(this).text());
            return true;
        }


        function validate() {
            $("#<%=txtStudentId.ClientID%>").focusout();
            alert(errorUpdate);
            if (errorUpdate > 0) {
                return false;
            } else {
                return false;
            }
            
        }

    </script>
    <form id="form1" runat="server">
    
        
        
    <div class="row boxed">
        <div class="col-lg-4 right-border">
                    <div class="form-group">
                        <div class="col-lg-12">
                            <div class="fileupload fileupload-new" data-provides="fileupload">
                                <div class="fileupload-preview thumbnail" style="width: 100%; height: 220px;">
                                    <asp:Image CssClass="img-responsive img-thumbnail img-circle" ID="imgProfilePic" runat="server"/>
                                </div>
                                
                                <div class="col-lg-12" style="padding-bottom: 8px">
                                    <span class="btn2 btn-file btn-success">
                                        <span class="fileupload-new"  style="float: left; position: relative">Change</span>
                                        <span class="fileupload-exists" style="float: left; position: relative">Change</span>
                                        <asp:FileUpload ID="flStudentImage" runat="server" />
                                    </span>
                                    <a href="#" class="btn2 btn-danger fileupload-exists" data-dismiss="fileupload">Remove</a>
                                    <asp:Button ID="btnImageUpdate" style="display:none" CssClass="btn2 btn-file btn-primary" Text="Upload" runat="server" OnClick="btnImageUpdate_Click"/>
                                </div>

                            </div>
                        </div>
                    </div>

            <div class="col-lg-12" id="txtShow">
                <div class="form-group topMargin">
                    <span class="col-lg-4">Student ID</span>    
                    <div class="col-lg-8"><asp:TextBox CssClass="form-control" ID="txtStudentId" runat="server"></asp:TextBox></div>
                    <div class="col-lg-12" id="search_result"></div>
                </div>
                <br/>
                <div class="form-group topMargin">
                    <span class="col-lg-4">Department</span>    
                    <div class="col-lg-8">
                        <asp:DropDownList CssClass="form-control" ID="ddlDepartment" runat="server">
                        </asp:DropDownList>
                    </div>
                </div>
                <br/>
                <div class="form-group topMargin">
                    <span class="col-lg-4">Current Semester</span>    
                    <div class="col-lg-8"><asp:TextBox CssClass="form-control" ID="txtCurrentSemester" runat="server"></asp:TextBox></div>
                </div>
                <br/>
                <div class="form-group topMargin">
                    <span class="col-lg-4"></span>    
                    <div class="col-lg-8"><asp:Button OnClientClick="return validate()" CssClass="btnme btn-action" Text="UPDATE" ID="btnUpdateAcademicInfo" style="background-color: #20b2aa; float: right; color: #FFF" runat="server" OnClick="btnUpdateAcademicInfo_Click"></asp:Button></div>
                </div>
                <br/>
                <br/>
            </div>
                               
            <div class="col-lg-12">
            <div class="panel-user panel-user-default">
                    <div class="panel-user-heading">Academic Info <span class="stats"><span id="btnEditAcademicInfo" class="btnme btnme-success btnme-xs btnme-line">Edit Academic Info</span></span></div>
                    
                    <div class="panel-user-body">
                        <ul class="list-unstyled list-info">
                            <li>
                                <b>Student Id: </b> <i><asp:Label ID="lblStudentId" runat="server"></asp:Label></i><br/>
                                <b>Current Semester: </b> <i><asp:Label ID="lblCurrentSemester" runat="server"></asp:Label></i><br/>
                                <b>Department: </b> <i><asp:Label ID="lblDepartment" runat="server"></asp:Label></i><br/>
                            </li>
                           
                            <li>
                                
                                Online
                            </li>
                        </ul>

                    </div>
                </div>
                </div>
                         
                                                

        </div>
        

        
        <div class="col-lg-4">
            <div class="panel-user panel-user-default">
                    <div class="panel-user-heading" onclick="return ShowMe()">Personal Info<span class="stats"><asp:Button ID="btnEditPersonalInfo" Text="Edit Info" CssClass="btnme btnme-success btnme-xs btnme-line" runat="server" OnClick="btnEditPersonalInfo_Click"/></span></div>
                    <div class="panel-user-body">
                        <ul class="list-unstyled list-info">
                            <li id="containerFullName">
                                <span class="text-info fa fa-user fa-fw"></span>
                                <asp:Label ID="lblFullName" runat="server"></asp:Label>
                                
                            </li>
                            <li id="containerEmail">
                                <span class="text-info fa fa-envelope fa-fw"></span>
                                <asp:Label ID="lblEmail" runat="server"></asp:Label>
                            </li>
                            
                            <li id="containerAddress">
                                <span class="text-info fa fa-home fa-fw"></span>
                                <asp:Label ID="lblAddress" runat="server"></asp:Label>
                                
                            </li>

                            <li id="containerContact">
                                <span class="text-info fa fa-phone fa-fw"></span>
                                <asp:Label ID="lblContact" runat="server"></asp:Label>
                                <span class="stats"><span id="editContact" style="display: none" class="btnme btnme-success btnme-xs btnme-line">Edit</span></span>
                            </li>
                            <li id="containerCity">
                                <span class="halflings-icon globe"></span>
                                <asp:Label ID="lblCity" runat="server"></asp:Label>
                                <hr/>
                            </li>
                                
                            <li>
                                <b>Father Name: </b> <asp:Label ID="lblFatherName" runat="server"></asp:Label><br/>
                                <b>Mother Name: </b> <asp:Label ID="lblMotherName" runat="server"></asp:Label><br/>
                                <b>Date Of Birth: </b> <asp:Label ID="lblDateOfBirth" runat="server"></asp:Label><br/>
                                <b>Gender: </b> <asp:Label ID="lblGender" runat="server"></asp:Label><br/>
                            </li>
                            
                            
                            <li>
                                <span class="text-info fa fa-comment fa-fw"></span>
                                Online
                            </li>
                        </ul>

                    </div>
                </div>
        </div>
    

        <div class="col-lg-4">
                <div class="panel-user panel-user-default" style="padding-bottom:0;">
                    <div class="panel-user-heading">
                        Messages
                    </div>
                    <ul class="list-group">

                        <li class="list-group-item" href="#contact" data-toggle="modal" id="sendRequests">
                            <a href="#">
                                <i class="fa fa-share "></i> Send Request To Teacher
                                <span class="pull-right label label-danger">13</span>
                            </a>
                        </li>
                        
                        

                        <li class="list-group-item" href="#contact" data-toggle="modal" id="approvedRequests">
                                <i class="fa fa-plus "></i> Request Approval Notification
                                <span class="pull-right label label-danger" id="approvedRequestsValue">
                                   <asp:Label ID="lblApprovalRequests" Text="0" runat="server"></asp:Label>
                                </span>
                        </li>
                        
                        <li class="list-group-item"><a href="#"><i class="fa fa-thumbs-up "></i> Important<span class="pull-right label label-danger">10</span></a></li>
                        <li class="list-group-item"><a href="#"><i class="fa fa-envelope "></i> Personal<span class="pull-right label label-danger">39</span></a></li>
                    </ul>
                </div>            
        </div>
    </div>

        
    
    
    
    <div class="modal fade" id="contact" role="dialog">
    	<div class="modal-dialog">
        	
            <div class="modal-content" id="search_teacher_container" style="height: 100%; overflow: scroll">
            	<div class="modal-header">
                	<h2>Send Request to Teacher</h2>
                </div>
                <div class="modal-body">
                	This is the main body of modal. Here you can write description of your topics. This model is now open, because you click on contact button. Click outside of the modal to close it.
                    <input type="text" id="search_teacher" class="form-control" placeholder="Enter Name" />
                    
                    
                    <span id="search_teacher_feedback">
                        
                    </span>
                </div>
                <div class="modal-footer">
                	Thank you <a class="btn2 btn-success" data-dismiss="modal">Close</a>
                </div>
            </div>

        	

            <div class="modal-content" id="approved_request_container" style="height: 100%; overflow: scroll">
            	<div class="modal-header">
                	<h2>Your Approved Request</h2>
                </div>
                <div class="modal-body">
                    <asp:GridView runat="server" CssClass="table table-bordered table-hover table-color" ID="grdApprovedRequests" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField ReadOnly="True" DataField="ApprovalStatus" HeaderText="Approval Status"/>
                            <asp:BoundField ReadOnly="True" DataField="TeacherName" HeaderText="Approved By"/>
                            <asp:BoundField ReadOnly="True" DataField="RequestDate" HeaderText="Request Date"/>
                            <asp:BoundField ReadOnly="True" DataField="ConfirmationDate" HeaderText="Confirmation Date"/>
                        </Columns>
                    </asp:GridView>
                </div>
                <div class="modal-footer">
                	Thank you <a class="btn2 btn-success" data-dismiss="modal">Close</a>
                </div>
            </div>

        </div>
    </div>


    </form>
    
    
    
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Middle" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="Bottom" runat="server">
</asp:Content>
