namespace FinalProject_GameForum.Models
{
    public class PersonalView
    {
        public User? owner { get; set; }
        public List<HistoricalVisitor>? visitors { get; set; }

        public List<User>? viewuser { get; set; }

        public List<Relationship>? friends { get; set; }
        public bool Isowner { get; set; }

        public string? status { get; set; }


       
    }
}
