<%@ Page Title="" Language="C#" MasterPageFile="~/UI-Master/UIMaster.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ProjectManagementVerification.View.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
   
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    
    <style>
        
        .login {
            border-radius: 6px;
            margin: 0px auto;
            box-shadow: 4px 6px 10px rgba(0,0,0,.8);
            -moz-box-shadow:4px 6px 10px rgba(0,0,0,.8);
            -webkit-box-shadow:4px 6px 10px rgba(0,0,0,.8);
            -khtml-box-shadow:4px 6px 10px rgba(0,0,0,.8);
        }


        #teacher-login-heading {
            background: #2b8b3a;
            color: black;
            width: 50%;padding-top: 2%;padding-bottom: 2%;
            float: left;position: relative;
            text-align: center;font-size: 22px;font-weight: bold; cursor: pointer
        }

        #student-login-heading {
            background: #808080;
            color: white;
            width: 100%;padding-top: 2%;padding-bottom: 2%;
            float: left;position: relative;  
            text-align: center;font-size: 22px;font-weight: bold; cursor: pointer
        }

        .login-heading {
            margin: 0 0 0 0;
            padding: 0;
            box-shadow: 4px 6px 10px rgba(0,0,0,.8);
            -moz-box-shadow:4px 6px 10px rgba(0,0,0,.8);
            -webkit-box-shadow:4px 6px 10px rgba(0,0,0,.8);
            -khtml-box-shadow:4px 6px 10px rgba(0,0,0,.8);
        }
        
    </style>
    
    
    <script>
       
    </script>
    

     <form id="form1" runat="server">
         <div class="container">
             
             <div class="row">
                 <div class="col-md-4"></div>
                 <div class="col-lg-4 login-heading">
                     <span id="student-login-heading">Student Login</span>
                 </div>
                 <div class="col-md-4"></div>
             </div>
             

             
             <div class="row" id="student-login-container">
                 <div class="col-md-4"></div>
                 <div class="col-md-4  login" style="background-color: #808080">
                     <h4 style="width: 90%; margin: 4%;"><asp:Label runat="server" ID="lblMessage"></asp:Label></h4>
                     
                     <div class="portlet-body form">
                        <div class="input-group" style="width: 90%; margin: 4%">
                          <span class="input-group-addon">
                            <i class="fa fa-envelope"></i>
                          </span>
                          <asp:TextBox ID="txtEmail" CssClass="form-control" placeholder="Email Address" runat="server"></asp:TextBox>
                        </div>
                     
                        <div class="input-group" style="width: 90%; margin: 4%">
                          <span class="input-group-addon">
                            <i class="fa fa-lock"></i>
                          </span>
                          <asp:TextBox ID="txtPassword" CssClass="form-control" placeholder="Your Password" TextMode="Password" runat="server"></asp:TextBox>
                        </div>
                     
                        <div class="form-actions right" style="width: 92%; margin: 4%; background-color: #808080">
                            <asp:Button runat="server" CssClass="btn green" ID="btnLogin" Text="LOGIN" OnClick="btnLogin_Click"/>
                        </div>
                    </div>
                 </div>
                 
                 <div class="col-md-4"></div>
             </div>
             

         </div>

         <br/>
         <br/>
         
         <br/>
        
        
        
         
         <br/>
         <br/>
         
         
         <br/>
         
         
         
     </form>
</asp:Content>



<asp:Content runat="server" ContentPlaceHolderID="Bottom">
<div class="container">
        <div class="row">
          <!-- BEGIN BOTTOM ABOUT BLOCK -->
          <div class="col-md-4 col-sm-6 pre-footer-col">
            <h2>About us</h2>
            <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam sit nonummy nibh euismod tincidunt ut laoreet dolore magna aliquarm erat sit volutpat.</p>

            <div class="photo-stream">
              <h2>Photos Stream</h2>
              <ul class="list-unstyled">
                <li><a href="#"><img alt="" src="../assetsUI/frontend/pages/img/people/img5-small.jpg"></a></li>
                <li><a href="#"><img alt="" src="../assetsUI/frontend/pages/img/works/img1.jpg"></a></li>
                <li><a href="#"><img alt="" src="../assetsUI/frontend/pages/img/people/img4-large.jpg"></a></li>
                <li><a href="#"><img alt="" src="../assetsUI/frontend/pages/img/works/img6.jpg"></a></li>
                <li><a href="#"><img alt="" src="../assetsUI/frontend/pages/img/works/img3.jpg"></a></li>
                <li><a href="#"><img alt="" src="../assetsUI/frontend/pages/img/people/img2-large.jpg"></a></li>
                <li><a href="#"><img alt="" src="../assetsUI/frontend/pages/img/works/img2.jpg"></a></li>
                <li><a href="#"><img alt="" src="../assetsUI/frontend/pages/img/works/img5.jpg"></a></li>
                <li><a href="#"><img alt="" src="../assetsUI/frontend/pages/img/people/img5-small.jpg"></a></li>
                <li><a href="#"><img alt="" src="../assetsUI/frontend/pages/img/works/img1.jpg"></a></li>
                <li><a href="#"><img alt="" src="../assetsUI/frontend/pages/img/people/img4-large.jpg"></a></li>
                <li><a href="#"><img alt="" src="../assetsUI/frontend/pages/img/works/img6.jpg"></a></li>
                <li><a href="#"><img alt="" src="../assetsUI/frontend/pages/img/works/img3.jpg"></a></li>
                <li><a href="#"><img alt="" src="../assetsUI/frontend/pages/img/people/img2-large.jpg"></a></li>
                <li><a href="#"><img alt="" src="../assetsUI/frontend/pages/img/works/img2.jpg"></a></li>
              </ul>                    
            </div>
          </div>
          <!-- END BOTTOM ABOUT BLOCK -->

          <!-- BEGIN BOTTOM CONTACTS -->
          <div class="col-md-4 col-sm-6 pre-footer-col">
            <h2>Our Contacts</h2>
            <address class="margin-bottom-40">
              35, Lorem Lis Street, Park Ave<br>
              California, US<br>
              Phone: 300 323 3456<br>
              Fax: 300 323 1456<br>
              Email: <a href="mailto:info@metronic.com">info@metronic.com</a><br>
              Skype: <a href="skype:metronic">metronic</a>
            </address>

            <div class="pre-footer-subscribe-box pre-footer-subscribe-box-vertical">
              <h2>Newsletter</h2>
              <p>Subscribe to our newsletter and stay up to date with the latest news and deals!</p>
              <form action="#">
                <div class="input-group">
                  <input type="text" placeholder="youremail@mail.com" class="form-control">
                  <span class="input-group-btn">
                    <button class="btn btn-primary" type="submit">Subscribe</button>
                  </span>
                </div>
              </form>
            </div>
          </div>
          <!-- END BOTTOM CONTACTS -->

          <!-- BEGIN TWITTER BLOCK --> 
          <div class="col-md-4 col-sm-6 pre-footer-col">
            <h2 class="margin-bottom-0">Latest Tweets</h2>
            <a class="twitter-timeline" href="https://twitter.com/twitterapi" data-tweet-limit="2" data-theme="dark" data-link-color="#57C8EB" data-widget-id="455411516829736961" data-chrome="noheader nofooter noscrollbar noborders transparent">Loading tweets by @keenthemes...</a>
          </div>
          <!-- END TWITTER BLOCK -->
        </div>
      </div>
</asp:Content>