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

    public virtual ICollection<ArticleGroup> ArticleGroups { get; set; } = new List<ArticleGroup>();

    public virtual ICollection<SubscribedDiscussion> SubscribedDiscussions { get; set; } = new List<SubscribedDiscussion>();
}
