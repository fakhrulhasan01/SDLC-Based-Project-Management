namespace ProjectManagementVerification.BLL
{
    public class CreateProjectGroup
    {
        public int Id { get; set; }

        public string GroupId { get; set; }
        public string Description { get; set; }
        public string GroupType { get; set; }
        public int CreatedBy { get; set; }
        public string CreationDate { get; set; }
        public string Status { get; set; }

    }
}