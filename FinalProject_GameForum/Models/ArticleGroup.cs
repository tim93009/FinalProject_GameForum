using System;
using System.Collections.Generic;

namespace FinalProject_GameForum.Models;

public partial class ArticleGroup
{
    public int ArticleGroupId { get; set; }

    public int DiscussionId { get; set; }

    public string Category { get; set; } = null!;

    public int? Views { get; set; }

    public byte[]? CoverImage { get; set; }

    public string? ArticleTitle { get; set; }

    public virtual ICollection<Article> Articles { get; set; } = new List<Article>();

    public virtual Discussion Discussion { get; set; } = null!;

    public virtual ICollection<SubscribedArticle> SubscribedArticles { get; set; } = new List<SubscribedArticle>();
}
