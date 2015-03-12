<%@ Page Title="" Language="C#" MasterPageFile="~/UI-Master/UIMaster.Master" AutoEventWireup="true" CodeBehind="StudentRegistrationTwo.aspx.cs" Inherits="ProjectManagementVerification.View.StudentRegistrationTwo" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="ProjectManagementVerification.DAL" %>


<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="Main" runat="server">
    <style type="text/css">
        
         .registration {
             width: 80%;
             height: auto;
             margin: 16px auto;
         }

        .multi-rows {
            -webkit-transition: all 0.7s ease;
            transition: all 0.7s ease;
        }

        .multi-rows:focus {
            top:0;
            left:0;
            height:60px;
            border-radius:5px;
            border: 2px solid #d4d0ba;
            box-shadow: 0px 0px 15px #FFFFFF;
        }

        .wrong {
            border: 1px red solid;
        }
        .correct {
            border: 1px green solid;
        }


        /* color or background image for all browsers, of course */            


          #main_registration {
            left: 0;
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
            background-size: cover;
            width: 100%;
            transition: background 2s linear;
            -moz-transition: background 2s linear;
	        -ms-transition: background 2s linear;
	        -webkit-transition: background 2s linear;
	        -o-transition: background 2s linear;
	        filter: alpha(opacity=20);        
        }

        /*#main_registration {
            -webkit-transition: 3s ease;
            -moz-transition: 3s ease;
            -o-transition: 3s ease;
            -ms-transition: 3s ease;
            transition: 3s ease;
        }*/
        


        /***************For Box Shadow Effect********************/

        #Example_P {
            /*-moz-box-shadow: -12px 12px 18px rgba(0, 0, 0, 0.5);
            -webkit-box-shadow: -12px 12px 18px rgba(0, 0, 0, 0.5);
            box-shadow: -12px 12px 18px rgba(0, 0, 0, 0.5);
            margin-bottom: 20px;*/
            margin-bottom: 20px;            
        }

        #dynamic_height {
            -moz-box-shadow: -12px 12px 18px rgba(0, 0, 0, 0.5);
            -webkit-box-shadow: -12px 12px 18px rgba(0, 0, 0, 0.5);
            box-shadow: -12px 12px 18px rgba(0, 0, 0, 0.5);
            opacity: 0.6;
        }
    </style>
    
    <%-- ReSharper disable once WrongExpressionStatement --%>
    <script>
        var fullName;
        var fullNamePattern = /([0-9a-zA-Z.\s])$/;

        var studentId;
        var studentIdPattern = /^[0-9]\d{2}-\d{2}-\d{2,6}$/;

        var gender;

        var email;
        var emailPattern = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;

        var password;
        var passwordSecond;
        
        var country;
        var city;
        var department;
        
        var semesterInfo;

        //Validating Student Full Name
        $(document).ready(function() {

            

            setInterval(function() {
                var h = $("#Example_P").height()+"px";
                var w = $("#Example_P").width()+"px";

                $("#dynamic_height").css("background-color","#000");
                $("#dynamic_height").height(h);
                $("#dynamic_height").width(w);
            }, 40);
            
            $('#<%=txtFullName.ClientID%>').on('input',function(e) {
                $(this).keyup();
            });


            $('#<%=txtStudentId.ClientID%>').on('input',function(e) {
                $(this).keyup();
            });


            $('#<%=txtPassword.ClientID%>').on('input',function(e) {
                $(this).keyup();
            });


            $('#<%=txtConfirmPassword.ClientID%>').on('input',function(e) {
                $(this).keyup();
            });


            $('#<%=txtEmail.ClientID%>').on('input',function(e) {
                $(this).keyup();
            });

            
            $('#<%=txtSemesterInfo.ClientID%>').on('input',function(e) {
                $(this).keyup();
            });



            $('#<%=txtFullName.ClientID%>').keyup(function () {
                fullName = $(this).val();
                var errorName;

                if ((fullName.length < 3) || (fullName == "")) {
                    errorName = "<span style='color:red'>Minimum 3 characters required</span>";
                    $(this).addClass("wrong");
                } else if (!fullNamePattern.test(fullName)) {
                    errorName = "<span style='color:red'>Special Character is not allowed</span>";
                    $(this).addClass("wrong");
                } else {
                    errorName = "<span style='color:#5cb85c'>OK</span>";
                    $(this).addClass("correct");
                }
                $("#msgFullName").html(errorName);
                
            });


            //Validating Student Id
            $('#<%=txtStudentId.ClientID%>').keyup(function () {
                var errorStudentId;
                studentId = $(this).val();
                if (!studentIdPattern.test(studentId) || studentId == "") {
                    errorStudentId = "<span style='color:red'>Invalid student ID</span>";
                    $(this).addClass("wrong");
                } else {
                    errorStudentId = "<span style='color:#5cb85c'>Correct</span>";
                    $(this).addClass("correct");
                }
                $("#msgStudentId").html(errorStudentId);
            });


            //Validating Email Address
            $('#<%=txtEmail.ClientID%>').keyup(function () {
                email = $(this).val();
                var errorEmail;
                if (!emailPattern.test(email) || email == "") {
                    errorEmail = "<sapn style='color:red'>Please enter correct email</sapn>";
                    $(this).addClass("wrong");
                } else {
                    errorEmail = "<span style='color:#5cb85c'>OK</span>";
                    $(this).addClass("right");
                }
                $("#msgEmail").html(errorEmail);
            });


            //Validating Password
            $('#<%=txtPassword.ClientID%>').keyup(function () {
                password = $(this).val();
                var errorPassword;
                if (password.length < 8 || password == "") {
                    errorPassword = "<span style='color:red'>Password is too small</span>";
                    $(this).addClass("wrong");
                } else {
                    errorPassword = "<span style='color:#5cb85c'>OK!</span>";
                    $(this).addClass("correct");
                }
                $("#msgPassword").html(errorPassword);
                //alert(fLength);
            });

            //Validating Confirm Password
            $('#<%=txtConfirmPassword.ClientID%>').keyup(function () {
                var passwordFirst = $('#<%=txtPassword.ClientID%>').val();
                passwordSecond = $(this).val();
                var errorPassword;
                if (passwordFirst != passwordSecond) {
                    errorPassword = "<span style='color:red'>Password doesn't match</span>";
                    $(this).addClass("wrong");
                } else if (passwordFirst == "") {
                    errorPassword = "<span style='color:red'>Please fill the password field</span>";
                    $('#<%=txtPassword.ClientID%>').addClass("wrong");
                } else {
                    errorPassword = "<span style='color:#5cb85c'>Matched!</span>";
                    $('#<%=txtConfirmPassword.ClientID%>').addClass("correct");
                    $(this).addClass("correct");
                }
                $("#msgPassword").html(errorPassword);
                //alert(fLength);
            });

            //Validating Semester Info
            $('#<%=txtSemesterInfo.ClientID%>').keyup(function () {
                semesterInfo = $(this).val();
                var errorSemesterInfo;
                if (semesterInfo == "") {
                    errorSemesterInfo = "<span style='color:red'>Can't leave this field blank</span>";
                    $(this).addClass("wrong");
                } else {
                    errorSemesterInfo = "<span style='color:#5cb85c'>OK</span>";
                    $(this).addClass("correct");
                }
                $("#msgSemesterInfo").html(errorSemesterInfo);
                //alert(fLength);
            });

            //alert(error);

            $('#<%=ddlCountry.ClientID%>').change(function() {
                var errorCountry;
                country = $('#<%=ddlCountry.ClientID%> option:selected').text();
                
                if (country == "Select Country") {
                    errorCountry = "<span style='color:red'>Please select a country</span>";
                    $(this).css("border", "1px red solid");
                } else {
                    errorCountry = "";
                    $(this).css("border", "1px #5cb85c solid");
                }
                $("#msgCountry").html(errorCountry);
            });

            
            $('#<%=ddlDepartment.ClientID%>').change(function() {
                var errorDepartment;
                department = $('#<%=ddlDepartment.ClientID%> option:selected').text();
                if (department == "Select Department") {
                    errorDepartment = "<span style='color:red'>Please select a department</span>";
                    $(this).css("border", "1px red solid");
                } else {
                    errorDepartment = "";
                    $(this).css("border", "1px #5cb85c solid");
                }
                $("#msgDepartment").html(errorDepartment);
            });


            $('#<%=ddlGender.ClientID%>').change(function() {
                var errorGender;
                gender = $('#<%=ddlGender.ClientID%> option:selected').text();
                if (gender == "Select Gender") {
                    errorGender = "<span style='color:red'>Please select a department</span>";
                    $(this).css("border", "1px red solid");
                } else {
                    errorGender = "";
                    $(this).css("border", "1px #5cb85c solid");
                }
                $("#msgGender").html(errorGender);
            });





            /****************SlideShow Made by me********************/
            $("#main_registration").css("background-image", "url("+"'SlideImage/1.jpg'"+")");
            setInterval(function() {
                var img = $("#main_registration").css("background-image");
                //img = img.slice(-6);
                //alert(img);
                var setImg;
                if ((img.indexOf("1.jpg") >= 0)) {
                    $("#main_registration").css("background-image", "url(" + "'SlideImage/2.jpg'" + ")").fadeIn();
                }else if (img.indexOf("2.jpg") >= 0) {
                    $("#main_registration").css("background-image", "url("+"'SlideImage/3.jpg'"+")").fadeIn('slow', 1);
                }else if (img.indexOf("3.jpg") >= 0) {
                    $("#main_registration").css("background-image", "url("+"'SlideImage/1.jpg'"+")").fadeIn('slow', 1);
                }
                
            }, 4000);


        });


        function Validate() {
            var error = 0;

            fullName = $('#<%=txtFullName.ClientID%>').val();
            studentId = $('#<%=txtStudentId.ClientID%>').val();
            email = $('#<%=txtEmail.ClientID%>').val();
            password = $('#<%=txtPassword.ClientID%>').val();

            country = $('#<%=ddlCountry.ClientID%> option:selected').text();
            city = $('#<%=ddlCity.ClientID%> option:selected').text();
            gender = $('#<%=ddlGender.ClientID%> option:selected').text();
            department = $('#<%=ddlDepartment.ClientID%> option:selected').text();

            //alert(country);

            semesterInfo = $('#<%=txtSemesterInfo.ClientID%>').val();
            
                
            if (fullName == "" || !fullNamePattern.test(fullName)) {
                error++;
            }

            if (studentId == "" || !studentIdPattern.test(studentId)) {
                error++;
            }

            if (email == "" || !emailPattern.test(email)) {
                error++;
            }

            if (password == "" || password.length < 8 || password != passwordSecond) {
                error++;
            }

            if (department == "Select Department") {
                error++;
            }

            if (gender == "Select Gender") {
                error++;
            }

            if (semesterInfo == "") {
                error++;
            }

            if (country == "Select Country") {
                error++;
            }

            if (city == "Please select country first" || city == "No City") {
                error++;
            }
            //alert(error);
            if (error > 0) {
                $("#confirmation").html("<span style='color:red'>Fill all required fields</span><br/>"+error);
                return false;
            } else {
                return true;
            }
        } 
        

        //****Script for cascading DropdownList****//
        function setOptions(chosen) {
            <% 
                CountryDb _dbCountry = new CountryDb();
                CityDb _dbCity = new CityDb();
            %>
            var selbox = document.getElementById("Main_ddlCity");
            selbox.options.length = 0;
            if (chosen == "Select") {
                selbox.options[selbox.options.length] = new Option('Please select country first', '0');
            }
            <%
                DataTable dtCountry = _dbCountry.GetData(string.Empty, 1);
                for (int i = 0; i < dtCountry.Rows.Count; i++)
                {
            %>
            if (chosen == <% Response.Write(dtCountry.Rows[i][0].ToString()); %>) {
                //alert(chosen);
                <%
                     var dtCity = _dbCity.Search(string.Empty, Convert.ToInt32(dtCountry.Rows[i][0]));
                     if (dtCity.Rows.Count > 0)
                     {
                         for (var j = 0; j < dtCity.Rows.Count; j++)
                         { %>
                            selbox.options[selbox.options.length] = new Option("<% Response.Write(dtCity.Rows[j][1]); %>", "<% Response.Write(dtCity.Rows[j][0]); %>");
                        <% }
                     }
                     else
                     {
                         %>
            selbox.options[selbox.options.length] = new Option('No City', '0');
                        <%
                     }
                %>
        }
        <%
          }
          %>
        }

    </script>
    
