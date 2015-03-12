namespace ProjectManagementVerification.BLL
{
    public class TaskFeedback
    {
        public int Id { get; set; }
        public int TaskId { get; set; }
        public string FeedbackDescription { get; set; }
        public string FeedbackFile { get; set; }
        public string FeedbackDate { get; set; }
        public string UpdateDate { get; set; }
        public string EvaluationStatus { get; set; }
        public int StudentId { get; set; }

    }
}