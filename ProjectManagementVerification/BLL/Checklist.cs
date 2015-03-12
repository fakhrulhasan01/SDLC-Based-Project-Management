namespace ProjectManagementVerification.BLL
{
    public class Checklist
    {
        public int Id { get; set; }
        public int ProjectPhaseId { get; set; }
        public string ChecklistName { get; set; }
        public string ChecklistDescription { get; set; }
        public string ChecklistType { get; set; }
        public string CreationDate { get; set; }
        public int CreatedBy { get; set; }
        public string Status { get; set; }

    }
}