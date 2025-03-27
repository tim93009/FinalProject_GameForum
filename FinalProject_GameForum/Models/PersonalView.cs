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

        public bool Isfriend { get; set; }
        public bool IsFollow { get; set; }   
        public bool IsRequest { get; set; }
        
        public List<string>? UserArticle { get; set; }

    }
}