<form id="form1" runat="server">
<!--<div id="main_registration" style="position:absolute; width:100%; height:100%"></div>   -->
<!--<div class="row boxed" id="main_registration">-->
    <div class="row boxed">    
        <div class="row boxed">
            <div class="form-group">
                
                <div class="col-lg-7" id="Example_P" style="float:right; margin-top:20px">
                <div class="col-lg-12" style="position: absolute" id="dynamic_height"></div>    
                    <div class="col-lg-12">
                        <h2 style="color: #ffffff">Student Registration</h2>
                        <h3 id="confirmation"></h3>
                    </div>
                    <div class="col-lg-6">
                        <div class="col-lg-12"><asp:TextBox ID="txtFullName" placeholder="Please Enter Full Name" CssClass="form-control" runat="server"></asp:TextBox></div>
                        <div id="msgFullName" class="col-lg-12 inputValidator">
                        </div>
                    </div>

                
                    <div class="col-lg-6">
                        <div class="col-lg-12">
                                <asp:TextBox ID="txtStudentId" placeholder="Please Enter Student ID" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>                    
                        <div id="msgStudentId" class="col-lg-12 inputValidator"></div>
                    </div>
                

                    <div class="col-lg-6">
                        <div class="col-lg-12">
                                <asp:DropDownList runat="server" ID="ddlGender" CssClass="form-control chzn-container chzn-container-single">
                                    <asp:ListItem Text="Select Gender"></asp:ListItem>
                                    <asp:ListItem Text="Male"></asp:ListItem>
                                    <asp:ListItem Text="Female"></asp:ListItem>
                                </asp:DropDownList>
                        </div>                    
                        <div id="msgGender" class="col-lg-12 inputValidator"></div>
                    </div>
                
                
                    <div class="col-lg-6">
                        <div class="col-lg-12">
                                <asp:TextBox ID="txtEmail" placeholder="Email: example@gmail.com" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>                    
                        <div id="msgEmail" class="col-lg-12 inputValidator"></div>
                    </div>
                
                
                    <div class="col-lg-6">
                        <div class="col-lg-12">
                                <asp:TextBox ID="txtPassword" placeholder="Enter Password" TextMode="Password" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>                    
                        <div id="msgPassword" class="col-lg-12 inputValidator"></div>
                    </div>
                

                    <div class="col-lg-6">
                        <div class="col-lg-12">
                                <asp:TextBox ID="txtConfirmPassword" placeholder="Confirm Password" TextMode="Password" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>                    
                        <div id="msgConfirmPassword" class="col-lg-12 inputValidator"></div>
                    </div>
                
                
                    <div class="col-lg-6">
                        <div class="col-lg-12">
                                        <asp:DropDownList ID="ddlCountry" onchange="setOptions($('#Main_ddlCountry option:selected').val());" runat="server" 
                                            CssClass="form-control chzn-container chzn-container-single" AutoPostBack="False">
                                        </asp:DropDownList>
                        </div>                    
                        <div id="msgCountry" class="col-lg-12 inputValidator"></div>
                    </div>
                
                
                    <div class="col-lg-6">
                        <div class="col-lg-12">
                                        <asp:DropDownList ID="ddlCity" runat="server" CssClass="form-control chzn-container chzn-container-single">
                                        </asp:DropDownList>
                                
                        </div>                    
                        <div id="msgCity" class="col-lg-12 inputValidator"></div>
                    </div>
                
                
                    <div class="col-lg-6">
                        <div class="col-lg-12">
                                <div class="fileupload fileupload-new" data-provides="fileupload">
                                    <div class="fileupload-preview thumbnail" style="width: 100%; height: 100px;"></div>
                                    <div>
                                        <span class="btn2 btn-file btn-success">
                                            <span class="fileupload-new">Select image</span>
                                            <span class="fileupload-exists">Change</span>
                                            <asp:FileUpload ID="flStudentImage" runat="server" />
                                        </span>
                                        <a href="#" class="btn2 btn-danger fileupload-exists" data-dismiss="fileupload">Remove</a>
                                    </div>

                                </div>
                        </div>                    
                        <div id="msgUploadImage"></div>
                    </div>
                
                
                    <div class="col-lg-6">
                        <div class="col-lg-12">
                                <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control">
                                </asp:DropDownList>
                        </div>                    
                        <div id="msgDepartment" class="col-lg-12 inputValidator"></div>
                    </div>
                
                
                    <div class="col-lg-6">
                        <div class="col-lg-12">
                                <asp:TextBox ID="txtSemesterInfo" placeholder="Semester Info e.g, Level-4, Term-2" CssClass="form-control multi-rows" runat="server"></asp:TextBox>
                        </div>                    
                        <div id="msgSemesterInfo" class="col-lg-12 inputValidator"></div>
                    </div>
                

                    <div class="col-lg-6">
                            <asp:Button CssClass="btn2 btn-primary btn-large" style="float:right; margin:2% 3% 0 0; font-weight: bold" ID="btnRegister" 
                            OnClientClick="return Validate()" Text="REGISTER" runat="server" OnClick="btnRegister_Click" />                    
                    </div>
                    
                </div>
            </div>
        </div>

</div>
</form>
</asp:Content>


