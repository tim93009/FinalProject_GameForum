using System;
using System.Collections.Generic;

namespace FinalProject_GameForum.Models;

public partial class Article
{
    public int ArticleId { get; set; }

    public string UserId { get; set; } = null!;

    public string ArticleTitle { get; set; } = null!;

    public string ArticleContent { get; set; } = null!;

    public DateTime? PostDate { get; set; }

    public DateTime? EditDate { get; set; }

    public string Status { get; set; } = null!;

    public byte[]? CoverImage { get; set; }

    public virtual ArticleGroup? ArticleGroup { get; set; }

    public virtual ICollection<ArticleMessage> ArticleMessages { get; set; } = new List<ArticleMessage>();

    public virtual User User { get; set; } = null!;
}
