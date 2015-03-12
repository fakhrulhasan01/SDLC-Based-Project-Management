namespace ProjectManagementVerification.BLL
{
    public class ProjectRequest
    {
        public int StudentId { get; set; }
        public int TeacherId { get; set; }
        public string StudentMessage { get; set; }
        public string ApprovalStatus { get; set; }
        public string RequestDate { get; set; }
        public string ConfirmationDate { get; set; }
        public int Status { get; set; }
    }
}