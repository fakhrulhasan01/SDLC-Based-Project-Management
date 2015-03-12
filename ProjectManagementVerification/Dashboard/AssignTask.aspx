<%@ Page Title="" Language="C#" MasterPageFile="~/ViewMaster/Dashboard.Master" ValidateRequest="false" AutoEventWireup="true" CodeBehind="AssignTask.aspx.cs" Inherits="ProjectManagementVerification.Dashboard.AssignTask" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="ProjectManagementVerification.DAL" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        input[type="text"], textarea {
            margin-left: 0;
            width: 210px;
        }

        .jstree-container-ul {
            display: block;
            margin: 0;
            padding: 0;
            list-style-type: none;
            list-style-image: none;
        }

        .hide {
            display: none;
        }

        .tree {
            margin-left: 0;
        }

        .tree,
        .branch {
            list-style: none outside none;
            margin: 4px auto;
        }

        .treeLevelOne, .treeLevelTwo, .treeLevelThree, .treeFirstLevel, .treeSecondLevel, .treeThirdLevel {
            cursor: pointer;
        }


        .treeLevelThree {
            margin-bottom: 4px;
        }

        .tree-main-root {
            margin-top: 10px;
        }




        .branch {
            position: relative;
            height: 0;
            margin: 0 0 0 24px;
            overflow: hidden;
        }

            .branch.in {
                height: auto;
                top: -1px;
                left: 0px;
            }

        a:link,
        a:visited,
        a:hover,
        a:active {
            color: #000;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
            cursor: pointer;
        }
        /* Work in progress */
        a.tree-toggle-icon-only {
            height: 16px;
            width: 20px;
            line-height: 16px;
            vertical-align: middle;
            display: inline-block;
            background: url("../img/bstree-halflings.png") no-repeat;
            background-position: 0 -22px;
        }

        a.tree-toggle {
            height: 16px;
            padding-left: 20px;
            line-height: 16px;
            vertical-align: middle;
            display: inline-block;
            background: url("../img/bstree-halflings.png") no-repeat;
            background-position: 0 -22px;
        }

            a.tree-toggle.closed, a.tree-toggle-icon-only.closed {
                background-position: 0 1px;
            }

        .fa {
            cursor: pointer;
        }

        .first-el:hover {
            text-decoration: underline;
        }

        .bborder {
            height: 100%;
            width: 4px;
            background-color: black;
        }

        .css-project {
            width: 300px;
            height: 24px;
            color: #578ebe;
            font-weight: bold;
            margin-bottom: 4px;
        }



        .css-phase {
            color: #5cb85c;
        }

        .css-checklist {
            color: #e25a59;
        }

        .feedbackContainer {
            display: block;
        }

            .feedbackContainer span {
                display: block;
            }

        .progress-bar {
            width: 200px;
            height: 18px;
            border-radius: 12px;
            background-color: black;
            position: absolute;
            margin-left: 10px;
        }

        .progress-bar-fill {
            background-color: #5cb85c;
            color: white;
            height: 100%;
            float: left;
            width: 100px;
            border-radius: 18px;
        }

        .percent-in-progress-bar {
            float: left;
            margin-left: 38%;
            color: white;
            position: absolute;
        }

        .percent-symbol {
            float: left;
            color: white;
            margin-left: 50%;
            position: absolute;
        }
    </style>


    <script>
        $(document).ready(function () {

            setTimeout(function () {
                $("#<%=lblMessage.ClientID%>").slideUp(4000);
        }, 4000);


        $(".lblAssignTask").click(function () {

            hideFeedbackContent();
            hideConfirmationContent();
            showOperationContent();
            $("#deleteConfirmation").hide();

            //Clear Previous Messages

            $("#msgTaskDescription").html("");
            $("#msgDeadline").html("");


            var checklistId = $(this).parent().find(".checklistId").text();
            var phaseId = $(this).parent().find(".phaseId").text();
            var projectId = $(this).parent().find(".projectId").text();
            var projectGroupId = $(this).parent().find(".studentGroupId").text();




            var projectName = $(this).parents(".treeLevelOne").find(".css-project").text();
            var projectPhase = $(this).parents(".treeLevelTwo").find(".css-phase").text();
            var projectChecklist = $(this).parents(".treeLevelThree").find(".css-checklist").attr("data-val");

            alert(projectChecklist);


            $("#<%=btnAssignTask.ClientID%>").show();
            $("#<%=btnUpdateTask.ClientID%>").hide();

            $("#txtPhaseId").val(phaseId);
            $("#txtChecklistId").val(checklistId);
            $("#txtProjectId").val(projectId);
            $("#txtGroupId").val(projectGroupId);


            $("#<%=txtClickCheckProject.ClientID%>").val(projectName);
                $("#<%=txtClickCheckPhase.ClientID%>").val(projectPhase);
            $("#<%=txtClickCheckChecklist.ClientID%>").val(projectChecklist);

            //Load project details to modal When assigning task
            $("#lblProjectName").text(projectName);
            $("#lblProjectPhase").text(projectPhase);
            $("#lblProjectChecklist").text(projectChecklist);


            $("#<%=txtTaskDescription.ClientID%>").val("").blur();
                $("#<%=txtDeadline.ClientID%>").val("");
            $("#ddlTaskStatusContainer").hide();
        });


        $("#<%= txtDateFrom.ClientID %>").keyup(function (e) {
            $(this).val('');
        });
        $("#<%= txtDateTo.ClientID %>").keyup(function (e) {
            $(this).val('');
        });
        $("#<%= txtDeadline.ClientID %>").keyup(function (e) {
            $(this).val('');
        });


          <%
        if (txtClickCheckProject.Text != "") //This asp:Textbox control is taken to check on which checklist is clicked
        {
          %>

        $(".treeLevelOne").children(".treeFirstLevel").hide();
        $(".treeLevelTwo").children(".treeSecondLevel").hide();
        $(".treeLevelThree").children(".treeThirdLevel").hide();
        $(".treeLevelFour").children(".treeFourLevel").hide();


        var openedProject = $("#<%= txtClickCheckProject.ClientID %>").val();
            var openedPhase = $("#<%= txtClickCheckPhase.ClientID %>").val();
        var openedChecklist = $("#<%= txtClickCheckChecklist.ClientID %>").val();
        //Check each treeLevelOne means each projects
        $(".treeLevelOne").each(function () {
            var project = $(this).children(".css-project").text();
            if (project == openedProject) {
                $(this).children(".treeFirstLevel").show();
                $(this).children(".fa").removeClass("fa-plus-square-o");
                $(this).children(".fa").addClass("fa-minus-square-o");
            }
            $(this).children().find(".treeLevelTwo").each(function () {
                var phase = $(this).children(".css-phase").text();
                if (phase == openedPhase) {
                    $(this).children(".treeSecondLevel").show();
                    $(this).children(".fa").removeClass("fa-plus-square-o");
                    $(this).children(".fa").addClass("fa-minus-square-o");
                }
                $(this).children().find(".treeLevelThree").each(function () {
                    var checklist = $(this).children(".css-checklist").text();
                    if (checklist == openedChecklist) {
                        $(this).children(".treeThirdLevel").show();
                        $(this).children(".fa").removeClass("fa-plus-square-o");
                        $(this).children(".fa").addClass("fa-minus-square-o");
                    }
                });
            });
        });

        <%
              }
              else
              {
           %>
        $(".treeLevelOne").children(".treeFirstLevel").hide();
        $(".treeLevelTwo").children(".treeSecondLevel").hide();
        $(".treeLevelThree").children(".treeThirdLevel").hide();
        $(".treeLevelFour").children(".treeFourLevel").hide();

           <% } %>

        $(".treeLevelOne").click(function (event) {
            if (event.target.className.indexOf("fa") >= 0 || event.target.className.indexOf("first-el") >= 0) {
                $(this).children(".treeFirstLevel").slideToggle("slow");
            }
        }).children().click(function (e) {
            if ($(this).hasClass("fa") || $(this).hasClass("first-el")) {
                if ($(this).hasClass("fa-plus-square-o")) {
                    $(this).attr("title", "Collapse");
                    $(this).removeClass("fa-plus-square-o");
                    $(this).addClass("fa-minus-square-o");
                } else if ($(this).hasClass("first-el")) {
                    $(this).parents(".treeLevelOne").children("fa").attr("title", "Collapse");
                    $(this).parents(".treeLevelOne").children("fa").removeClass("fa-plus-square-o");
                    $(this).parents(".treeLevelOne").children("fa").addClass("fa-minus-square-o");
                } else {
                    $(this).attr("title", "Expand");
                    $(this).removeClass("fa-minus-square-o");
                    $(this).addClass("fa-plus-square-o");
                }
            } else {
                e.stopPropagation();
            }
        });


        $(".first-el").click(function () {
            if ($(this).prev().hasClass("fa-plus-square-o")) {
                $(this).prev().removeClass("fa-plus-square-o");
                $(this).prev().addClass("fa-minus-square-o");
            } else {
                $(this).prev().removeClass("fa-minus-square-o");
                $(this).prev().addClass("fa-plus-square-o");
            }
        });


        $(".treeLevelTwo").click(function (event) {
            if (event.target.className.indexOf("fa") >= 0 || event.target.className.indexOf("first-el") >= 0) {
                $(this).children(".treeSecondLevel").slideToggle("slow");
            }
        }).children().click(function (e) {
            if ($(this).hasClass("fa") || $(this).hasClass("first-el")) {
                if ($(this).hasClass("fa-plus-square-o")) {
                    $(this).attr("title", "Collapse");
                    $(this).removeClass("fa-plus-square-o");
                    $(this).addClass("fa-minus-square-o");
                } else if ($(this).hasClass("first-el")) {
                    $(this).parents(".treeLevelTwo").children("fa").attr("title", "Collapse");
                    $(this).parents(".treeLevelTwo").children("fa").removeClass("fa-plus-square-o");
                    $(this).parents(".treeLevelTwo").children("fa").addClass("fa-minus-square-o");
                } else {
                    $(this).attr("title", "Expand");
                    $(this).removeClass("fa-minus-square-o");
                    $(this).addClass("fa-plus-square-o");
                }
            } else {
                e.stopPropagation();
            }
        });



        $(".treeLevelThree").click(function (event) {
            if (event.target.className.indexOf("fa") >= 0 || event.target.className.indexOf("first-el") >= 0) {
                $(this).children(".treeThirdLevel").slideToggle("slow");
            }
        }).children().click(function (e) {
            if ($(this).hasClass("fa") || $(this).hasClass("first-el")) {
                if ($(this).hasClass("fa-plus-square-o")) {
                    $(this).attr("title", "Expand");
                    $(this).removeClass("fa-plus-square-o");
                    $(this).addClass("fa-minus-square-o");
                } else if ($(this).hasClass("first-el")) {
                    $(this).parents(".treeLevelThree").children("fa").attr("title", "Collapse");
                    $(this).parents(".treeLevelThree").children("fa").removeClass("fa-plus-square-o");
                    $(this).parents(".treeLevelThree").children("fa").addClass("fa-minus-square-o");
                } else {
                    $(this).attr("title", "Collapse");
                    $(this).removeClass("fa-minus-square-o");
                    $(this).addClass("fa-plus-square-o");
                }
            } else {
                e.stopPropagation();
            }
        });


        $(".treeLevelFour").click(function (event) {
            if (event.target.className.indexOf("fa") >= 0 || event.target.className.indexOf("first-el") >= 0) {
                $(this).children(".treeFourLevel").slideToggle("slow");
            }
        }).children().click(function (e) {
            if ($(this).hasClass("fa") || $(this).hasClass("first-el")) {
                if ($(this).hasClass("fa-plus-square-o")) {
                    $(this).attr("title", "Expand");
                    $(this).removeClass("fa-plus-square-o");
                    $(this).addClass("fa-minus-square-o");
                } else if ($(this).hasClass("first-el")) {
                    $(this).parents(".treeLevelThree").children("fa").attr("title", "Collapse");
                    $(this).parents(".treeLevelThree").children("fa").removeClass("fa-plus-square-o");
                    $(this).parents(".treeLevelThree").children("fa").addClass("fa-minus-square-o");
                } else {
                    $(this).attr("title", "Collapse");
                    $(this).removeClass("fa-minus-square-o");
                    $(this).addClass("fa-plus-square-o");
                }
            } else {
                e.stopPropagation();
            }
        });


        //This is the event to update assigned task details
        $(".modify-task").click(function () {
            hideFeedbackContent();
            hideConfirmationContent();
            showOperationContent();
            $("#deleteConfirmation").show();


            //Clear Previous Messages
            $("#msgTaskDescription").html("");
            $("#msgDeadline").html("");


            var projectName = $(this).parents(".treeLevelOne").find(".css-project").text();
            var projectPhase = $(this).parents(".treeLevelTwo").find(".css-phase").text();
            var checklist = $(this).parents(".treeLevelOne").children().find(".css-checklist").attr("data-val");
      

            alert(projectName + " " + projectPhase + " " + checklist);

            var phaseId = $(this).parents(".treeLevelThree").find(".phaseId").text();
            var projectId = $(this).parents(".treeLevelThree").find(".projectId").text();
            var checklistId = $(this).parents(".treeLevelThree").find(".checklistId").text();
            var studentGroupId = $(this).parents(".treeLevelThree").find(".studentGroupId").text();
            var taskId = $(this).children(".taskId").text();


            //To make expand
            $("#<%=txtClickCheckChecklist.ClientID%>").val(checklist);
                $("#<%=txtClickCheckPhase.ClientID%>").val(projectPhase);
                $("#<%=txtClickCheckProject.ClientID%>").val(projectName);


                $("#lblProjectName").text(projectName);
                $("#lblProjectPhase").text(projectPhase);
                $("#lblProjectChecklist").text(checklist);


                $("#txtPhaseId").val(phaseId);
                $("#txtProjectId").val(projectId);
                $("#txtChecklistId").val(checklistId);
                $("#txtGroupId").val(studentGroupId);
                $("#txtTaskId").val(taskId);

                var taskDescription = $(this).children(".taskDescription").html();
                var taskStatus = $(this).children(".taskStatus").text();
                var taskFile = $(this).children(".taskFile").text();
                var taskDeadline = $(this).children(".deadline").text();
                if (taskFile != "") {
                    if (taskFile.indexOf("doc") >= 0) {
                        taskFile = "<a  style='color:#0000ff' target='_blank' href='../ProjectFiles/" + taskFile + "'><img src='../assetsUI/fileIcons/word.png' width='60' height='40' /> Download</a>";
                    } else if (taskFile.indexOf("pdf") >= 0) {
                        taskFile = "<a  style='color:#0000ff' target='_blank' href='../ProjectFiles/" + taskFile + "'><img src='../assetsUI/fileIcons/pdf.jpg' width='60' height='40' /> Download</a>";
                    }
                } else {
                    taskFile = "No files";
                }
                //alert(taskTitle);               

                $("#<%=txtTaskDescription.ClientID%>").val(taskDescription).blur();
                $("#<%=txtDeadline.ClientID%>").val("");
                $("#<%=txtDeadline.ClientID%>").val(taskDeadline);
                $("#<%=ddlTaskStatus.ClientID%> option[value='" + taskStatus + "']").attr('selected', 'selected');
                $("#msgTaskFile").html(taskFile);
                //$("#gate option[value='Gateway 2']").attr('selected', 'selected');



                $("#ddlTaskStatusContainer").show();

                $("#<%=btnAssignTask.ClientID%>").hide();
                $("#<%=btnUpdateTask.ClientID%>").show();

            });



        //View Task feedbacks 
        $(".feedbacks").click(function () {
            showFeedbackContent();
            hideOperationContent();
            hideConfirmationContent();

            var projectName = $(this).parents(".treeLevelOne").find(".css-project").text();
            var projectPhase = $(this).parents(".treeLevelTwo").find(".css-phase").text();
            var checklist = $(this).parents(".treeLevelOne").children().find(".css-checklist").attr("data-val");
            var task = $(this).parents(".treeLevelOne").children().find(".css-task").attr("data-val");



            var feedbackId = $(this).parents(".feedbackContainer").children(".feedbackId").text();
            var feedbackDescription = $(this).parents(".feedbackContainer").children(".feedbackDescription").text();
            var feedbackFile = $(this).parents(".feedbackContainer").children(".feedbackFile").text();
            var feedbackStudent = $(this).parents(".feedbackContainer").children(".feedbackStudentName").text();
            var feedbackDate = $(this).parents(".feedbackContainer").children(".feedbackDate").text();
            var evaluationStatus = $(this).parents(".feedbackContainer").children(".feedbackEvaluationStatus").text();
            //alert(evaluationStatus);

            $("#<%=txtFeedbackId.ClientID%>").val(feedbackId);
                $("#lblFeedbackProjectName").text(projectName);
                $("#lblFeedbackProjectPhase").text(projectPhase);
                $("#lblFeedbackProjectChecklist").text(checklist);
                $("#lblFeedbackProjectTask").text(task);

                if (feedbackFile != "") {
                    if (feedbackFile.indexOf("doc") >= 0) {
                        feedbackFile = "<a  style='color:#0000ff' target='_blank' href='../ProjectFiles/" + feedbackFile + "'><img src='../assetsUI/fileIcons/word.png' width='60' height='40' /> Download</a>";
                    } else {
                        feedbackFile = "<a  style='color:#0000ff' target='_blank' href='../ProjectFiles/" + feedbackFile + "'><img src='../assetsUI/fileIcons/pdf.jpg' width='60' height='40' /> Download</a>";
                    }
                } else {
                    feedbackFile = "No files";
                }


                $("#lblFeedbackDescription").text(feedbackDescription);
                $("#lblFeedbackDate").text(feedbackDate);
                $("#lblFeedbackFile").html(feedbackFile);
                $("#lblFeedbackSubmittedBy").text(feedbackStudent);
                //alert(evaluationStatus);
                if (evaluationStatus != "New") {
                    $("#checkedConfirm").parents(".checker").children().addClass("checked");//This lengthy code for bootstrap faulty design
                } else {
                    $("#checkedConfirm").parents(".checker").children().addClass("checked");
                }
                //$()

            });



        //Now validation for both AssignTask and UpdateTask
        var validPattern = /^[a-zA-Z0-9-_,. ]*$/i;

        $("#<%=txtTaskDescription.ClientID%>").keyup(function () {
                var txtTaskDescription = $(this).val();
                var message;
                if (!validPattern.test(txtTaskDescription)) {
                    message = "<font color='red'>Special Characters is not allowed</font>";
                } else {
                    message = "<font color='forestgreen'>Correct</font>";
                }
                $("#msgTaskDescription").html(message);
            });


            $("#deleteConfirmation").click(function () {
                hideOperationContent();
                showConfirmationContent();
            });




            function hideOperationContent() {
                $("#operationTitleContainer").slideUp();
                $("#operationBodyContainer").slideUp();
            }

            function showOperationContent() {
                $("#operationTitleContainer").fadeIn("slow");
                $("#operationBodyContainer").fadeIn("slow");
            }

            function hideConfirmationContent() {
                $("#confirmationTitleContainer").slideUp("slow");
                $("#confirmationBodyContainer").slideUp("slow");
            }

            function showConfirmationContent() {
                $("#confirmationTitleContainer").fadeIn("slow");
                $("#confirmationBodyContainer").fadeIn("slow");
            }

            function showFeedbackContent() {
                $("#feedbackTitleContainer").show();
                $("#feedbackViewContainer").show();
            }

            function hideFeedbackContent() {
                $("#feedbackTitleContainer").hide();
                $("#feedbackViewContainer").hide();
            }



            $("#cancelDelete").click(function () {
                hideConfirmationContent();
                showOperationContent();
            });


            $(".confirm-project-phase").click(function () {
                //alert("Hi");
                var thisCheckbox = $(this);
                var phaseStatus = "";
                var previousPhaseStatus = $(this).parents(".treeLevelTwo").prev().children().find(".confirm-project-phase").attr("data-text");


                var projectId = $(this).parents(".treeLevelTwo").children(".project-id").text();
                //alert(projectId);
                var phaseId = $(this).parents(".treeLevelTwo").children(".phase-id").text();
                var findProgressPercent = parseInt($(this).parents(".treeLevelOne").children(".find-percent-per-phase").text());
                var progress = parseInt($(this).parents(".treeLevelOne").children().find(".percent-in-progress-bar").text());
                var percentVisual = $(this).parents(".treeLevelOne").children().find(".progress-bar-fill");
                var progressContainer = $(this).parents(".treeLevelOne").children().find(".percent-in-progress-bar");
                //alert(progress);
                if ($(this).is(':checked')) {
                    if (previousPhaseStatus == "No") {
                        alert("Sorry! Previous phase is not completed");
                        $(this).attr("checked", false);
                        return false;
                    }
                    phaseStatus = "Checked";
                } else {
                    phaseStatus = "UnChecked";
                }
                var totalProgress;
                $.get('../View/AjaxRequestPages/TaskOperation.aspx', { phaseStatus: phaseStatus, projectId: projectId, phaseId: phaseId }, function (data) {
                    //alert(data);
                    if (data == "Successful Save") {
                        thisCheckbox.attr("data-text", "Yes");
                        totalProgress = progress + findProgressPercent;
                        progressContainer.text(totalProgress);
                        percentVisual.css("width", totalProgress + "%");
                    } else if (data == "Successful Delete") {
                        thisCheckbox.attr("data-text", "No");
                        totalProgress = progress - findProgressPercent;
                        progressContainer.text(totalProgress);
                        percentVisual.css("width", totalProgress + "%");
                    }
                });
            });


            $("#menus").click(function () {
                alert("Hello World");
                $("#cheeee").parents(".checker").children().addClass("checked");

            });

    });


        function validate() {
            var error = 0;
            var validPattern = /^[a-zA-Z0-9-_,. ]*$/i;
            var txtDeadline = $("#<%=txtDeadline.ClientID%>").val();
            var message;


            if (txtDeadline == "") {
                error++;
                message = "<font color='red'>Please select a deadline</font>";
            } else {
                message = "";
            }
            $("#msgDeadline").html(message);

            if (error > 0) {
                return false;
            } else {
                return true;
            }

        }



    </script>



    <div id="content" class="span10">
        <div class="row">
            <input type="checkbox" name="vehicle" id="cheeee" value="Bike">I have a bike
                <span id="menus">Hello World</span>

        </div>

        <ul class="breadcrumb">
            <li>
                <i class="icon-home"></i>
                <a href="index.html">Home</a>
                <i class="icon-angle-right"></i>
            </li>
            <li>
                <i class="icon-edit"></i>
                <a href="#">Forms</a>
            </li>
        </ul>

        <div class="row-fluid sortable">
            <div class="box span12">
                <div class="box-header" data-original-title>
                    <h2><i class="halflings-icon white edit"></i><span class="break"></span>Add Department</h2>
                    <div class="box-icon">
                        <a href="#" class="btn-setting"><i class="halflings-icon white wrench"></i></a>
                        <a href="#" class="btn-minimize"><i class="halflings-icon white chevron-up"></i></a>
                        <a href="#" class="btn-close"><i class="halflings-icon white remove"></i></a>
                    </div>
                </div>


                <div class="box-content">

                    <div class="span12">
                        <asp:Label ID="lblMessage" runat="server"></asp:Label><br />
                        <asp:TextBox ID="txtDateFrom" placeholder="Date From" Style="margin-top: 8px" CssClass="datepicker" runat="server"></asp:TextBox>
                        <asp:TextBox ID="txtDateTo" placeholder="Date From" Style="margin-top: 8px" CssClass="datepicker" runat="server"></asp:TextBox>
                        <asp:Button ID="btnSearchProjects" CssClass="btn btnme-success" Text="SEARCH PROJECTS" runat="server" OnClick="btnSearchProjects_Click" />
                    </div>


                    <div class="span12">
                        <div class="span6">
                            <%  
                                ProjectRegistrationDb dbProject = new ProjectRegistrationDb();
                                ProjectPhaseDb dbProjectPhase = new ProjectPhaseDb();
                                ChecklistDb dbChecklist = new ChecklistDb();
                                AssignTaskDb dbTask = new AssignTaskDb();
                                TaskFeedbackDb dbFeedback = new TaskFeedbackDb();
                                PhaseCompletionDb dbPhaseCompletion = new PhaseCompletionDb();
                                if (IsPostBack)
                                {
                                    string dateFrom = string.Empty;
                                    string dateTo = string.Empty;
                                    if (txtDateFrom.Text != string.Empty)
                                    {
                                        dateFrom = txtDateFrom.Text;
                                    }
                                    if (txtDateTo.Text != string.Empty)
                                    {
                                        dateTo = txtDateTo.Text;
                                    }
                                    DataTable dtOwnProjects = dbProject.Search(0, SessionManager.CurrentLoginTeacher.Id, string.Empty, "Active", dateFrom, dateTo);
                                    //DataTable dtOwnProjects = dbProject.GetData(string.Empty, 1, SessionManager.CurrentLoginTeacher.Id);
                            %>

                            <ul id="tree_1" class="tree">
                                <%
                                        //This loop is working for Project Name
                                        for (int i = 0; i < dtOwnProjects.Rows.Count; i++)
                                        {
                                            int projectId = Convert.ToInt32(dtOwnProjects.Rows[i]["Id"]);
                                            DataTable dtProjectPhase = dbProjectPhase.Search(Convert.ToInt32(dtOwnProjects.Rows[i]["ProjectTypeId"]),
                                                 string.Empty, 0);
                                            int perPhase = 100 / dtProjectPhase.Rows.Count;
                                            int numberOfCompletedPhase = dbPhaseCompletion.Search(projectId, 0).Rows.Count;
                                            int completion = numberOfCompletedPhase * perPhase;
                                            DataTable checklists = dbChecklist.Search(SessionManager.CurrentLoginTeacher.Id, 0, Convert.ToInt32(dtOwnProjects.Rows[i]["ProjectTypeId"]),
                                                "Active");
                                            
                                %>
                                <li class="treeLevelOne tree-main-root">
                                    <span title="Expand" class="fa fa-plus-square-o"></span><span class="first-el css-project"><% Response.Write(dtOwnProjects.Rows[i]["ProjectTitle"]); %></span>
                                    <span style="display: none" class="find-percent-per-phase"><% Response.Write(perPhase); %></span>
                                    <span class="progress-bar">
                                        <span class="percent-in-progress-bar"><% Response.Write(completion); %></span>
                                        <span class="percent-symbol">%</span><% Response.Write("<span class='progress-bar-fill' style='width:" + completion + "%'></span>"); %>
                                    </span>
                                    <ul class="branch in treeFirstLevel">

                                        <%     
                                        //This loop is working for Project Phases under Project
                                        for (int j = 0; j < dtProjectPhase.Rows.Count; j++)
                                        {
                                            int checkExist = dbPhaseCompletion.ExistingCheck(projectId, Convert.ToInt32(dtProjectPhase.Rows[j]["Id"])).Rows.Count;
                                        %>
                                        <li class="treeLevelTwo">
                                            <span title="Expand" class="fa fa-plus-square-o"></span>
                                            <span class="first-el css-phase"><% Response.Write(dtProjectPhase.Rows[j]["PhaseName"]); %></span>
                                            <span style="display: none" data-text="Yes" class="phase-id"><% Response.Write(dtProjectPhase.Rows[j]["Id"]); %></span>
                                            <span style="display: none" class="project-id"><% Response.Write(projectId); %></span>
                                            <%
                                                Response.Write(checkExist == 0 ? "<input type='checkbox' data-text='No' class='confirm-project-phase'/>" : "<input type='checkbox' data-text='Yes' checked='checked' class='confirm-project-phase'/>");
                                                Response.Write("<span class='phase-confirmation-message'>Confirmation</span>");
                                                                                              //Response.Write(perPhase);
                                            %>
                                            <ul class="treeSecondLevel branch in">
                                                <%
                                                  int projectPhaseId = Convert.ToInt32(dtProjectPhase.Rows[j]["Id"]);
                                                  DataTable dtChecklist = dbChecklist.Search(SessionManager.CurrentLoginTeacher.Id, projectPhaseId, 0, "Active");
                                                  //This loop is working for finding checklist under project
                                                  for (int k = 0; k < dtChecklist.Rows.Count; k++)
                                                  {
                                                %>
                                                <li class="treeLevelThree">
                                                    <span class="fa fa-plus-square-o" title="Expand"></span>
                                                    <%
                                                            if (dtChecklist.Rows[k]["ChecklistType"].ToString() == "Mandatory")
                                                            {
                                                    %>
                                                    <span title="Expand" class="first-el css-checklist" data-val="<% Response.Write(dtChecklist.Rows[k]["ChecklistName"]); %>"><% Response.Write(dtChecklist.Rows[k]["ChecklistName"]); %></span>
                                                    <% }
                                                            else
                                                            { %>
                                                    <span title="Expand" class="first-el css-checklist" style="color: burlywood" data-val="<% Response.Write(dtChecklist.Rows[k]["ChecklistName"]); %>"><% Response.Write(dtChecklist.Rows[k]["ChecklistName"]); %></span>
                                                    <% } %>
                                                    <span class="studentGroupId" style="display: none"><% Response.Write(dtOwnProjects.Rows[i]["GroupId"]); %></span>
                                                    <span class="phaseId" style="display: none"><% Response.Write(projectPhaseId); %></span>
                                                    <span class="checklistId" style="display: none"><% Response.Write(dtChecklist.Rows[k]["Id"]); %></span>
                                                    <span class="projectId" style="display: none"><% Response.Write(projectId); %></span>
                                                    &nbsp;&nbsp;&nbsp;<span class="label btnme-success lblAssignTask btn-setting">Assign Task</span>
                                                    <ul class="treeThirdLevel branch in">
                                                        <%
                                                            DataTable dtTask = dbTask.Search(0, Convert.ToInt32(dtChecklist.Rows[k]["Id"]), SessionManager.CurrentLoginTeacher.Id, string.Empty, 0);
                                                            if (dtTask.Rows.Count == 0)
                                                            {
                                                                Response.Write("Still Now, No tasks assigned on this checklist");
                                                            }
                                                            for (int l = 0; l < dtTask.Rows.Count; l++)
                                                            {
                                                                //Finding all Feedback against this task Later
                                                                int taskId = Convert.ToInt32(dtTask.Rows[l]["Id"]);
                                                                DataTable dtFeedbacks = dbFeedback.Search(taskId, 0);

                                                                //reading file to a variable
                                                                string descriptionData;
                                                                try
                                                                {
                                                                    descriptionData = File.ReadAllText(Server.MapPath("~/TextFiles/" + dtTask.Rows[l]["TaskDescription"]));
                                                                }
                                                                catch (Exception)
                                                                {
                                                                    descriptionData = string.Empty;
                                                                }
                                                        %>
                                                        <li class="treeLevelFour">
                                                            <i class="fa fa-tasks"></i>
                                                            <span class="fa fa-plus-square-o" title="Expand"></span>
                                                            <span data-rel="tooltip" class="first-el css-taskDescription" title="Click to View Report">
                                                                <% Response.Write(descriptionData); %>
                                                            </span>
                                                            <span class="totalFeedback"><code>Total Feedback: <% Response.Write(dtFeedbacks.Rows.Count); %></code></span>

                                                            <span class="modify-task label btn-setting">
                                                                <span style="display: none" class="taskId"><% Response.Write(dtTask.Rows[l]["Id"]); %></span>
                                                                <span style="display: none" class="taskDescription"><% Response.Write(descriptionData); %></span>
                                                                <span style="display: none" class="deadline"><% Response.Write(Convert.ToDateTime(dtTask.Rows[l]["Deadline"]).ToShortDateString()); %></span>
                                                                <span style="display: none" class="taskFile"><% Response.Write(dtTask.Rows[l]["TaskFile"]); %></span>
                                                                <span style="display: none" class="taskStatus"><% Response.Write(dtTask.Rows[l]["TaskStatus"]); %></span>
                                                                <span class="label label-default">Modify</span>
                                                            </span>

                                                            <ul class="treeFourLevel branch in">
                                                                <%
                                                                    for (int m = 0; m < dtFeedbacks.Rows.Count; m++)
                                                                    {
                                                                %>
                                                                <li>
                                                                    <span class="feedbackContainer">
                                                                        <span title="Click to view Report" class="feedbacks btn-setting">Feedback <% Response.Write(m + 1); %></span>
                                                                        <span style="display: none;" class="feedbackId"><% Response.Write(dtFeedbacks.Rows[m]["Id"]); %></span>
                                                                        <span style="display: none" class="feedbackDescription"><% Response.Write(dtFeedbacks.Rows[m]["FeedbackDescription"]); %></span>
                                                                        <span style="display: none" class="feedbackFile"><% Response.Write(dtFeedbacks.Rows[m]["FeedbackFile"]); %></span>
                                                                        <span style="display: none" class="feedbackDate"><% Response.Write(dtFeedbacks.Rows[m]["FeedbackDate"]); %></span>
                                                                        <span style="display: none" class="feedbackStudentName"><% Response.Write(dtFeedbacks.Rows[m]["StudentName"]); %></span>
                                                                        <span style="display: none" class="feedbackEvaluationStatus"><% Response.Write(dtFeedbacks.Rows[m]["EvaluationStatus"]); %></span>
                                                                    </span>
                                                                </li>
                                                                <% } %>
                                                            </ul>

                                                        </li>

                                                        <% } %>
                                                    </ul>
                                                </li>
                                                <% } //End of Third loop %>
                                            </ul>
                                        </li>
                                        <% } //End of Second loop %>
                                    </ul>
                                </li>

                                <%
                                  } //End of first loop

                                %>
                            </ul>

                            <%
                          }// If ispostback
    
                            %>

                            <br />


                        </div>
                    </div>


                    <div class="search_section">
                        <div class="right_alignment">
                        </div>
                    </div>

                    <div class="search_section">
                    </div>


                </div>
            </div>
            <!--/span-->

        </div>
        <!--/row-->









    </div>

    <!-- start: Content -->


    <!--/.fluid-container-->

    <!-- end: Content -->


    <!--Modal Start-->
    <div class="modal hide fade" id="myModal">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">×</button>
            <div id="confirmationTitleContainer">
                <i style="margin-top: -10px" class="glyphicons-icon warning_sign"></i><span style="padding-top: 40px">You are going to delete this content </span>
            </div>
            <div id="operationTitleContainer">
                <span style="display: none">
                    <asp:TextBox ID="txtClickCheckProject" runat="server"></asp:TextBox>
                    <asp:TextBox ID="txtClickCheckPhase" runat="server"></asp:TextBox>
                    <asp:TextBox ID="txtClickCheckChecklist" runat="server"></asp:TextBox>
                </span>


                <h3>Task On</h3>
                <b>Project: </b><span style="color: #578ebe" id="lblProjectName"></span>
                <br />
                <b>Phase: </b><span style="color: #5cb85c" id="lblProjectPhase"></span>
                <br />
                <b>Checklist: </b><span style="color: #e25a59" id="lblProjectChecklist"></span>
            </div>

            <div id="feedbackTitleContainer">
                <h3>Feedback On</h3>
                <b>Project: </b><span style="color: #578ebe" id="lblFeedbackProjectName"></span>
                <br />
                <b>Phase: </b><span style="color: #5cb85c" id="lblFeedbackProjectPhase"></span>
                <br />
                <b>Checklist: </b><span style="color: #e25a59" id="lblFeedbackProjectChecklist"></span>
                <br />
                <b>Task: </b><span style="color: #e25a59" id="lblFeedbackProjectTask"></span>
            </div>
        </div>
        <div class="modal-body">
            <div class="row-fluid" id="operationBodyContainer">
                <div class="span12">
                    <input type="hidden" name="txtChecklistId" id="txtChecklistId" />
                    <input type="hidden" name="txtPhaseId" id="txtPhaseId" />
                    <input type="hidden" name="txtProjectId" id="txtProjectId" />
                    <input type="hidden" name="txtGroupId" id="txtGroupId" />
                    <input type="hidden" name="txtTaskId" id="txtTaskId" />
                </div>

                <div class="span12">
                    <b>Description: </b>
                    <br />
                    <asp:TextBox placeholder="Write Task Description" TextMode="MultiLine" CssClass="cleditor" Text="Hello World" ID="txtTaskDescription" runat="server"></asp:TextBox>
                    <div id="msgTaskDescription" style="margin-bottom: 10px; height: 24px; display: block">
                    </div>
                </div>

                <div class="span12">
                    <b>Upload File: </b>
                    <br />
                    <asp:FileUpload ID="flTaskUploadFiles" runat="server" />
                    <div id="msgTaskFile" style="margin-bottom: 10px; height: auto; display: block">
                    </div>
                </div>

                <div class="span12">
                    <b>Task Deadline</b><br />
                    <asp:TextBox ID="txtDeadline" CssClass="datepicker" runat="server"></asp:TextBox>
                    <div id="msgDeadline" style="margin-bottom: 10px; display: block">
                    </div>
                </div>

                <div class="span12" id="ddlTaskStatusContainer">
                    <div class="span8">
                        <b>Task Status</b><br />
                        <asp:DropDownList ID="ddlTaskStatus" runat="server">
                            <asp:ListItem Text="Assigned"></asp:ListItem>
                            <asp:ListItem Text="Working"></asp:ListItem>
                            <asp:ListItem Text="Completed"></asp:ListItem>
                            <asp:ListItem Text="Bad"></asp:ListItem>
                            <asp:ListItem Text="Inactive"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="span12">
                    <div class="span2"></div>
                    <div class="span6">
                        <asp:Button ID="btnAssignTask" OnClientClick="return validate()" Text="ASSIGN TASK" CssClass="btn btnme-success" runat="server" OnClick="btnAssignTask_Click" />
                        <asp:Button ID="btnUpdateTask" OnClientClick="return validate()" Text="UPDATE" CssClass="btn btnme-success" runat="server" OnClick="btnUpdateTask_Click" />
                        <span id="deleteConfirmation" class="btn btn-danger">Delete</span>
                    </div>
                </div>
            </div>


            <div class="row-fluid" id="feedbackViewContainer">
                <div class="col-lg-12">
                    <input type="checkbox" id="checkedConfirm" />
                </div>
                <div class="col-lg-12">
                    <asp:TextBox ID="txtFeedbackId" runat="server" Style="display: none"></asp:TextBox>
                    <b>Feedback Description: </b><span id="lblFeedbackDescription"></span>
                </div>
                <div class="col-lg-12">
                    <b>Feedback Date: </b><span id="lblFeedbackDate"></span>
                </div>
                <div class="col-lg-12">
                    <b>Feedback Update Date: </b><span id="lblFeedbackUpdateDate"></span>
                </div>
                <div class="col-lg-12">
                    <b>Feedback File: </b><span id="lblFeedbackFile"></span>
                </div>
                <div class="col-lg-12">
                    <b>Submitted By: </b><span id="lblFeedbackSubmittedBy"></span>
                </div>

            </div>

            <div id="confirmationBodyContainer">
                <asp:Button ID="btnDeleteTask" CssClass="btn btn-action" Text="YES" runat="server" OnClick="btnDeleteTask_Click" />
                <span id="cancelDelete" class="btn btn-info">NO</span>
            </div>

            <div class="row" style="width: 100%; height: 120px">
            </div>
        </div>
        <div class="modal-footer">
            <a href="#" data-dismiss="modal" class="btn" id="close">Close</a>
        </div>
    </div>
    <!--Modal End-->

</asp:Content>
