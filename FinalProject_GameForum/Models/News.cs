using System;
using System.Collections.Generic;

namespace FinalProject_GameForum.Models;

public partial class News
{
    public int NewsId { get; set; }

    public string NewsTitle { get; set; } = null!;

    public string NewsContent { get; set; } = null!;

    public string? ImageUrl { get; set; }

    public DateTime? EditDate { get; set; }

    public string? Category { get; set; }

    public virtual ICollection<NewsImage> NewsImages { get; set; } = new List<NewsImage>();

    public virtual ICollection<NewsMessage> NewsMessages { get; set; } = new List<NewsMessage>();
}
public class NewsViewModel
{
    public List<News> NewsHome { get; set; } = new List<News>();
    public List<News> NewsDetail { get; set; } = new List<News>();
}