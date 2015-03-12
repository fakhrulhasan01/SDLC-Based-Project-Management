<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/UI-Master/UIMaster.Master" CodeBehind="WebForm1.aspx.cs" Inherits="ProjectManagementVerification.View.WebForm1" %>

<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">

    <script type="text/javascript" src="../assets/tinymce/tinymce.min.js"></script>
    <script type="text/javascript">
        tinymce.init({
            selector: ".editor",
            theme: "modern",
            plugins: [
                "advlist autolink lists link image charmap print preview hr anchor pagebreak",
                "searchreplace wordcount visualblocks visualchars code fullscreen",
                "insertdatetime media nonbreaking save table contextmenu directionality",
                "emoticons template paste textcolor colorpicker textpattern"
            ],
            toolbar1: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image",
            toolbar2: "print preview media | forecolor backcolor emoticons",
            image_advtab: true,
            templates: [
                { title: 'Test template 1', content: 'Test 1' },
                { title: 'Test template 2', content: 'Test 2' }
            ]
        });
    </script>

    <form id="form1" runat="server">
        <div class="container">
            <ul class="breadcrumb">
                <li><a href="index.html">Home</a></li>
                <li><a href="#">Blog</a></li>
                <li class="active">Blog Page</li>
            </ul>
            <!-- BEGIN SIDEBAR & CONTENT -->
            <div class="row margin-bottom-40">
                <!-- BEGIN CONTENT -->
                <div class="col-md-12 col-sm-12">
                    <div class="content-page">
                        <div class="row">
                            <div class="col-sm-12">
                                <h2>Post On Blog</h2>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-6">
                                <asp:TextBox ID="txtBlogContent" CssClass="editor" runat="server"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </form>
</asp:Content>
