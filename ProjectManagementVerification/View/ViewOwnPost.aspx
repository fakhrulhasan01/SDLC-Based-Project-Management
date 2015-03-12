<%@ Page Language="C#" MasterPageFile="~/UI-Master/UIMaster.Master" ValidateRequest="false" AutoEventWireup="true" CodeBehind="ViewOwnPost.aspx.cs" Inherits="ProjectManagementVerification.View.ViewOwnPost" %>
<%@ Import Namespace="System.IO" %>


<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="server">
 <form id="form1" runat="server">
        <div class="container">
            <ul class="breadcrumb">
                <li><a href="index.html">Home</a></li>
                <li><a href="#">Blog</a></li>
                <li class="active">Blog Page</li>
            </ul>
            <!-- BEGIN SIDEBAR & CONTENT -->
            <div class="row margin-top-20">
                <!-- BEGIN CONTENT -->
                <div class="col-md-12 col-sm-12">
                    <div class="content-page">
                        <div class="row">
                            <div class="col-sm-12">
                                <h2>Your Posts</h2>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12 col-sm-12">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" PageSize="3" AllowPaging="true"
                            CssClass="table table-bordered table-hover" DataKeyNames="Id" EmptyDataText="No Search Result Found" 
                            OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing"  PagerStyle-CssClass="paging"
                            OnPageIndexChanging="GridView1_PageIndexChanging">
                            <Columns>
                                <asp:TemplateField HeaderText="Edit" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="30px">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgEdit" runat="server" CausesValidation="false" CommandArgument='<%#Eval("Id")%>' CommandName="Edit" ImageUrl="../assets/img/edit.png" Text="Hi" ToolTip="Edit" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="30px">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgDel" runat="server" CausesValidation="false" CommandArgument='<%#Eval("Id")%>' CommandName="Delete" ImageUrl="../assets/img/delete.png" onClientClick="return confirm('Are you sure??')" ToolTip="Delete" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="Title" HeaderText="Post Title" ReadOnly="True" />
                                <asp:TemplateField HeaderText="Delete" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="30px">
                                    <ItemTemplate>
                                        <p><%#File.ReadAllText(Server.MapPath("~/TextFiles/BlogTextFiles/" + Eval("Description"))) %></p>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="PostDate" HeaderText="Posted On" ReadOnly="True" />
                                <asp:BoundField DataField="Tags" HeaderText="Tags" ReadOnly="True" />
                                <asp:TemplateField HeaderText="Delete" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="30px">
                                    <ItemTemplate>
                                            <img src="../View/BlogImages/<%# Eval("Picture") %>" height="120" width="200"/>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                                
                            </div>
                        </div>
                        
                    </div>
                </div>
            </div>

        </div>
    </form>
</asp:Content>