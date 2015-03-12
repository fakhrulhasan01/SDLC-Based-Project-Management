<%@ Page Language="C#" MasterPageFile="~/UI-Master/UIMaster.Master" ValidateRequest="false" AutoEventWireup="true" CodeBehind="PostOnBlog.aspx.cs" Inherits="ProjectManagementVerification.View.PostOnBlog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Main" runat="server">
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


        function validate() {
            var error = 0;
            tinyMCE.triggerSave();
            var title = $("#<%=txtBlogTitle.ClientID%>").val();
            var content = $('.editor').val();
            if (title.length < 6) {
                error++;
                $("#msgTitle").html("<font color='red'>Title must be greater then six characters.</font>");
            }
            if (content.length < 15) {
                error++;
                $("#msgContent").html("<font color='red'>Description must be greater than 15 characters</font>");
            } else {
                $("#msgContent").html("");
            }
            if (error > 0) {
                return false;
            } else {
                return true;
            }
        }
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
                                <asp:Label ID="lblMessage" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-4">
                                <asp:TextBox ID="txtBlogTitle" CssClass="form-control" MaxLength="200" placeholder="Blog Title" runat="server"></asp:TextBox>
                            </div>
                            <div id="msgTitle" class="col-lg-4"></div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-8">
                                <asp:TextBox placeholder="Enter Description" ID="txtBlogContent" style="height: 240px" CssClass="editor" runat="server"></asp:TextBox>
                            </div>
                            <div id="msgContent" class="col-lg-4"></div>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-lg-4">
                                <asp:TextBox placeholder="Enter Tags" CssClass="form-control" ID="txtTags" runat="server"></asp:TextBox>
                                <div id="msgTags" class="help-block">Helop </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="fileupload fileupload-new" data-provides="fileupload">
                                    <div class="fileupload-preview thumbnail" style="width: 200px; height: 150px;"></div>
                                    <div>
                                        <span class="btn2 btn-file btn-success">
                                            <span class="fileupload-new">Select image</span>
                                            <span class="fileupload-exists">Change</span>
                                            <asp:FileUpload ID="flBlogImage" runat="server" />
                                        </span>
                                        <a href="#" class="btn2 btn-danger fileupload-exists" data-dismiss="fileupload">Remove</a>
                                    </div>
                                </div>                                
                            </div>
                        </div>
                        

                        <div class="row">
                            <div class="col-lg-6">
                                <asp:Button ID="btnPost" CssClass="btn btn-success" Text="SUBMIT YOUR PROBLEM" OnClientClick="return validate()" runat="server" OnClick="btnPost_Click"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </form>
</asp:Content>