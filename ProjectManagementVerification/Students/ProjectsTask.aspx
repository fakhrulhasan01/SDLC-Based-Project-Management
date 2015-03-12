<%@ Page Title="" Language="C#" MasterPageFile="~/Student-Master/StudentMaster.Master" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="ProjectsTask.aspx.cs" Inherits="ProjectManagementVerification.Students.ProjectsTask" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="ProjectManagementVerification.DAL" %>
<%@ Import Namespace="ProjectManagementVerification.BLL" %>
<%@ Import Namespace="ProjectManagementVerification.SecurityFiles" %>


<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="Slide" runat="server">
    <style>
        
         .my-tooltip {
             display: block; 
             color: white; 
             margin-top: -2px; 
             padding: 2px;
             width: auto; 
             position: fixed; 
             background: rgba(0, 0, 0, 0.6); 
             opacity: inherit;
         }

         .zero-margin {
             margin-left: 0px;
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

        ul.treeThirdLevel {
            margin-top: 4px;
        }

        .tree-main-root {
            margin-top: 10px;
        }


        ul.treeFourLevel  {
            margin-top: 4px
        }

       
        .branch {
            postion: relative;
            height: 0;
            margin: 0 0 0 4px;
            overflow: hidden;
        }
        .branch.in {
            height: auto;
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
            border: 1px solid #578ebe;
            background-color: #f1f1f1;
            margin-bottom: 4px 
        }

        

        .css-phase {
            color: #5cb85c;
        }

        .css-checklist {
            color: #e25a59;
        }

        .hide {
            display: none;
        }

        .progress-bar {
            width: 200px; height: 18px; border-radius: 12px; background-color: black; position: absolute; margin-left: 10px
        }

        .progress-bar-fill {
            background-color: #5cb85c;color: white;height: 100%;float: left;width: 100px;border-radius: 18px;
        }

        .percent-in-progress-bar {
            left: 35%; color: white;position: fixed;
        }
        .percent-symbol {
            color: white;left: 37%;position: fixed;
        }

    
    /*Tooltip Design*/    
    span.tooltips {outline:none; }
	span.tooltips strong {line-height:30px;}
	span.tooltips:hover {text-decoration:none;} 
	span.tooltips p {
		z-index:10;display:none; padding:2px 2px;
		margin-top:20px; margin-left:-160px;
		width:240px; line-height:16px;
	}
	span.tooltips:hover p{
		display:inline; position:absolute; 
		border:2px solid #FFF;  color:#EEE;
		background:#333 url(cssttp/css-tooltip-gradient-bg.png) repeat-x 0 0;
	}
	.callout {z-index:20;position:absolute;border:0;top:-14px;left:100px;}
		
	/*CSS3 extras*/
	span.tooltips p
	{
		border-radius:2px;        
		box-shadow: 0px 0px 8px 4px #666;
		/*opacity: 0.8;*/
	}
    /*END Tooltip Design*/    
    </style>
    
    
    
    
    <script>
        $(document).ready(function() {
            //alert("Hi");

           /*$(".my-tooltip").hide();
            var tooltipTitle = "";
            $(".viewTask").hover(function (e) {
                var margin = $(this).css("margin-left");
                //alert(margin);
                //alert(widthPrevElement);
                tooltipTitle = $(this).attr("title");
                $(this).parents(".treeThirdLevel").children().find(".my-tooltip").html($(this).attr("title"));
                $(this).parents(".treeThirdLevel").children().find(".my-tooltip").slideDown("fast").css("margin-left", margin);
                $(this).attr("title", "");
            }, function(e) {
                $(this).parents(".treeThirdLevel").children().find(".my-tooltip").html($(this).attr("title"));
                $(this).parents(".treeThirdLevel").children().find(".my-tooltip").slideUp("fast");
                $(this).attr("title", tooltipTitle);
            });*/


            
            $(".treeLevelOne").click(function (event) {
                if ($(event.target).is('.treeTwo') || $(event.target).is('.treeThree') || $(event.target).is('.treeFour')) {
                } else {
                    if (event.target.className.indexOf("fa") >= 0 || event.target.className.indexOf("first-el") >= 0) {
                        $(this).children(".treeFirstLevel").slideToggle("slow");
                    }
                }
            });


            $(".first-el").click(function () {
                if ($(this).hasClass("treeFour")) {

                } else {
                    if ($(this).prev().hasClass("fa-plus-square-o")) {
                        $(this).prev().removeClass("fa-plus-square-o");
                        $(this).prev().addClass("fa-minus-square-o");
                    } else {
                        $(this).prev().removeClass("fa-minus-square-o");
                        $(this).prev().addClass("fa-plus-square-o");
                    }
                }
            });


            $(".fa").click(function () {
                if ($(this).hasClass("fa-plus-square-o")) {
                    $(this).removeClass("fa-plus-square-o");
                    $(this).addClass("fa-minus-square-o");
                } else {
                    $(this).addClass("fa-plus-square-o");
                    $(this).removeClass("fa-minus-square-o");
                }
            });



            $(".treeLevelTwo").click(function(event) {
                if ($(event.target).is('.treeThree') || $(event.target).is('.treeFour')) {
                    //alert("Hi");
                } else {
                    //alert("Hello");
                    if (event.target.className.indexOf("fa") >= 0 || event.target.className.indexOf("first-el") >= 0) {
                        $(this).children(".treeSecondLevel").slideToggle("slow");
                    }
                }
            });


            $(".treeLevelThree").click(function(event) {
                if ($(event.target).is('.treeFour')) {
                    //alert("Hi");
                } else {
                    //alert("Hello");
                    if (event.target.className.indexOf("fa") >= 0 || event.target.className.indexOf("first-el") >= 0) {
                        $(this).children(".treeThirdLevel").slideToggle("slow");
                    }
                }
            });

            $(".treeLevelOne").children(".treeFirstLevel").hide();
            $(".treeLevelTwo").children(".treeSecondLevel").hide();
            $(".treeLevelThree").children(".treeThirdLevel").hide();


            $(".viewTask").click(function () {
                hideFeedbackViewContainer();
                hideFeedbackContainer();
                hideDeleteConfirmation();
                showInfoContainer();

                var projectName = $(this).parents(".treeLevelOne").children(".first-el").text();
                var phaseName = $(this).parents(".treeLevelTwo").children(".first-el").text();
                var checklistName = $(this).parents(".treeLevelThree").children(".first-el").text();

                var heading = "Assigned Task<br/><font style='font-size:16px'> <b>On Project: </b>" + projectName + ", <b>Phase: </b>"
                    + phaseName + ", <b>Checklist: </b>" + checklistName+".";

                var taskFile = $(this).parents(".treeThirdLevel").children().find(".taskFile").text();
                if (taskFile != "") {
                    if (taskFile.indexOf("doc") >= 0) {
                        taskFile = "<a  style='color:#0000ff' target='_blank' href='../ProjectFiles/" + taskFile + "'><img src='../assetsUI/fileIcons/word.png' width='60' height='40' /> Download</a>";
                    } else {
                        taskFile = "<a  style='color:#0000ff' target='_blank' href='../ProjectFiles/" + taskFile + "'><img src='../assetsUI/fileIcons/pdf.jpg' width='60' height='40' /> Download</a>";
                    }
                } else {
                    taskFile = "No files";
                }
                $("#taskInfoContainerHeading").html(heading);
                $("#<%=txtTaskId.ClientID%>").val($(this).parents(".treeThirdLevel").children().find(".taskId").text());
                $("#lblTaskDescription").text($(this).parents(".treeThirdLevel").children().find(".TaskDescription").text());
                $("#lblTaskFile").html(taskFile);
                $("#lblDeadline").text($(this).parents(".treeThirdLevel").children().find(".taskDeadline").text());
            });


            $(".taskFeedback").click(function (e) {
                var taskId = $(this).parents(".treeThirdLevel").children().find(".taskId").text();
                var TaskDescription = $(this).parents(".treeThirdLevel").children().find(".TaskDescription").text();
                $("#<%=txtTaskId.ClientID%>").val(taskId);
                $("#taskFeedbackContainerHeading").text("Submit On Task: " + TaskDescription);


                //Clear fields if has file for update 
                if (!$(e.target).is(".feedbackModify")){
                    $("#<%=txtFeedbackId.ClientID%>").val("");
                    $("#<%=txtFeedback.ClientID%>").val("");                                        
                    //Hide file Link
                    $("#fileView").hide();
                    //Hide Update Button and Show Submit Button
                    $("#<%=btnSubmitFeedback.ClientID%>").show();
                    $("#<%=btnUpdate.ClientID%>").hide();
                }

                
                hideInfoContainer();
                hideFeedbackViewContainer();
                hideDeleteConfirmation();
                showFeedbackContainer();
            });



            $(".feedbacks").click(function() {
                hideInfoContainer();
                hideFeedbackContainer();
                showFeedbackViewContainer();
                hideDeleteConfirmation();

                var taskId = $(this).parents(".treeThirdLevel").children().find(".taskId").text();
                var TaskDescription = $(this).parents(".treeThirdLevel").children().find(".TaskDescription").text();
                var feedbackDescription = $(this).parents(".treeFourLevel").children().find(".feedbackDescription").text();
                var feedbackFile = $(this).parents(".treeFourLevel").children().find(".feedbackFile").html();
                var feedbackDate = $(this).parents(".treeFourLevel").children().find(".feedbackDate").text();

                

                $("#lblTaskViewTitle").text(TaskDescription);
                $("#lblFeedbackDescription").text(feedbackDescription);
                $("#lblFeedbackFile").html(feedbackFile);
                $("#lblFeedbackDate").text(feedbackDate);
            });


            $(".feedbackModify").click(function () {
                var feedbackId = $(this).parents(".treeFourLevel").children().find(".feedbackId").text();
                var feedbackDescription = $(this).parents(".treeFourLevel").children().find(".feedbackDescription").text();
                var feedbackFile = $(this).parents(".treeFourLevel").children().find(".feedbackFile").html();


                hideDeleteConfirmation();
                //Show delete confirmation button
                $("#btnDeleteConfirmation").show();

                //Hide Submit Button and show Update Button
                $("#<%=btnUpdate.ClientID%>").show();
                $("#<%=btnSubmitFeedback.ClientID%>").hide();

                //Show file Link
                $("#fileView").show();
                alert(feedbackDescription);

                $("#<%=txtFeedbackId.ClientID%>").val(feedbackId);
                $("#<%=txtFeedback.ClientID%>").val(feedbackDescription);
                $("#fileLink").html(feedbackFile);
            });


            $("#btnDeleteConfirmation").click(function() {
                hideFeedbackContainer();
                hideFeedbackViewContainer();
                hideInfoContainer();
                showDeleteConfirmation();
            });

            $("#cencelDelete").click(function() {
                showFeedbackContainer();
                hideDeleteConfirmation();
            });


            function hideFeedbackViewContainer() {
                $("#taskFeedbackViewContainerHeading").slideUp();
                $("#taskFeedbackViewContainerBody").slideUp();
            }


            function showFeedbackViewContainer() {
                $("#taskFeedbackViewContainerHeading").slideDown();
                $("#taskFeedbackViewContainerBody").slideDown();
            }


            function hideInfoContainer() {
                $("#taskInfoContainerHeading").slideUp();
                $("#taskInfoContainerBody").slideUp();
            }


            function showInfoContainer() {
                $("#taskInfoContainerHeading").slideDown();
                $("#taskInfoContainerBody").slideDown();
            }


            function hideFeedbackContainer() {
                $("#taskFeedbackContainerHeading").slideUp();
                $("#taskFeedbackContainerBody").slideUp();
            }


            function showFeedbackContainer() {
                $("#taskFeedbackContainerHeading").slideDown();
                $("#taskFeedbackContainerBody").slideDown();
            }

            function hideDeleteConfirmation() {
                $("#deleteConfirmationHeading").hide();
                $("#deleteConfirmation").hide();
            }

            function showDeleteConfirmation() {
                $("#deleteConfirmationHeading").show();
                $("#deleteConfirmation").show();
            }



            $("#<%=flUploadFiles.ClientID%>").change(function() {
                var filename = $("#<%=flUploadFiles.ClientID%>").val();
                //alert(filename);
                var extension = filename.replace(/^.*\./, '');
                if (extension == filename) {
                    extension = '';
                } else if (extension == "") {
                    $("#msgUploadFile").html("");
                } else {
                    extension = extension.toLowerCase();
                }

                if (extension == "pdf" || extension == "doc" || extension == "docx") {
                    if (extension == "pdf") {
                        $(".showFileInstant").html("<img src='../assetsUI/fileIcons/pdf.jpg' width='40%' height='80%' style='margin-left:6%' />");
                        $(".showFileInstant").append("<br/>"+filename);
                    } else {
                        $(".showFileInstant").html("<img src='../assetsUI/fileIcons/word.png' width='40%' height='80%' style='margin-left:6%' />");
                        $(".showFileInstant").append("<br/>" + filename);
                    }
                    $("#removeFile").show();
                    $("#msgUploadFile").html("");
                } else {
                    $("#msgUploadFile").html("<font color='red'>File Format not allowed</font>");
                }
            });


            $("#removeFile").click(function() {
                $(".showFileInstant").html("");
                $("#<%=flUploadFiles.ClientID%>").val();
                $(this).hide();
            });


            $("#close").click(function() {
                reset();
            });


        });



        function validate() {
            var error = 0;
            var validPattern = /^[a-zA-Z0-9-_,. ]*$/i;
            var feedback = $("#<%=txtFeedback.ClientID%>").val();
            var filename = $("#<%=flUploadFiles.ClientID%>").val();
            var extension = filename.replace(/^.*\./, '');
            if (extension == filename) {
                extension = '';
            } else {
                extension = extension.toLowerCase();
            }

            //alert(extension);
            if (extension == "pdf" || extension == "doc" || extension == "docx") {
                $("#msgUploadFile").html("");
            }else if (extension == "") {
                error++;
                $("#msgUploadFile").html("");
            } else {
                error++;
                $("#msgUploadFile").html("<font color='red'>File Format not allowed</font>");
            }


            if (feedback.length < 4) {
                error++;
                $("#msgFeedback").html("<font color='red'>Minimum 4 characters required</font>");
            }

            if (error > 0) {
                return false;
            } else {
                return true;
            }
        }


        function reset() {
            $("#msgFeedback").html("");
            $("#msgUploadFile").html("");
        }

    </script>
    
 <form id="form1" runat="server">
    
        
        
    <div class="row boxed">
        <div class="row">
            
        <div class="col-md-12">
                  <!-- BEGIN BUTTONS PORTLET-->
                  <div class="portlet box purple ">
                    <div class="portlet-title">
                      <div class="caption">
                        <i class="fa fa-gift"></i>Your Registered Projects
                      </div>
                      <div class="tools">
                        <a href="javascript:;" class="collapse">
                        </a>
                        <a href="#portlet-config" data-toggle="modal" class="config">
                        </a>
                        <a href="javascript:;" class="reload">
                        </a>
                        <a href="javascript:;" class="remove">
                        </a>
                      </div>
                    </div>

                    <div class="portlet-body util-btn-margin-bottom-5">
                      <div class="clearfix">
                        <div class="col-lg-12">
                            <asp:Label ID="lblMessage" runat="server"></asp:Label>
                            <%
                            Response.Write(DateTime.Today);    
                            %>
                        </div>
                        <ul id="tree_1" class="tree">
                        <%
                            StudentAssignToGroupDb dbStudentToGroup = new StudentAssignToGroupDb();
                            ProjectRegistrationDb dbProjectRegistration = new ProjectRegistrationDb();
                            ProjectPhaseDb dbProjectPhase = new ProjectPhaseDb();
                            ChecklistDb dbChecklist = new ChecklistDb();
                            AssignTaskDb dbTask = new AssignTaskDb();
                            TaskFeedbackDb dbFeedback = new TaskFeedbackDb();
                            PhaseCompletionDb dbPhaseCompletion = new PhaseCompletionDb(); 
                            DataTable dtFindProjects = dbStudentToGroup.Search(0, SessionManager.CurrentLoginStudent.Id, "Active",
                                string.Empty, string.Empty, 0, string.Empty);
                                
                                //Response.Write(dtFindProjects.Rows.Count+"<br/>");
                            for (int i = 0; i < dtFindProjects.Rows.Count; i++)
                            {
                                ProjectRegistration projectRegistration = dbProjectRegistration.ProjectRegistrationByGroupId(Convert.ToInt32(dtFindProjects.Rows[i]["ProjectGroupId"]));//BLL Class
                                //Response.Write(projectRegistration.ProjectTitle + "<br/>");
                                
                                if (projectRegistration != null)
                                {
                                    HashGenerator hashGenerator = new HashGenerator();
                                    string key2 = hashGenerator.Md5Hash(hashGenerator.Md5Hash(projectRegistration.Id.ToString()));
                                    string key3 = hashGenerator.Md5Hash(key2);
                                    DataTable dtProjectPhase = dbProjectPhase.Search(Convert.ToInt32(projectRegistration.ProjectTypeId),
     string.Empty, 0);
                                    int perPhase = 100 / dtProjectPhase.Rows.Count;
                                    int numberOfCompletedPhase = dbPhaseCompletion.Search(projectRegistration.Id, 0).Rows.Count;
                                    int completion = numberOfCompletedPhase * perPhase;
                                    %>
                                    <li class="treeLevelOne">
                                       <i class="fa fa-plus-square-o treeOne"></i> <span class="first-el treeOne"><% Response.Write(projectRegistration.ProjectTitle); %></span> 
                                        <span>
                                            <a href="../View/ViewProjectDetails.aspx?id=<% Response.Write(projectRegistration.Id); %>&key2=<% Response.Write(key2); %>&key3=<% Response.Write(key3); %>">H:</a>
                                        </span>
                                        <span style="display: none" class="find-percent-per-phase"><% Response.Write(perPhase); %></span>
                                        <span class="progress-bar">
                                            <span class="percent-in-progress-bar"><% Response.Write(completion); %></span>
                                            <span class="percent-symbol">%</span><% Response.Write("<span class='progress-bar-fill' style='width:"+completion+"%'></span>"); %>
                                        </span>

                                     <%
                                         DataTable dtProjectPhases = dbProjectPhase.Search(projectRegistration.ProjectTypeId, string.Empty, 0);
                                         for (int j = 0; j < dtProjectPhases.Rows.Count; j++)
                                         {
                                             int countCompletedPhase = dbPhaseCompletion.Search(projectRegistration.Id, Convert.ToInt32(dtProjectPhase.Rows[j]["Id"])).Rows.Count;
                                     %>
                                       <ul class="branch in treeFirstLevel">
                                            <li class="treeLevelTwo">
                                                <i title="Expand" class="fa fa-plus-square-o treeTwo"></i> 
                                                    <%
                                                        if (countCompletedPhase == 0)
                                                        {
                                                    %>
                                                    <span class="first-el treeTwo" style="color:#e25a59"><% Response.Write(dtProjectPhases.Rows[j]["PhaseName"]); %></span>    
                                                    <% }else{ %>
                                                    <span class="first-el treeTwo" style="color:green"><% Response.Write(dtProjectPhases.Rows[j]["PhaseName"]); %></span>
                                                    <%} %>
                                                <%
                                                   DataTable dtChecklists = dbChecklist.Search(projectRegistration.TeacherId, Convert.ToInt32(dtProjectPhases.Rows[j]["Id"]), 0, "Active");
                                                   for (int k = 0; k < dtChecklists.Rows.Count; k++)
                                                   {
                                                %>
                                                <ul class="treeSecondLevel branch in">
                                                    <li class="treeLevelThree">
                                                        <i class="fa fa-plus-square-o treeThree"></i> <span class="first-el treeThree"><% Response.Write(dtChecklists.Rows[k]["ChecklistName"]); %></span>
                                                        <%
                                                            DataTable dtTasks = dbTask.Search(0, Convert.ToInt32(dtChecklists.Rows[k]["Id"]),
                                                                projectRegistration.TeacherId, string.Empty, 0);
                                                            for (int l = 0; l < dtTasks.Rows.Count; l++)
                                                            {
                                                                string descriptionData;
                                                                try
                                                                {
                                                                    descriptionData = File.ReadAllText(Server.MapPath("~/TextFiles/" + dtTasks.Rows[l]["TaskDescription"]));
                                                                }
                                                                catch (Exception)
                                                                {
                                                                    descriptionData = string.Empty;
                                                                }

                                                                string focusTask;
                                                                if ((Convert.ToDateTime(dtTasks.Rows[l]["Deadline"]) < DateTime.Now) && ((string) dtTasks.Rows[l]["TaskStatus"] == "Assigned"))
                                                                {
                                                                    focusTask = "<font color='red'>" + descriptionData + "</font>";
                                                                }
                                                                else if ((Convert.ToDateTime(dtTasks.Rows[l]["Deadline"]) < DateTime.Now) && ((string) dtTasks.Rows[l]["TaskStatus"] == "Completed"))
                                                                {
                                                                    focusTask = "<font color='#49ac48'>" + descriptionData + "</font>";
                                                                }
                                                                else if ((Convert.ToDateTime(dtTasks.Rows[l]["Deadline"]) < DateTime.Now) && ((string)dtTasks.Rows[l]["TaskStatus"] == "Bad"))
                                                                {
                                                                    focusTask = "<font color='#e84940'>" + descriptionData + "</font>";
                                                                }
                                                                else
                                                                {
                                                                    focusTask = descriptionData;
                                                                }
                                                        %>
                                                        <ul class="treeThirdLevel branch in">
                                                            <li><span class="fa fa-tasks treeFour"></span> 
                                                                <span class="taskId hide"><% Response.Write(dtTasks.Rows[l]["Id"]); %></span>
                                                                <span class="TaskDescription treeLevelFour"><% Response.Write(focusTask); %></span>
                                                                <%
                                                                    if (dtTasks.Rows[l]["TaskFile"] != string.Empty)
                                                                    {
                                                                %>
                                                                    <span class="taskFile hide"><% Response.Write(dtTasks.Rows[l]["TaskFile"]); %></span>
                                                                <% }else{ %>
                                                                    <span class="taskFile hide"><% Response.Write("No Files Uploaded for this task"); %></span>
                                                                <% } %>
                                                                <span class="taskDeadline hide"><% Response.Write(Convert.ToDateTime(dtTasks.Rows[l]["Deadline"]).ToShortDateString()); %></span>
                                                                <span href="#myModal" data-toggle="modal" class="viewTask tooltips">
                                                                    <code class="btn-success">View</code>
                                                                    <p>
                                                                        <img class="callout" src="../assets/img/tooltip-icon-img.jpg" />
                                                                        <strong>Click To View Task Details</strong><br />
                                                                    </p>
                                                                </span>
                                                                <%
                                                                    if (countCompletedPhase == 0)
                                                                    {
                                                                %>
                                                                <span href="#myModal" data-toggle="modal" class="taskFeedback">
                                                                    <code class="green">Feedback</code>
                                                                </span>
                                                                <% } %>
                                                                <%
                                                                    DataTable dtFeedbacks = dbFeedback.Search(Convert.ToInt32(dtTasks.Rows[l]["Id"]), 0);
                                                                    if (dtFeedbacks.Rows.Count > 0)
                                                                    {
                                                                        for (int m = 0; m < dtFeedbacks.Rows.Count; m++)
                                                                        {
                                                                            
                                                                %>
                                                                 <ul class="treeFourLevel branch in">
                                                                    <li class="treeFive">
                                                                         <span class="feedbacks"><a href="#myModal" data-toggle="modal" title="Click to view tasks">Feedback <% Response.Write(m + 1); %> </a></span>
                                                                        <%
                                                                            if (countCompletedPhase == 0)
                                                                            {
                                                                        %>
                                                                         <span href="#myModal" data-toggle="modal" class="taskFeedback"><code class="feedbackModify">Modify/Update</code></span>
                                                                        <% } %>                                                                         
                                                                         <span class="feedbackId hide"><% Response.Write(dtFeedbacks.Rows[m]["Id"]); %></span>
                                                                         <span class="feedbackDescription hide"><% Response.Write(dtFeedbacks.Rows[m]["FeedbackDescription"]); %></span>
                                                                        <%
                                                                            if (dtFeedbacks.Rows[m]["FeedbackFile"] != string.Empty)
                                                                            { %>
                                                                         <span class="feedbackFile hide"><a href="../ProjectFiles/<% Response.Write(dtFeedbacks.Rows[m]["FeedbackFile"]); %>"><% Response.Write(dtFeedbacks.Rows[m]["FeedbackFile"]); %></a></span>
                                                                        <% }
                                                                            else
                                                                            { %>
                                                                         <span class="feedbackFile hide"><a href="#">No Files</a></span>
                                                                        <% } %>
                                                                         <span class="feedbackDate hide"><a href="#"><% Response.Write(dtFeedbacks.Rows[m]["FeedbackDate"]); %></a></span>
                                                                    </li>
                                                                 </ul>
                                                                <% }

                                                                    }
                                                                    else
                                                                    { %>
                                                                 <ul class="treeFourLevel branch in">
                                                                    <li class="treeFive">
                                                                        No Feedback
                                                                    </li>
                                                                 </ul>

                                                                <% } %>
                                                            </li>
                                                         </ul>
                                                        <% } %>
                                                     </li>
                                                     
                                                  </ul>
                                                <% } %>
                                              </li>
                                          </ul>
                                        <% } %>
                                       </li>
                           <% }//check if you have registered any project
                            } %>
                                    
                           </ul>
                            
                          <br/>
                          <br/>
                          
                          
                          
                            <ul id="tree_1" class="tree">
                                    <li class="treeLevelOne">
                                       <i  title="Expand"  class="fa fa-plus-square-o treeOne"></i><span class="first-el treeOne">Bootstrap Tree</span>
                                       <ul class="branch in treeFirstLevel">
                                            <li class="treeLevelTwo">
                                                <i title="Expand" class="fa fa-plus-square-o treeTwo"></i><span class="first-el treeTwo">Document</span>
                                                <ul class="treeSecondLevel branch in">
                                                    <li class="treeLevelThree">
                                                        <i class="fa fa-plus-square-o treeThree"></i><span class="first-el treeThree">Bootstrap Tree</span>
                                                        <ul class="treeThirdLevel branch in">
                                                            <li href="#contact" data-toggle="modal"><i class="fa fa-arrow-circle-up treeFour"></i><span class="first-el treeFour">HRM</span></li>
                                                            <li><i class="fa fa-arrow-circle-up treeFour"></i><span class="first-el treeFour">HumanResourceManagement</span></li>
                                                            <li><i class="icon-user"></i>Human Resources</li>
                                                         </ul>
                                                     </li>
                                                     <li><a data-role="leaf" href="#"><i class="icon-magic"></i>ICT</a></li>
                                                     <li><a data-role="leaf" href="#"><i class="icon-user"></i>Human Resources</a></li>
                                                  </ul>
                                              </li>
                                          </ul>
                                       </li>
                                    
                                </ul>
                                            
                                
                      </div>
                    
                    </div>
                  </div>
                  <!-- END BUTTONS PORTLET-->
                 
                  
               
               
                </div>

            
        </div>
    </div>

        
    
    
    
<div class="modal fade" id="myModal" role="dialog"  style="border-radius: 10px">
    	<div class="modal-dialog">
        	<div class="modal-content" id="search_teacher_container">
            	<div class="modal-header">
                	<h2 id="taskInfoContainerHeading"></h2>
                	<h2 id="taskFeedbackContainerHeading"></h2>
                    <h2 id="taskFeedbackViewContainerHeading"></h2>
                    <h2 id="taskFeedbackModifyHeader"></h2>
                    <h2 id="deleteConfirmationHeading">Are you sure??</h2>
                </div>

                <div class="modal-body">
                    <div id="taskInfoContainerBody">
                        <p><b>Task Ttile: </b><span id="lblTaskDescription"></span></p>
                        <p><b>Task Description: </b><span id="lblTaskFile"></span></p>
                        <p><b>Task Deadline: </b><span id="lblDeadline"></span></p>
                    </div>

                    <div id="taskFeedbackViewContainerBody">
                        <p><b>Task Ttile: </b><span id="lblTaskViewTitle"></span></p>
                        <p><b>Feedback Description: </b><span id="lblFeedbackDescription"></span></p>
                        <p><b>Feedback Description: </b><span id="lblFeedbackFile"></span></p>
                        <p><b>Feedback On: </b><span id="lblFeedbackDate"></span></p>
                    </div>
                        	
                    <div id="taskFeedbackContainerBody">
                        <asp:TextBox runat="server" CssClass="hide" ID="txtTaskId" ></asp:TextBox>
                        <asp:TextBox runat="server" CssClass="hide" ID="txtFeedbackId"></asp:TextBox>
                        <div class="row">
                            <div class="col-lg-12">
                                <h5 style="font-weight: bold">Your Feedback</h5>
                                <asp:TextBox ID="txtFeedback" style="height: 66px; border-radius: 20px;" CssClass="col-lg-8" TextMode="MultiLine" runat="server"></asp:TextBox>
                                <span class="col-lg-4" id="msgFeedback"></span>
                            </div>
                            
                        </div>
                        
                        
                        <div class="row">
                            <div class="col-lg-12">
                                <h5 style="font-weight: bold">Upload File <code>Allowed Files are: .doc, .docx, .pdf</code></h5>
                            <div class="fileupload fileupload-new col-lg-8" style="margin-left: 0; padding-left: 0" data-provides="fileupload">
                                <div class="showFileInstant" style="width: 60%; height: 120px; border: 1px #e8e8ec solid">
                                </div>
                                
                                <div class="col-lg-12" style="padding-bottom: 8px; margin-left: 0; padding-left:0">
                                    <span class="btn2 btn-circle btn-file btn-success">
                                        <span class="fileupload-new"  style="float: left; position: relative">Select File</span>
                                        <span class="fileupload-exists " style="float: left; position: relative">Change</span>
                                        <asp:FileUpload ID="flUploadFiles" runat="server" />
                                    </span>
                                    <a href="#" class="btn2 btn-danger fileupload-exists btn-circle" id="removeFile">Remove</a>
                                    <div class="col-lg-12" style="padding-left: 0" id="fileView">Your Uploaded File: <span id="fileLink"></span></div>  
                                </div>

                            </div>
                                <span class="col-lg-4" id="msgUploadFile"></span>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-lg-12">
                                <asp:Button OnClientClick="return validate()" style="margin-top: 12px" runat="server" CssClass="btn green" Text="SUBMIT" ID="btnSubmitFeedback" OnClick="btnSubmitFeedback_Click" />
                                <asp:Button OnClientClick="return validate()" style="margin-top: 12px" runat="server" CssClass="btn green" Text="UPDATE" ID="btnUpdate" OnClick="btnUpdate_Click" />
                                <span id="btnDeleteConfirmation" style="display:none" class="btn btn-danger">DELETE</span>
                            </div>
                        </div>
                        	
                    </div>
                    
                    <div id="deleteConfirmation">
                        <asp:Button ID="btnDeleteFeedback" Text="YES" runat="server" OnClick="btnDeleteFeedback_Click"/>
                        <span id="cencelDelete" class="btn btn-info">No</span>
                    </div>

                    <div id="taskFeedbackModifyBody">
                    </div>
                    

                <div class="modal-footer">
                	<a class="btn2 btn-success" id="close" data-dismiss="modal">Close</a>
                </div>
            </div>

        	

          
        </div>
    </div>     
     
   </div>
     

    </form>
    
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="Middle" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="Bottom" runat="server">
</asp:Content>
