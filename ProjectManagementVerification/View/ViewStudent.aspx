<%@ Page Title="" Language="C#" MasterPageFile="~/UI-Master/UIMaster.Master" AutoEventWireup="true" CodeBehind="ViewStudent.aspx.cs" Inherits="ProjectManagementVerification.View.ViewStudent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    View Student's Profile
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
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





    <form id="form1" runat="server">
    
        
        
    <div class="row boxed">
        <div class="col-lg-4 right-border">
                    <div class="form-group">
                        <div class="col-lg-12">
                            <div class="fileupload fileupload-new" data-provides="fileupload">
                                <div class="fileupload-preview thumbnail" style="width: 100%; height: 220px;">
                                    <asp:Image CssClass="img-responsive img-thumbnail img-circle" ID="imgProfilePic" runat="server"/>
                                </div>
                                
                            </div>
                        </div>
                    </div>

                               
            <div class="col-lg-12">
            <div class="panel-user panel-user-default">
                    <div class="panel-user-heading">Academic Info </div>
                    
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
                    <div class="panel-user-heading" onclick="return ShowMe()">Personal Info<span class="stats"></span></div>
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
                          
        </div>
    </div>

        
    
    
    
   


    </form>
    
</asp:Content>

