namespace ProjectManagementVerification.BLL
{
    public class Blog
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string PostDate { get; set; }
        public string Tags { get; set; }
        public int PostedBy { get; set; }
        public string PostedUserType { get; set; }
        public string Picture { get; set; }
    }
}