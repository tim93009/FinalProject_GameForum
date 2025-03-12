namespace FinalProject_GameForum.Models
{
    public class TempArticle
    {
        public string? Name { get; set; }
        public string? TempName { get; set; }
        public string? Content { get; set; }
        public string? Url { get; set; }
        public TempArticle(string _Name, string _TempName, string _Content, string? Url)
        {
            Name = _Name;
            TempName = _TempName;
            Content = _Content;
            this.Url = Url;
        }
    }
}
