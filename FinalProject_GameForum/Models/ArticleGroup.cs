using System;
using System.Collections.Generic;

namespace FinalProject_GameForum.Models;

public partial class ArticleGroup
{
    public int ArticleGroupId { get; set; }

    public string Category { get; set; } = null!;

    public int? Views { get; set; }

    public virtual Article ArticleGroupNavigation { get; set; } = null!;

    public virtual ICollection<Discussion> Discussions { get; set; } = new List<Discussion>();
}
