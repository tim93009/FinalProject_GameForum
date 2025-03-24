namespace FinalProject_GameForum.Models
{
    public class PersonalView
    {
        public User? owner { get; set; }
        public List<HistoricalVisitor>? visitors { get; set; }

        public List<User>? viewuser { get; set; }

        public List<Relationship> friends { get; set; }
        public bool Isowner { get; set; }

        public List<Relationship>? Friends { get; set; }

        public List<Relationship>? Followers { get; set; }

        public List<Relationship>? Followings { get; set; }

        public List<Relationship>? Requests { get; set; }
    }
}
