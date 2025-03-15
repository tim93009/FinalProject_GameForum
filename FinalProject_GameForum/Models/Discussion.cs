using System;
using System.Collections.Generic;

namespace FinalProject_GameForum.Models;

public partial class Discussion
{
    public int DiscussionId { get; set; }

    public string DiscussionName { get; set; } = null!;

    public string? DiscussionDescription { get; set; }

    public string? ImageUrl { get; set; }

    public int? Views { get; set; }

    public string? Category { get; set; }

    public int? ArticleGroupId { get; set; }

    public virtual ArticleGroup? ArticleGroup { get; set; }
}
