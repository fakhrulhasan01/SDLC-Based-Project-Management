namespace ProjectManagementVerification.BLL
{
    public class AssignTask
    {
        public int Id { get; set; }
        public int ChecklistId { get; set; }
        public int TeacherId { get; set; }
        public int ProjectId { get; set; }
        public int StudentGroupId { get; set; }
        public string TaskDescription { get; set; }
        public string TaskFile { get; set; }
        public string AssignDate { get; set; }
        public string Deadline { get; set; }
        public string TaskStatus { get; set; }

    }
}