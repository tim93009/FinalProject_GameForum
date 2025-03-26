using System;
using System.Collections.Generic;

namespace FinalProject_GameForum.Models;

public partial class SubscribedArticle
{
    public int SubscribedArticleId { get; set; }

    public string UserId { get; set; } = null!;

    public int ArticleGroupId { get; set; }

    public bool? IsSubscribed { get; set; }

    public virtual ArticleGroup ArticleGroup { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
