<%@ Page Title="" Language="C#" MasterPageFile="~/ViewMaster/Dashboard.Master" AutoEventWireup="true" CodeBehind="AddStudentToGroup.aspx.cs" Inherits="ProjectManagementVerification.Dashboard.AddStudentToGroup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    Add Students to Group
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        input[type="text"], textarea, select {
            margin-left: 0;
        }

        
    </style>
    
    
    <script>
        $(document).ready(function () {
            $("#extendedSearchSection").hide();
            $("#showExtendedSearch").click(function () {
                if ($(this).text() == "Extended Search Option") {
                    $(this).text("Hide");
                } else {
                    $(this).text("Extended Search Option");
                }
                $("#extendedSearchSection").toggle();
            });
        });

        function valid() {
            var error = 0;
            var students = $("#<%=ddlStudent.ClientID%>").val();
            var projectGroup = $("#<%=ddlProjectGroup.ClientID%>").val();

            alert(students);
            if (students == "Select Students" || students == "No Approved Students") {
                error++;
                if (students == "Select Students") {
                    alert("Hi");
                    $("#msgStudent").html("<font color='red'>Please select Student</font>");
                } else {
                    $("#msgStudent").html("<font color='red'>Sorry! No Approved Students to Add</font>");
                }
            }


            if (projectGroup == "Select Project Group" || projectGroup == "No Project Group Created") {
                error++;
                if (projectGroup == "No Project Group Created") {
                    $("#msgProjectGroup").html("<font color='red'>Sorry! You didn't create any group</font>");
                } else {
                    $("#msgProjectGroup").html("<font color='red'>Please select a project group</font>");
                }
            }
            if (error == 0) {
                return true;
            } else {
                $("#msgError").html("<font color='red'>Please correct the errors</font>");
                return false;
            }
        }

    </script>

    <div id="content" class="span10">
        <ul class="breadcrumb">
            <li><i class="icon-home"></i><a href="index.html">Home</a> <i class="icon-angle-right"></i></li>
            <li><i class="icon-edit"></i><a href="#">Forms</a> </li>
        </ul>
        <div class="row-fluid sortable">
            <div class="box span12">
                <div class="box-header" data-original-title="">
                    <h2><i class="halflings-icon white edit"></i><span class="break"></span>Add Student to Group</h2>
                    <div class="box-icon">
                        <a class="btn-setting" href="#"><i class="halflings-icon white wrench"></i></a><a class="btn-minimize" href="#"><i class="halflings-icon white chevron-up"></i></a><a class="btn-close" href="#"><i class="halflings-icon white remove"></i></a>
                    </div>
                </div>
                <div class="box-content">
                    <div class="span12">
                        <div id="msgError">
                            <asp:Label ID="lblMessage" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="span12">
                        <div class="span6">
                            <asp:DropDownList ID="ddlProjectGroup" data-rel="chosen" runat="server">
                                
                            </asp:DropDownList>
                            <span id="msgProjectGroup"></span>
                        </div>
                    </div>

                    <div class="span12">
                        <div class="span6">
                            <asp:DropDownList CssClass="form-control" ID="ddlStudent"  data-rel="chosen" runat="server">
                            </asp:DropDownList>
                            <span id="msgStudent">
                            </span>
                        </div>
                    </div>

                    <div class="span12">
                        <asp:Button ID="btnSave" runat="server" CssClass="btn2 btn-primary" OnClick="btnSave_Click" OnClientClick="return valid()" style="margin-left: 172px" Text="SAVE" ValidationGroup="ReqGroup" />
                    </div>
                    <div class="span12">
                        <div class="span11">
                            <span style="margin:auto; float: right">
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="marg"></asp:TextBox>
                                <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-default" OnClick="btnSearch_Click" Text="SEARCH" />
                                <asp:Button ID="btnSearchAll" runat="server" CssClass="btn btn-default" OnClick="btnSearchAll_Click" Text="SEARCH ALL" />
                                <label class="btn btn-info" id="showExtendedSearch">Extended Search Option</label>
                            </span>
                        </div>
                    </div>
                    
                    
                            <div class="span12" id="extendedSearchSection">
                                 <div class="span11">
                                    <span style="margin-top: 8px; float: right">
                                        <asp:DropDownList ID="ddlSearchGroupType" CssClass="marg" data-rel="chosen" runat="server">
                                            <asp:ListItem Text="Select Group Type"></asp:ListItem>
                                            <asp:ListItem Text="Single"></asp:ListItem>
                                            <asp:ListItem Text="Multiple"></asp:ListItem>
                                        </asp:DropDownList>

                                        <asp:DropDownList ID="ddlSearchGroupList" CssClass="marg" data-rel="chosen" runat="server">
                                        </asp:DropDownList>
 
                                        <asp:DropDownList ID="ddlSearchStudentList" CssClass="marg"  data-rel="chosen" runat="server">
                                        </asp:DropDownList>
                                        
                                        <asp:Button ID="btnSearchSpecific" style="margin-top: -22px" CssClass="btn btn-primary" Text="SEARCH" runat="server" OnClick="btnSearchSpecific_Click"/>
                                        
                                    </span>
                                </div>
                            </div>


                    

                    <div class="search_section">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" PageSize="3" AllowPaging="true"
                            CssClass="table table-bordered table-hover" DataKeyNames="StudentId" EmptyDataText="No Search Result Found" 
                            OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing"  PagerStyle-CssClass="paging"
                            OnPageIndexChanging="GridView1_PageIndexChanging" OnRowUpdating="GridView1_RowUpdating">
                            <Columns>
                                <asp:TemplateField HeaderText="Edit" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="30px">
                                    <ItemTemplate>
                                        <asp:ImageButton data-rel="tooltip" ID="imgEdit" runat="server" CausesValidation="false" CommandArgument='<%#Eval("StudentId")%>' CommandName="Edit" ImageUrl="../assets/img/edit.png" Text="Hi" ToolTip="Edit" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="30px">
                                    <ItemTemplate>
                                        <asp:ImageButton data-rel="tooltip" ID="imgDel" runat="server" CausesValidation="false" CommandArgument='<%#Eval("StudentId")%>' CommandName="Delete" ImageUrl="../assets/img/delete.png" onClientClick="return confirm('Are you sure??')" ToolTip="Delete" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>

                                <asp:BoundField DataField="ProjectGroupId" HeaderStyle-CssClass = "hideGridColumn" ItemStyle-CssClass="hideGridColumn"
                                     HeaderText="Project Group ID" ReadOnly="True" />
                                <asp:BoundField DataField="GroupId" HeaderText="Group ID" ReadOnly="True" />
                                <asp:BoundField DataField="Description" HeaderText="Group Description" ReadOnly="True" />

                                <asp:TemplateField HeaderText="Student Name">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnStudentProfile" data-rel="tooltip" runat="server" CausesValidation="false" Text='<%#Eval("StudentName")%>'
                                    CommandName="Update" ToolTip="Click To View Student's Profile" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="AddedDate" HeaderText="Add On" ReadOnly="True" />
                                <asp:BoundField DataField="StudentStatus" HeaderText="Student Status" ReadOnly="True" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
            <!--/span-->

			</div>
        <!--/row-->
        
        
        
        


			
			
			
    

	</div>
    <!--/.fluid-container-->
	
    <!-- end: Content -->
    
</asp:Content>
