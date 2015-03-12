<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ProjectManagementVerification.Dashboard.Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Welcome to Login page</title>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" />

    <link rel="stylesheet" href="../assets/login-assets/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="../assets/login-assets/bootstrap/css/bootstrap-theme.min.css" />
    <link rel="stylesheet" href="../assets/login-assets/css/style.css" />
    <script type="text/javascript" src="../assets/login-assets/js/jquery.js"></script>
</head>

<body>
    <form id="form1" runat="server">
        <div class="panel panel-default" id="size" style="margin-top: 5%">
            <div class="panel-heading">
                <div class="input-header-container">
                    <img class="login-lock-icon" src="../assets/login-assets/images/icons/lock.png" /><p class="login-title">LOGIN HERE</p>
                </div>
            </div>

            <div class="panel-body">
                <div class="input-wrapper">
                    <div class="form-group">
                        <div class="form-group custom-input">
                            <asp:Label ID="lblMessage" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group custom-input">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                            <asp:TextBox ID="txtUsername" class="form-control custom-form-control" placeholder="Enter username" runat="server" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group custom-input">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                            <asp:TextBox TextMode="Password" ID="txtPassword" class="form-control custom-form-control" placeholder="Enter password" runat="server" />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Button runat="server" ID="btnLogin" CssClass="btn btn-primary" Text="LOGIN" OnClick="btnLogin_Click" />
                        <a href="Default.aspx" class="btn btn-link">Cancel</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="settings">
            <img alt="" src="../assets/login-assets/images/icons/settings.PNG" />
        </div>

        <div class="expand-settings-content">
            <div class="red"></div>
            <div class="green"></div>
            <div class="blue"></div>
            <div class="common"></div>
        </div>
    </form>
    <script type="text/javascript" src="../assets/login-assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="../assets/login-assets/js/custom.js"></script>
    <script type="text/javascript" src="../assets/login-assets/bootstrap/js/bootstrap.js"></script>
</body>
</html>

