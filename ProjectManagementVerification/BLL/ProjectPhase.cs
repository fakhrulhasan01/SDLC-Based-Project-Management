namespace ProjectManagementVerification.BLL
{
    public class ProjectPhase
    {
        public int Id { get; set; }
        public int ProjectTypeId { get; set; }
        public string PhaseName { get; set; }
        public string PhaseDescription { get; set; }
        public int Priority { get; set; }
        public string CreationDate { get; set; }

    }
}