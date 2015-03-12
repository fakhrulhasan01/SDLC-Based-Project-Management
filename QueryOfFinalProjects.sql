use ProjectManagement

create table Country(
	Id int not null identity,
	Name varchar(60) not null,

	Constraint PkCountryId Primary Key(Id)
)
create table City(
	Id int not null identity,
	Name varchar(60) not null,
	CountryId int not null,


	Constraint PkCityId Primary Key(Id),
	Constraint FkCountryIdInCity Foreign Key(CountryId) references Country(Id)
)

create table Department(
	Id int not null identity,
	Name varchar(60) not null,
	Constraint PkDepartmentId Primary Key(Id)
)

create table Student(
	Id int not null identity,
	FullName nvarchar(60) not null,
	StudentId varchar(40) not null,
	FatherName varchar(40) null,
	MotherName varchar(40) null,
	Gender varchar(6) not null,
	Email varchar(60) not null,
	Password varchar(60) not null,
	Address nvarchar(400) null,
	CityId int not null,
	DepartmentId int not null,
	Telephone varchar(14) null,
	Mobile varchar(14) null,
	SemisterInfo varchar(60) null,
	DateOfBirth date null,
	JoinDate datetime default getdate(),
	Status int not null,


	Constraint PkStudentId Primary Key(Id),
	Constraint UkStudentEmail Unique(Email),
	Constraint FkCityIdInStudent Foreign Key(CityId) references City(Id),
	Constraint FkDepartmentIdInStudent Foreign Key(DepartmentId) references Department(Id)
)

drop table student

create table Teacher(
	Id int not null identity,
	FullName nvarchar(60) not null,
	EmployeeId varchar(40) not null,
	Gender varchar(6) not null,
	Designation varchar(40) not null,
	Email varchar(60) not null,
	Password varchar(60) not null,
	Address nvarchar(400) null,
	CityId int not null,
	DepartmentId int not null,
	Telephone varchar(14) null,
	Mobile varchar(14) null,
	JoinDate datetime default getdate(),
	Status int not null,
	
	Constraint PkTeacherId Primary Key(Id),
	Constraint FkCityIdInTeacher Foreign Key(CityId) references City(Id),
	Constraint FkDepartmentIdInTeacher Foreign Key(DepartmentId) references Department(Id)
)


create table ProjectRequest(
	StudentId int not null,
	TeacherId int not null,
	StudentMessage varchar(max),
	ApprovalStatus varchar(10) not null,

	Constraint PkJoinStudentIdTeacherId Primary Key(StudentId, TeacherId),
	Constraint FkStudentIdInProjectRequest Foreign Key(StudentId) references Student(Id),
	Constraint FkTeacherIdInProjectRequest Foreign Key(TeacherId) references Teacher(Id)
)

drop table CreateStudentGroup

create table CreateStudentGroup(
	GroupId varchar(40) not null,
	StudentId int not null,
	GroupTitle varchar(60) not null,
	CreatedBy int not null,
	CreationDate datetime default getdate(),
	GroupType varchar(12) not null,
	GroupStatus varchar(12) not null,

	Constraint PkCreateStudentGroupId Primary Key(GroupId, StudentId),
	Constraint FkStudentIdInCreateStudentGroup Foreign Key(StudentId) references Student(Id),
	Constraint FkTeacherIdInCreateStudentGroup Foreign Key(CreatedBy) references Teacher(Id)
)

sp_helpconstraint 'CreateStudentGroup';


create table ProjectType(
	Id int not null identity,
	Name varchar(200) not null,
	Constraint PkProjectTypeId Primary Key(Id),
	Constraint UkProjectTypeName Unique(Name)
)


create table ProjectPhase(
	Id int not null identity,
	ProjectTypeId int not null,
	PhaseName varchar(120) not null,
	PhaseDescription varchar(max) null,
	Priority varchar(20) not null,
	CreationDate datetime default getdate(),
	
	Constraint PkProjectPhaseId Primary Key(Id),
	Constraint FkProjectTypeIdInProjectPhase Foreign Key(ProjectTypeId) references ProjectType(Id),
)


