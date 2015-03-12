<%@ Page Title="" Language="C#" MasterPageFile="../ViewMaster/DashBoard.Master" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="EditPersonalInfo.aspx.cs" Inherits="ProjectManagementVerification.Dashboard.EditPersonalInfo" %>
<%@ Import Namespace="ProjectManagementVerification.DAL" %>
<%@ Import Namespace="System.Data" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    Edit Your Personal Info
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        select, input {
            margin-left: 0;
        }

        .message-container {
            float: right;
            min-height: 16px;
            margin: 0px 112px 8px 0px;
            /*background-color: red;*/
        }        
        .fullWidth {
            width: 100%;
        }
    </style>


    <script>
        
        var fullName;
        var fullNamePattern = /^[A-Za-z0-9 '.-]+$/;

        var phone;
        var phonePattern = /^[0-9-]+(\-[0-9]+)*$/;

        var gender;

        var email;
        var emailPattern = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;

        var mobile;
        var mobilePattern = /^[0-9]+(\-[0-9]+)*$/;
        
        var country;
        var city;
        var department;
        
        var semesterInfo;




        $(document).ready(function() {
            setInterval(function() {
                $(".message-container").width($("#<%=txtFullName.ClientID%>").width()+"px");
            }, 1000);




            $('#<%=txtFullName.ClientID%>').on('input',function(e) {
                $(this).keyup();
            });


            $('#<%=ddlCountry.ClientID%>').on('input',function(e) {
                $(this).change();
            });

            $('#<%=ddlCity.ClientID%>').on('input',function(e) {
                $(this).change();
            });


            $('#<%=txtPhone.ClientID%>').on('input',function(e) {
                $(this).keyup();
            });


            $('#<%=txtMobile.ClientID%>').on('input',function(e) {
                $(this).keyup();
            });




            $('#<%=txtFullName.ClientID%>').keyup(function () {
                fullName = $(this).val();
                var errorName;

                if ((fullName.length < 3) || (fullName == "")) {
                    errorName = "<span style='color:red'>Minimum 3 characters required</span>";
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


            //Validating Telephone
            $('#<%=txtPhone.ClientID%>').keyup(function (e) {
                var errorPhone;
                phone = $(this).val();
                if (phone == "") {
                    errorPhone = "";
                }
                else if (!phonePattern.test(phone) || phone.length < 8) {
                    $(this).css("border", "1px red solid");
                    errorPhone = "<span style='color:red'>Enter correct phone number</span>";
                }
                else {
                    $(this).css("border", "1px green solid");
                    errorPhone = "<span style='color:green'>Correct</span>";
                }
                $("#msgPhone").html(errorPhone);
            });


            

            //Validating Mobile
            $('#<%=txtMobile.ClientID%>').keyup(function (e) {
                var errorMobile;
                mobile = $(this).val();
                if (mobile == "") {
                    errorMobile = "";
                }
                else if (!mobilePattern.test(mobile) || mobile.length < 8) {
                    $(this).css("border", "1px red solid");
                    errorMobile = "<span style='color:red'>Enter correct mobile number</span>";
                }
                else {
                    $(this).css("border", "1px green solid");
                    errorMobile = "<span style='color:green'>Correct</span>";
                }
                $("#msgMobile").html(errorMobile);
            });


            

            $('#<%=ddlCountry.ClientID%>').change(function() {
                var errorCountry;
                country = $('#<%=ddlCountry.ClientID%> option:selected').text();
                
                if (country == "Select") {
                    $(this).css("border", "1px red solid");
                    errorCountry = "<span style='color:red'>Please select a country</span>";
                } else {
                    errorCountry = "";
                }
                $("#msgCountry").html(errorCountry);
            });


            
            $('#<%=ddlGender.ClientID%>').change(function() {
                var errorGender;
                gender = $('#<%=ddlGender.ClientID%> option:selected').text();
                if (gender == "Select") {
                    $(this).css("border", "1px red solid");
                    errorGender = "<span style='color:red'>Please select a department</span>";
                } else {
                    errorGender = "";
                }
                $("#msgGender").html(errorGender);
            });



        });
        


        function validate() {
            var error = 0;
            fullName = $('#<%=txtFullName.ClientID%>').val();
            country = $('#<%=ddlCountry.ClientID%> option:selected').text();
            city = $('#<%=ddlCity.ClientID%> option:selected').text();
            phone = $('#<%=txtPhone.ClientID%>').val();
            mobile = $('#<%=txtMobile.ClientID%>').val();

            
            if (!fullNamePattern.test(fullName) || fullName == "") {
                error++;
            }

            if (country == "Select") {
                error++;
            }

            if (city == "Select" || city == "No City") {
                error++;
            }

            
            if (mobile == "") {
                
            }else if (!mobilePattern.test(mobile)) {
                error++;
            }


            if (phone == "") {
                
            }else if (!phonePattern.test(phone)) {
                error++;
            }

            alert(error);

            if (error > 0) {
                return false;
            } else {
                return true;
            }
            
        }


        function setOptions(chosen) {
            alert(chosen);
            <% 
                CountryDb _dbCountry = new CountryDb();
                CityDb _dbCity = new CityDb();
            %>
            var selbox = document.getElementById("MainContent_ddlCity");
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

    <div class="span10" id="content">
        
			<ul class="breadcrumb">
				<li>
					<i class="icon-home"></i>
					<a href="Welcome.aspx">Home</a>
					<i class="icon-angle-right"></i> 
				</li>
				<li>
					<i class="icon-edit"></i>
					<a href="#">Edit Your Personal Info</a>
				</li>
			</ul>
        
        <asp:Label ID="lblMessage" CssClass="fullWidth" runat="server"></asp:Label>
        <div class="row-fluid span10">
            <div class="span6">
                <span class="span3">Full Name</span>
                <div class="span8"><asp:TextBox ID="txtFullName" runat="server"></asp:TextBox></div>
                <div class="message-container" id="msgFullName"></div>
            </div>
            
            <div class="span6">
                <span class="span3">Address</span>
                <div class="span8"><asp:TextBox ID="txtAddress" runat="server"></asp:TextBox></div>
                <div class="message-container" id="msgAddress"></div>                
            </div>
        </div>
        
        
        <div class="span10">
            <div class="span6">
                <span class="span3">Country</span>
                <div class="span8">
                    <asp:DropDownList ID="ddlCountry" CssClass="form-control" onchange="setOptions($('#MainContent_ddlCountry option:selected').val());" runat="server">
                    </asp:DropDownList>
                </div>
                <div class="message-container" id="msgCountry"></div>
            </div>
            
            <div class="span6">
                <span class="span3">City</span>
                <div class="span8">
                    <asp:DropDownList ID="ddlCity" CssClass="form-control" runat="server">
                    </asp:DropDownList>
                </div>
                <div class="message-container" id="msgCity"></div>
            </div>
        </div>


        
        <div class="row-fluid span10">
            <div class="span6">
                <span class="span3">Phone No</span>
                <div class="span8"><asp:TextBox ID="txtPhone" runat="server"></asp:TextBox></div>
                <div class="message-container" id="msgPhone"></div>
            </div>
            
            <div class="span6">
                <span class="span3">Mobile No</span>
                <div class="span8"><asp:TextBox ID="txtMobile" runat="server"></asp:TextBox></div>
                <div class="message-container" id="msgMobile"></div>                
            </div>
        </div>
        
        

        <div class="span10">
            <div class="span6">
                <span class="span3">Gender</span>
                <div class="span8">
                    <asp:DropDownList ID="ddlGender" CssClass="form-control" runat="server">
                        <asp:ListItem Text="Male"></asp:ListItem>
                        <asp:ListItem Text="Female"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="message-container" id="msgGender"></div>
            </div>
            
            <div class="span6">
                <span class="span3"></span>
                <div class="span8">
                    <a href="Welcome.aspx"><i title="Back" style="margin-top: -4px" class="glyphicons-icon circle_arrow_left"></i></a>
                    <asp:Button ID="btnUpdatePersonalInfo" OnClientClick="return validate()" CssClass="btn2 btn-success" Text="UPDATE" runat="server" OnClick="btnUpdatePersonalInfo_Click"/>
                </div>
            </div>
        </div>
        

    </div>

    
</asp:Content>
