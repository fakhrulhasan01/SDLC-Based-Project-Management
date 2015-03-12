namespace ProjectManagementVerification.BLL
{
    public class ProjectRegistration
    {
        public int Id { get; set; }
        public string ProjectTitle { get; set; }
        public string ProjectSummary { get; set; }
        public int GroupId { get; set; }
        public int TeacherId { get; set; }
        public int ProjectTypeId { get; set; }
        public string RegistrationDate { get; set; }
        public string Status { get; set; }
        public int ProgressStatus { get; set; }

    }
}