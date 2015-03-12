<%@ Page Title="" Language="C#" EnableEventValidation="false" MasterPageFile="~/Student-Master/StudentMaster.Master" AutoEventWireup="true" CodeBehind="EditPersonalInfo.aspx.cs" Inherits="ProjectManagementVerification.Students.EditPersonalInfo" %>
<%@ Import Namespace="ProjectManagementVerification.DAL" %>
<%@ Import Namespace="System.Data" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    Edit Your Personal Information
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="Slide" runat="server">
    <style>
        .control-label {
            text-align: right;
        }
    </style>
    
    
    <script>
        //Client Script for cascading dropdownList
        $(document).ready(function() {
            
        });

        function Validate() {
            var error = 0;
            var city = $("#<%=ddlCity.ClientID%> option:selected").text();
            if (city == "No City") {
                $("#msgCity").html("<span style='color:red'>Please select a valid city</span>");
                error++;
            }

            if (error == 0) {
                return true;
            } else {
                return false;
            }
        }


        function setOptions(chosen) {
            alert("Hi");
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
        <div class="row boxed">
            
            <div class="form-group col-lg-6">
                <label for="MainContent_UserName" class="col-md-4 control-label">Full Name</label>
                <div class="col-md-8">
                    <asp:TextBox ID="txtFullName" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col-md-4"></div>
                <div class="col-md-8 msg" id="msgFullName"></div>
            </div>
            
            <div class="form-group col-lg-6">
                <label for="MainContent_UserName" class="col-md-4 control-label">Address</label>&nbsp;<div class="col-md-8">
                    <asp:TextBox ID="txtAddress" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col-md-4 msg"></div>
                <div class="col-md-8 msg" id="msgAddress"></div>
            </div>
            
            <div class="form-group col-lg-6">
                <label for="MainContent_UserName" class="col-md-4 control-label">Father Name</label>
                <div class="col-md-8">
                    <asp:TextBox ID="txtFatherName" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col-md-4"></div>
                <div class="col-md-8 msg" id="msgFatherName"></div>
            </div>
            
            <div class="form-group col-lg-6">
                <label for="MainContent_UserName" class="col-md-4 control-label">Mother Name</label>
                <div class="col-md-8">
                    <asp:TextBox ID="txtMotherName" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col-md-4"></div>
                <div class="col-md-8 msg" id="msgMotherName"></div>
            </div>
            
            <div class="form-group col-lg-6">
                <label for="MainContent_UserName" class="col-md-4 control-label">Gender</label>
                <div class="col-md-8">
                    <asp:DropDownList ID="ddlGender" CssClass="form-control" runat="server">
                    </asp:DropDownList>
                </div>
                <div class="col-md-4"></div>
                <div class="col-md-8 msg" id="msgGender"></div>
            </div>
            
            
            <div class="form-group col-lg-6">
                <label for="MainContent_UserName" class="col-md-4 control-label">Date of Birth</label>
                <div class="col-md-8">
                    <asp:TextBox ID="txtDateOfBirth" placeholder="YYYY-MM-DD" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col-md-4"></div>
                <div class="col-md-8 msg" id="msgDateOfBirth"></div>
            </div>
            
            

            <div class="form-group col-lg-6">
                <label for="MainContent_UserName" class="col-md-4 control-label">Country</label>
                <div class="col-md-8">
                    <asp:DropDownList ID="ddlCountry" CssClass="form-control" onchange="setOptions($('#Slide_ddlCountry option:selected').val());" runat="server">
                    </asp:DropDownList>
                </div>
                <div class="col-md-4"></div>
                <div class="col-md-8 msg" id="msgCountry"></div>
            </div>
            

            <div class="form-group col-lg-6">
                <label for="MainContent_UserName" class="col-md-4 control-label">City</label>
                <div class="col-md-8">
                    <asp:DropDownList ID="ddlCity" CssClass="form-control" runat="server">
                    </asp:DropDownList>
                </div>
                <div class="col-md-4"></div>
                <div class="col-md-8 msg" id="msgCity"></div>
            </div>

            
            <div class="form-group col-lg-6">
                <label for="MainContent_UserName" class="col-md-4 control-label">Phone No</label>
                <div class="col-md-8">
                    <asp:TextBox ID="txtPhoneNo" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col-md-4"></div>
                <div class="col-md-8 msg" id="msgPhoneNo"></div>
            </div>
            
            
            
            <div class="form-group col-lg-6">
                <label for="MainContent_UserName" class="col-md-4 control-label">Mobile No</label>
                <div class="col-md-8">
                    <asp:TextBox ID="txtMobileNo" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col-md-4"></div>
                <div class="col-md-8 msg" id="msgMobileNo"></div>
            </div>
            
            <div class="form-group col-lg-6">
                <label for="MainContent_UserName" class="col-md-4 control-label">Mobile No</label>
                <div class="col-md-8">
                    <asp:Button ID="btnUpdate" Text="UPDATE" OnClientClick="return Validate()" CssClass="form-control" runat="server" OnClick="btnUpdate_Click"></asp:Button>
                </div>
                <div class="col-md-4"></div>
                <div class="col-md-8 msg" id="msgMobileNo"></div>
            </div>
            
            
            

        </div>
    </form>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Middle" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="Bottom" runat="server">
</asp:Content>
