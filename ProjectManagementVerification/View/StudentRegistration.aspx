<%@ Page Title="" Language="C#" MasterPageFile="~/UI-Master/UIMaster.Master" AutoEventWireup="true" CodeBehind="StudentRegistration.aspx.cs" Inherits="ProjectManagementVerification.View.StudentRegistration" EnableEventValidation="false" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="ProjectManagementVerification.DAL" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Slide" runat="server">
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
            background-color:#000030;
            top:0;
            left:0;
            height:80px;
            border-radius:5px;
            border: 2px solid #d4d0ba;
            box-shadow: 0px 0px 15px #FFFFFF;
        }


        /* color or background image for all browsers, of course */            


        #main_registration {
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
            background-size: cover;
            width: 100%;
            transition: background 2s linear;
            
	        filter: alpha(opacity=20);        
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
                    errorName = "<span style='color:red'>Name must be greater than three characters</span>";
                    $(this).css("border", "1px red solid");
                } else if (!fullNamePattern.test(fullName)) {
                    errorName = "<span style='color:red'>Special Character is not allowed</span>";
                    $(this).css("border", "1px red solid");
                } else {
                    errorName = "<span style='color:green'>OK</span>";
                    $(this).css("border", "1px green solid");
                }
                $("#msgFullName").html(errorName);
                
            });


            //Validating Student Id
            $('#<%=txtStudentId.ClientID%>').keyup(function () {
                var errorStudentId;
                studentId = $(this).val();
                if (!studentIdPattern.test(studentId) || studentId == "") {
                    errorStudentId = "<span style='color:red'>Invalid student ID</span>";
                } else {
                    errorStudentId = "<span style='color:green'>Correct</span>";
                }
                $("#msgStudentId").html(errorStudentId);
            });


            //Validating Email Address
            $('#<%=txtEmail.ClientID%>').keyup(function () {
                email = $(this).val();
                var errorEmail;
                if (!emailPattern.test(email) || email == "") {
                    errorEmail = "<sapn style='color:red'>Please enter correct email</sapn>";
                } else {
                    errorEmail = "<span style='color:green'>OK</span>";
                }
                $("#msgEmail").html(errorEmail);
            });


            //Validating Password
            $('#<%=txtPassword.ClientID%>').keyup(function () {
                password = $(this).val();
                var errorPassword;
                if (password.length < 8 || password == "") {
                    errorPassword = "<span style='color:red'>Password is too small</span>";
                } else {
                    errorPassword = "<span style='color:green'>OK!</span>";
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
                } else if (passwordFirst == "") {
                    errorPassword = "<span style='color:red'>Please fill the password field</span>";
                } else {
                    errorPassword = "<span style='color:green'>Matched!</span>";
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
                } else {
                    errorSemesterInfo = "<span style='color:green'>OK</span>";
                }
                $("#msgSemesterInfo").html(errorSemesterInfo);
                //alert(fLength);
            });

            //alert(error);

            $('#<%=ddlCountry.ClientID%>').change(function() {
                var errorCountry;
                country = $('#<%=ddlCountry.ClientID%> option:selected').text();
                
                if (country == "Select") {
                    errorCountry = "<span style='color:red'>Please select a country</span>";
                } else {
                    errorCountry = "";
                }
                $("#msgCountry").html(errorCountry);
            });

            
            $('#<%=ddlDepartment.ClientID%>').change(function() {
                var errorDepartment;
                department = $('#<%=ddlDepartment.ClientID%> option:selected').text();
                if (department == "Select") {
                    errorDepartment = "<span style='color:red'>Please select a department</span>";
                } else {
                    errorDepartment = "";
                }
                $("#msgDepartment").html(errorDepartment);
            });


            $('#<%=ddlGender.ClientID%>').change(function() {
                var errorGender;
                gender = $('#<%=ddlGender.ClientID%> option:selected').text();
                if (gender == "Select") {
                    errorGender = "<span style='color:red'>Please select a department</span>";
                } else {
                    errorGender = "";
                }
                $("#msgGender").html(errorGender);
            });





            /****************SlideShow Made by me********************/
            $("#main_registration").css("background-image", "url("+"'SlideImage/1.jpg'"+")");
            setInterval(function() {
                var img = $("#main_registration").css("background-image");
                img = img.slice(-6);
                //alert(img);
                var setImg;
                if (img == "1.jpg)") {
                    $("#main_registration").css("background-image", "url("+"'SlideImage/2.jpg'"+")").fadeIn('slow', 1);;
                }else if (img == "2.jpg)") {
                    $("#main_registration").css("background-image", "url("+"'SlideImage/3.jpg'"+")").fadeIn('slow', 1);;
                }else if (img == "3.jpg)") {
                    $("#main_registration").css("background-image", "url("+"'SlideImage/1.jpg'"+")").fadeIn('slow', 1);;
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

            if (department == "Select") {
                error++;
            }

            if (gender == "Select") {
                error++;
            }

            if (semesterInfo == "") {
                error++;
            }

            if (country == "Select") {
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
            var selbox = document.getElementById("Slide_ddlCity");
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
<div  style="position:absolute; width:100%; height:100%"></div>   

<div class="container">
        <div class="row boxed">
            <h2 id="confirmation"></h2>
            <h2>Student Registration</h2>
        </div>
        
        <div class="row boxed">
            <div class="form-group">
                <div class="col-lg-6">
                    <label class="col-lg-4">Full Name</label>
                    <div class="col-lg-8"><asp:TextBox ID="txtFullName" placeholder="Please Enter Full Name" CssClass="form-control" runat="server"></asp:TextBox></div>
                    <span class="col-lg-4"></span>
                    <div id="msgFullName" class="col-lg-8 inputValidator">
                    </div>
                </div>
                
                <div class="col-lg-6">
                    <label class="col-lg-4">Student ID</label>
                    <div class="col-lg-8">
                            <asp:TextBox ID="txtStudentId" placeholder="Please Enter Student ID" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>                    
                    <span class="col-lg-4"></span>
                    <div id="msgStudentId" class="col-lg-8 inputValidator"></div>
                </div>
                
                

                <div class="col-lg-6">
                    <label class="col-lg-4">Gender</label>
                    <div class="col-lg-8">
                            <asp:DropDownList runat="server" ID="ddlGender" CssClass="form-control chzn-container chzn-container-single">
                                <asp:ListItem Text="Select"></asp:ListItem>
                                <asp:ListItem Text="Male"></asp:ListItem>
                                <asp:ListItem Text="Female"></asp:ListItem>
                            </asp:DropDownList>
                    </div>                    
                    <span class="col-lg-4"></span>
                    <div id="msgGender" class="col-lg-8 inputValidator"></div>
                </div>
                
                
                <div class="col-lg-6">
                    <label class="col-lg-4">Email</label>
                    <div class="col-lg-8">
                            <asp:TextBox ID="txtEmail" placeholder="example@gmail.com" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>                    
                    <span class="col-lg-4"></span>
                    <div id="msgEmail" class="col-lg-8 inputValidator"></div>
                </div>
                
                
                

                <div class="col-lg-6">
                    <label class="col-lg-4">Password</label>
                    <div class="col-lg-8">
                            <asp:TextBox ID="txtPassword" placeholder="Enter Password" TextMode="Password" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>                    
                    <span class="col-lg-4"></span>
                    <div id="msgPassword" class="col-lg-8 inputValidator"></div>
                </div>
                
                <div class="col-lg-6">
                    <label class="col-lg-4">Confirm Password</label>
                    <div class="col-lg-8">
                            <asp:TextBox ID="txtConfirmPassword" placeholder="Confirm Password" TextMode="Password" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>                    
                    <span class="col-lg-4"></span>
                    <div id="msgConfirmPassword" class="col-lg-8 inputValidator"></div>
                </div>
                
                
                <div class="col-lg-6">
                    <label class="col-lg-4">Country</label>
                    <div class="col-lg-8">
                                    <asp:DropDownList ID="ddlCountry" onchange="setOptions($('#Slide_ddlCountry option:selected').val());" runat="server" 
                                        CssClass="form-control chzn-container chzn-container-single" AutoPostBack="False">
                                    </asp:DropDownList>
                    </div>                    
                    <span class="col-lg-4"></span>
                    <div id="msgCountry" class="col-lg-8 inputValidator"></div>
                </div>
                
                
                <div class="col-lg-6">
                    <label class="col-lg-4">City</label>
                    <div class="col-lg-8">
                                    <asp:DropDownList ID="ddlCity" runat="server" CssClass="form-control chzn-container chzn-container-single">
                                    </asp:DropDownList>
                                
                        </div>                    
                    <span class="col-lg-4"></span>
                    <div id="msgCity" class="col-lg-8 inputValidator"></div>
                </div>
                
                
                <div class="col-lg-6">
                    <label class="col-lg-4">Upload Image</label>
                    <div class="col-lg-8">
                            <div class="fileupload fileupload-new" data-provides="fileupload">
                                <div class="fileupload-preview thumbnail" style="width: 200px; height: 150px;"></div>
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
                    <span class="col-lg-4"></span>
                    <div id="msgUploadImage"></div>
                </div>
                
                
                <div class="col-lg-6">
                    <label class="col-lg-4">Department</label>
                    <div class="col-lg-8">
                            <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control">
                            </asp:DropDownList>
                    </div>                    
                    <span class="col-lg-4"></span>
                    <div id="msgDepartment" class="col-lg-8 inputValidator"></div>
                </div>
                
                
                <div class="col-lg-6">
                    <label class="col-lg-4">Semester Info</label>
                    <div class="col-lg-8">
                            <asp:TextBox ID="txtSemesterInfo" placeholder="e.g, Level-4, Term-2" CssClass="form-control multi-rows" runat="server"></asp:TextBox>
                    </div>                    
                    <span class="col-lg-4"></span>
                    <div id="msgSemesterInfo" class="col-lg-8 inputValidator"></div>
                </div>
                
                <div class="col-lg-6">
                        <asp:Button CssClass="btn2 btn-default btn-large" style="float:right; margin:2% 3% 0 0; font-weight: bold" ID="btnRegister" 
                        OnClientClick="return Validate()" Text="REGISTER" runat="server" OnClick="btnRegister_Click" />                    
                
                </div>
            </div>
        </div>

</div>
</form>
</asp:Content>