create table ProjectRegistration(
	Id int not null identity,
	ProjectTitle varchar(200) not null,
	ProjectSummary varchar(max) null,
	TeacherId int not null,
	GroupId varchar(40) not null,
	StudentId int not null,
	ProjectTypeId int not null,
	SelectionDate datetime not null,
	Status varchar(10) not null,

	Constraint PkProjectRegistrationId Primary Key(Id),
	Constraint FkGroupIdInProjectRegistration Foreign Key(GroupId, StudentId) references CreateStudentGroup(GroupId, StudentId),
	Constraint FkProjectTypeIdInProjectRegistration Foreign Key(ProjectTypeId) references ProjectType(Id),
	Constraint FkTeacherIdInProjectRegistration Foreign Key(TeacherId) references Teacher(Id)
)


create table ProjectPhase(
	Id int not null identity,
	ProjectTypeId int not null,
	PhaseName varchar(120) not null,
	PhaseDescription varchar(max) null,
	Priority varchar(20) not null,
	CreationDate datetime default getdate(),
	
	Constraint PkProjectPhaseId Primary Key(Id),
	Constraint FkProjectTypeIdInProjectPhase Foreign Key(ProjectTypeId) references ProjectType(Id),
)


create table Checklist(
	Id int not null identity,
	ProjectPhaseId int not null,
	ChecklistName varchar(200) not null,
	ChecklistDescription varchar(max) null,
	ChecklistType varchar(14) not null,
	CreationDate datetime default getdate(),
	CreatedBy int not null,

	Constraint PkChecklistId Primary Key(Id),
	Constraint FkProjectPhaseIdInChecklist Foreign Key(ProjectPhaseId) references ProjectPhase(Id),
	Constraint FkTeacherIdInChecklist Foreign Key(CreatedBy) references Teacher(Id)
)


create table ChecklistSelection(
	ProjectId int not null,
	ChecklistId int not null,
	SelectedBy int not null,
	SelectionDate datetime default getdate(),

	Primary key(ProjectId, ChecklistId),
	Foreign key(ProjectId) references ProjectRegistration(Id),
	Foreign Key(ChecklistId) references Checklist(Id),
	Foreign Key(SelectedBy) references Teacher(Id)
)

create table AssignTask(
	Id int not null identity,
	ChecklistId int not null,
	TeacherId int not null,
	StudentGroupId varchar(40) not null,
	StudentId int not null,
	ProjectId int not null,
	TaskTitle varchar(400) not null,
	TaskDescription varchar(max) null,
	Deadline date not null,
	IsComplete varchar(10) not null,
	

	Constraint PkAssignTaskId Primary Key(Id),
	Constraint FkTeacherIdInAssingTask Foreign Key(TeacherId) references Teacher(Id),
	Constraint FkStudentGroupIdInAssignTask Foreign Key(StudentGroupId, StudentId) references CreateStudentGroup(GroupId, StudentId),
	Constraint FkProjectIdInAssignTask Foreign Key(ProjectId) references ProjectRegistration(Id)
)

create table TaskFeedback(
	Id int not null identity,
	TaskId int not null,
	StudentGroupId varchar(40) not null,
	StudentId int not null,
	Feedback varchar(max) not null,
	SubmissionDate datetime default getdate(),
	
	Constraint PkTaskFeedbackId Primary Key(Id),
	Constraint FkCompositeGroupIdStudentIdInTaskFeedback Foreign Key(StudentGroupId, StudentId) references CreateStudentGroup(GroupId, StudentId),
	Constraint FkTaskIdInTaskFeedback Foreign Key(TaskId) references AssignTask(Id)
)

create table CommonBlog(
	Id int not null identity,
	PostTitle varchar(200) null,
	PostDescription varchar(max) not null,
	PostedUserId int not null,
	PostedUserType varchar(12) not null,
	
	Primary Key(Id) 
)