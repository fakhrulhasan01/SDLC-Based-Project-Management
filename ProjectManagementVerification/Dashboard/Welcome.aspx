
<%@ Page Title="" Language="C#" MasterPageFile="~/ViewMaster/DashBoard.Master" AutoEventWireup="true" CodeBehind="Welcome.aspx.cs" Inherits="ProjectManagementVerification.Dashboard.Welcome" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <style>
        li {
            list-style: none;
        }
        ul {
            margin: 0;        
        }

        .border-bottom {
            border-bottom: 1px #eeeeee solid;
        }

        .auto-height {
            height: auto;
        }


        .message-container {
            float: right;
            min-height: 14px;
            margin: 0px 38px 8px 0px;
            
        }
        
        .list-group-item {
            position: relative;
            display: block;
            padding: 0px 15px 4px 15px;
            margin-bottom: -1px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-left: none;
            border-right: none;
        }

        .table-color th {
           background-color: #ddd;
            border: 1px #e8e8ec solid;
        }

        .table-color td {
            
        }
        
        .table-color {
           
        } 
        
    </style>
<asp:ScriptManager runat="server" ID="ScriptManager2"/>
    
    <script>
        $(document).ready(function() {

            $('#flup').on('click', function (evt) {
                evt.preventDefault();
                $('#<%=flTeacherImage.ClientID%>').trigger('click');
            });

            setInterval(function () {
                $(".message-container").width($("#<%=txtEmployeeId.ClientID%>").width() + "px");
            }, 1000);


            var errorUpdate = 0;


            //Checking if the StudentId is already exist
            $("#<%=txtEmployeeId.ClientID%>").focusout(function () {
                var search_term = $(this).val();
                $.get('../View/AjaxRequestPages/Search.aspx', { searchTermEmployeeId: search_term }, function (data) {
                    if (data == "<font color='red'>Employee Id is not available</font>") {
                        errorUpdate++;
                    } else {
                        errorUpdate = 0;
                    }
                    $("#msgEmployeeId").html(data);
                });
                //alert("Hi");
                alert(errorUpdate);
            });




            $("#btnEditAcademicInfo").click(function () {
                var btnText = $(this);
                $("#txtShow").slideToggle(function() {
                    if (btnText.text() == "Edit Academic Info") {
                        btnText.text("hide");
                    } else {
                        btnText.text("Edit Academic Info");
                    }
                });
            });


            $("#<%=flTeacherImage.ClientID%>").change(function () {
                var regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/;
                if (regex.test($(this).val().toLowerCase())) {
                    $("#<%=btnImageUpdate.ClientID%>").fadeIn(1000);

                } else {
                    alert("Please upload a valid image file.");
                }
            });


            $("#sendMessage").click(function() {
                $("#<%=txtId.ClientID%>").hide();
            });


            /*$("#tableStudentRequest td").click(function() {
                var messageLocation = $(this).find('.suc');
                var studentIdToConfirm = $(this).attr("data");
                alert(studentIdToConfirm);
                var message;
                $.get('../View/AjaxRequestPages/Operations.aspx', { studentIdToConfirm: studentIdToConfirm }, function (data) {
                    if (data == "Success") {
                        window.location.load(true);
                    }
                });
                
            });*/


            $("#Hami").click(function () {
                $('#studentRequest').load(location.href + ' #studentRequest');
            });


            $("#fileRemove").click(function() {
                $("#<%=btnImageUpdate.ClientID%>").hide();
            });

            /*setInterval(function() {
                $('#myTable').load(location.href + ' #myTable');
            }, 200);*/


        });

        

        function ShowSendMessage() {
            alert('Hi');
            return false;
        }
    </script>
    
    
    
    
    
    <div id="content" class="span10" style="min-height: 400px; background-color: #FFF">
        <div class="span12">
            <div class="alert alert-success">
                <button type="button" class="close" data-dismiss="alert">×</button>
                <div runat="server" ID="WelcomeMessage"></div>
            </div>    
        </div>

       <div class="span11">
           
           
           <div class="span4 right-border">
            <div class="span10" style="float: right">
                           <div class="fileupload fileupload-new" data-provides="fileupload">
                                <div class="fileupload-preview thumbnail" style="width: 80%; height: 160px;">
                                    <asp:Image Width="100%" ID="imgProfilePic" runat="server"/>
                                </div>
                                
                                <div class="span12" style="padding-bottom: 8px">
                                    <span class="btn2 btn-file btn-success">
                                        <span class="fileupload-new" id="flup"  style="float: left; position: relative">Change</span>
                                        <span class="fileupload-exists" style="float: left; position: relative">Change</span>
                                        <asp:FileUpload style="display: none" ID="flTeacherImage" runat="server" />
                                    </span>
                                    <a href="#" class="btn2 btn-danger fileupload-exists" id="fileRemove" data-dismiss="fileupload">Remove</a>
                                    <asp:Button ID="btnImageUpdate" style="display:none" CssClass="btn2 btn-file btn-primary" Text="Upload" runat="server" OnClick="btnImageUpdate_Click"/>
                                </div>

                            </div>
                        
            </div>

            <asp:Label ID="lblMessageUpdateAcademic" runat="server" style="margin:0 26px 14px 0; width: 100%" ></asp:Label>
            <div class="span12" id="txtShow" style="display: none">
                <div style="display: none" class="span12">
                    
                </div>
                

                <div class="span12">
                    <span class="span3" style="text-align: left">Employee ID</span>
                    <div class="span9"><asp:TextBox CssClass="form-control adj" ID="txtEmployeeId" runat="server"></asp:TextBox></div>
                    <div class="message-container" id="msgEmployeeId"></div>
                </div>
                
                <div class="span12">
                    <span class="span3" style="text-align: left">Designation</span>
                    <div class="span9"><asp:TextBox CssClass="form-control adj" ID="txtDesignation" runat="server"></asp:TextBox></div>
                    <div class="message-container" id="msgDesignation"></div>
                </div>
                
                <div class="span12">
                    <span class="span3">Department</span>
                    <div class="span9">
                        <asp:DropDownList CssClass="form-control adj" ID="ddlDepartment" runat="server">
                            
                        </asp:DropDownList>
                    </div>
                    <div class="message-container" id="msgDepartment"></div>
                    
                </div>
                
                
                <div class="span12">
                    <asp:Button style="margin-right: 26px" CssClass="btn2 btn-success right_alignment" ID="btnAcademicInfoUpdate" Text="UPDATE" runat="server" OnClick="btnAcademicInfoUpdate_Click"/>    <br/>
                </div>
                
            </div>
                               
            <div class="span12">
            <div class="panel-user panel-user-default">
                    <div class="panel-user-heading">Academic Info <span class="stats"><span id="btnEditAcademicInfo" class="btnme btnme-success btnme-xs btnme-line">Edit Academic Info</span></span></div>
                    
                    <div class="panel-user-body">
                        <ul class="list-unstyled list-info">
                            <li>
                                <b>Employee ID: </b> <i><asp:Label ID="lblEmployeeId" runat="server"></asp:Label></i><br/>
                                <b>Designation: </b> <i><asp:Label ID="lblDesignation" runat="server"></asp:Label></i><br/>
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
        

        
            <div class="span4">
            <div class="panel-user panel-user-default">
                    <div class="panel-user-heading">Personal Info<span class="stats"><a class="btnme btnme-success btnme-xs btnme-line" href="EditPersonalInfo.aspx">Edit Info</a></span></div>
                    <div class="panel-user-body">
                        <ul class="list-unstyled list-info">
                            <li id="containerFullName">
                                <span title="Full Name" data-rel="tooltip" class="halflings-icon user"></span>
                                <asp:Label ID="lblFullName" runat="server"></asp:Label>
                            </li>
                            <li id="containerEmail">
                                <span title="Email" data-rel="tooltip" class="halflings-icon envelope"></span>
                                <asp:Label ID="lblEmail" runat="server"></asp:Label>
                            </li>
                            
                            <li id="containerAddress">
                                <span title="Address" data-rel="tooltip" class="halflings-icon home"></span>
                                <asp:Label ID="lblAddress" runat="server"></asp:Label>
                            </li>
                            
                            <li id="containerContact">
                                <span title="Contact" data-rel="tooltip" class="halflings-icon phone"></span>
                                <asp:Label ID="lblContact" runat="server"></asp:Label>
                            </li>

                            <li id="containerCity">
                                <span title="Location" data-rel="tooltip" class="halflings-icon globe"></span>
                                <asp:Label ID="lblCity" runat="server"></asp:Label>
                            </li>
                                
                            <li>
                                <hr class="border-bottom"/>
                                Gender: <asp:Label ID="lblGender" runat="server"></asp:Label><br/>
                            </li>
                            
                        </ul>

                    </div>
                </div>
        </div>
    

            <div class="span4">
                <div class="panel-user panel-user-default" style="padding-bottom:0;">
                    <div class="panel-user-heading">
                        Messages
                    </div>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>

                            <ul class="list-group" style="border-bottom: 2px #dddddd solid">

                                <li id="sendMessage" class="list-group-item">
                                    <i class="glyphicons-icon message_new"></i>
                                    <asp:LinkButton runat="server" ID="btnNewMessage" Style="vertical-align: bottom" Text="New Requests" OnClick="btnNewMessage_Click" />
                                    <asp:LinkButton ID="lnkBtnNewMessages" runat="server" Style="margin-top: 20px; width: 16px" CssClass="pull-right label label-important" OnClick="lnkBtnNewMessages_Click" />
                                </li>

                                <li class="list-group-item" style="padding-top: 8px; padding-bottom: 8px">
                                    <img src="../assetsUI/custom-icons/ok.png" style="margin-left: 6px" />
                                    &nbsp;
                            <asp:LinkButton runat="server"  ID="btnApprovedRequest" Style="vertical-align: bottom" Text="Approved Requests" OnClick="btnApprovedRequest_Click" />
                                    <asp:LinkButton ID="lnkBtnApprovedRequest" runat="server" Style="margin-top: 4px; width: 16px" CssClass="pull-right label label-success" OnClick="lnkBtnApprovedRequest_Click" />
                                </li>

                                <li class="list-group-item" style="padding-top: 8px; padding-bottom: 8px">
                                    <img src="../assetsUI/custom-icons/ban.png" style="margin-left: 6px" />
                                    &nbsp;
                            <asp:LinkButton runat="server" ID="btnBannedRequest" Style="vertical-align: bottom" Text="Banned Requests" OnClick="btnBannedRequest_Click" />
                                    <asp:LinkButton ID="lnkBtnBannedRequest" runat="server" Style="margin-top: 4px; width: 16px" CssClass="pull-right label label-warning" OnClick="lnkBtnBannedRequest_Click" />
                                </li>

                            </ul>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                </div>            
        </div>
           
           
           <div class="span8">
               <br/>
               
               <asp:UpdatePanel ID="requersts" runat="server">
                   <ContentTemplate>
                       <asp:Label runat="server" ID="lblApprovalStatus"></asp:Label>
                       <asp:GridView ID="grdStudentRequests" CssClass="table table-color table-responsive table-bordered table-hover" runat="server"
                           AutoGenerateColumns="False" OnRowUpdating="grdStudentRequests_RowUpdating" DataKeyNames="StudentId"
                           OnRowEditing="grdStudentRequests_RowEditing" OnRowDeleting="grdStudentRequests_RowDeleting">
                           <Columns>
                               <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Operations">
                                   <ItemTemplate>
                                       <asp:LinkButton ID="lnkEditNew" data-rel="tooltip" CommandArgument='<%#Eval("StudentId") %>'
                                           CssClass="halflings-icon ok" ToolTip="Approve"
                                           CommandName="Edit" runat="server" />&nbsp;
                               <asp:LinkButton ID="lnkDeleteNew" data-rel="tooltip" CommandArgument='<%#Eval("StudentId") %>'
                                   CssClass="halflings-icon ban-circle" ToolTip="Ban" OnClientClick=" return confirm('You are going to Ban the request') "
                                   CommandName="Delete" runat="server" />&nbsp;
                               <asp:LinkButton ID="lnkUpdateNew" data-rel="tooltip" CommandArgument='<%#Eval("StudentId") %>'
                                   CssClass="halflings-icon remove" ToolTip="Remove" OnClientClick=" return confirm('You are going to Remove the request') "
                                   CommandName="Update" runat="server" />
                                   </ItemTemplate>
                                   <ItemStyle HorizontalAlign="Center"></ItemStyle>
                               </asp:TemplateField>
                               <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Operations">
                                   <ItemTemplate>
                                       <asp:LinkButton ID="lnkDeleteApprove" data-rel="tooltip" CommandArgument='<%#Eval("StudentId") %>'
                                           CssClass="halflings-icon ban-circle" ToolTip="Ban" OnClientClick=" return confirm('You are going to Ban the request') "
                                           CommandName="Delete" runat="server" />&nbsp;
                               <asp:LinkButton ID="lnkUpdateApprove" data-rel="tooltip" CommandArgument='<%#Eval("StudentId") %>'
                                   CssClass="halflings-icon remove" ToolTip="Delete" OnClientClick=" return confirm('You are going to Remove the request') "
                                   CommandName="Update" runat="server" />
                                   </ItemTemplate>
                                   <ItemStyle HorizontalAlign="Center"></ItemStyle>
                               </asp:TemplateField>
                               <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Operations">
                                   <ItemTemplate>
                                       <asp:LinkButton ID="lnkEditBanned" data-rel="tooltip" CommandArgument='<%#Eval("StudentId") %>'
                                           CssClass="halflings-icon ok" ToolTip="Approve"
                                           CommandName="Edit" runat="server" />
                                       <asp:LinkButton ID="lnkUpdateBanned" data-rel="tooltip" CommandArgument='<%#Eval("StudentId") %>'
                                           CssClass="halflings-icon remove" ToolTip="Remove" OnClientClick=" return confirm('You are going to Remove the request') "
                                           CommandName="Update" runat="server" />
                                   </ItemTemplate>
                                   <ItemStyle HorizontalAlign="Center"></ItemStyle>
                               </asp:TemplateField>
                               <asp:BoundField ReadOnly="True" DataField="ApprovalStatus" HeaderText="Approval Status" />
                               <asp:BoundField ReadOnly="True" DataField="StudentName" HeaderText="Student Name" />
                               <asp:BoundField ReadOnly="True" DataField="RequestDate" HeaderText="Request Date" />
                               <asp:BoundField ReadOnly="True" DataField="ConfirmationDate" HeaderText="Confirmation Date" />
                           </Columns>
                       </asp:GridView>
                   </ContentTemplate>
                   <Triggers>
                       <asp:AsyncPostBackTrigger ControlID="lnkBtnNewMessages" EventName="Click" />
                       <asp:AsyncPostBackTrigger ControlID="lnkBtnApprovedRequest" EventName="Click" />
                       <asp:AsyncPostBackTrigger ControlID="lnkBtnBannedRequest" EventName="Click" />
                   </Triggers>
               </asp:UpdatePanel>
           </div>

       </div>
        
        
        
        <span class="12">
            <!--<div id="studentRequest">
                <table id="tableStudentRequest" class="table table-bordered">
                    <tr>
                        <th>Requested By</th>
                        <th>Message</th>
                        <th>Request Date</th>
                        <th>Approval Status</th>
                        <th>Take Operation</th>
                    </tr>
                    <%
                  /*      var prdRequestDb = new ProjectRequestDb();
                        DataTable dt = prdRequestDb.GetData(0, string.Empty);
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            Response.Write("<tr>");
                            Response.Write("<td>" + dt.Rows[i]["StudentName"] + "</td>");
                            Response.Write("<td>" + dt.Rows[i]["StudentMessage"] + "</td>");
                            Response.Write("<td>" + dt.Rows[i]["RequestDate"] + "</td>");
                            Response.Write("<td>" + dt.Rows[i]["ApprovalStatus"] + "</td>");
                            Response.Write("<td data=" + "'" + dt.Rows[i]["StudentId"] + "'>");
                            if ((string)dt.Rows[i]["ApprovalStatus"] == "Pending")
                            {
                                Response.Write("<i class='glyphicons-icon ok_2'></i><span class='suc'></span>");
                            }
                            else
                            {
                                Response.Write(@"<i class='glyphicons-icon ban'></i>
                                                  <i class='glyphicons-icon remove_2'></i>");
                            }
                            Response.Write("</td>");
                            Response.Write("</tr>");
                        }*/
                    %>
                </table>
            </div>-->            
            
        </span>


    </div>
    
    
    
    <!--Modal Start-->
    <div class="modal hide fade sortable ui-sortable" id="myModal">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<h3>Settings</h3>
            <asp:TextBox ID="txtId" Visible="True" class="form-control" Width="200" runat="server"></asp:TextBox>
		</div>
		<div class="modal-body">
			<div class="span12" id="content">
                <p class="span12">Search User To Send Message</p>
                <div class="span3">Type User Name</div>
                <div class="span8"><asp:TextBox ID="searchUser" runat="server"></asp:TextBox></div>
                <p class="span12">Search User To Send Message</p>
                <div class="span3">Type User Name</div>
                <div class="span8"><asp:TextBox ID="TextBox1" runat="server"></asp:TextBox></div>
                <p class="span12">Search User To Send Message</p>
                <div class="span3">Type User Name</div>
                <div class="span8"><asp:TextBox ID="TextBox2" runat="server"></asp:TextBox></div>
                <p class="span12">Search User To Send Message</p>
                <div class="span3">Type User Name</div>
                <div class="span8"><asp:TextBox ID="TextBox3" runat="server"></asp:TextBox></div>
                <p class="span12">Search User To Send Message</p>
                <div class="span3">Type User Name</div>
                <div class="span8"><asp:TextBox ID="TextBox4" runat="server"></asp:TextBox></div>
                <p class="span12">Search User To Send Message</p>
                <div class="span3">Type User Name</div>
                <div class="span8"><asp:TextBox ID="TextBox5" runat="server"></asp:TextBox></div>
                <p class="span12">Search User To Send Message</p>
                <div class="span3">Type User Name</div>
                <div class="span8"><asp:TextBox ID="TextBox6" runat="server"></asp:TextBox></div>
                <p class="span12">Search User To Send Message</p>
                <div class="span3">Type User Name</div>
                <div class="span8"><asp:TextBox ID="TextBox7" runat="server"></asp:TextBox></div>
                <p class="span12">Search User To Send Message</p>
                <div class="span3">Type User Name</div>
                <div class="span8"><asp:TextBox ID="TextBox8" runat="server"></asp:TextBox></div>
                <p class="span12">Search User To Send Message</p>
                <div class="span3">Type User Name</div>
                <div class="span8"><asp:TextBox ID="TextBox9" runat="server"></asp:TextBox></div>
                <p class="span12">Search User To Send Message</p>
                <div class="span3">Type User Name</div>
                <div class="span8"><asp:TextBox ID="TextBox10" runat="server"></asp:TextBox></div>
                <p class="span12">Search User To Send Message</p>
                <div class="span3">Type User Name</div>
                <div class="span8"><asp:TextBox ID="TextBox11" runat="server"></asp:TextBox></div>
                <p class="span12">Search User To Send Message</p>
                <div class="span3">Type User Name</div>
                <div class="span8"><asp:TextBox ID="TextBox12" runat="server"></asp:TextBox></div>
                <p class="span12">Search User To Send Message</p>
                <div class="span3">Type User Name</div>
                <div class="span8"><asp:TextBox ID="TextBox13" runat="server"></asp:TextBox></div>
                <p class="span12">Search User To Send Message</p>
                <div class="span3">Type User Name</div>
                <div class="span8"><asp:TextBox ID="TextBox14" runat="server"></asp:TextBox></div>
                <p class="span12">Search User To Send Message</p>
                <div class="span3">Type User Name</div>
                <div class="span8"><asp:TextBox ID="TextBox15" runat="server"></asp:TextBox></div>
                <p class="span12">Search User To Send Message</p>
                <div class="span3">Type User Name</div>
                <div class="span8"><asp:TextBox ID="TextBox16" runat="server"></asp:TextBox></div>
            </div>
        </div>
        
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal" id="close">Close</a>
            <asp:Button ID="btnId" Text="Yes" CssClass="btn" runat="server" OnClick="btnId_Click" />
            
           
		</div>
	</div>
    
    <!--Modal End-->



</asp:Content>
