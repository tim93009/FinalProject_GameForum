using System;
using System.Collections.Generic;

namespace FinalProject_GameForum.Models;

public partial class SubscribedDiscussion
{
    public int SubscribedDiscussionId { get; set; }

    public string UserId { get; set; } = null!;

    public int DiscussionId { get; set; }

    public bool? IsSubscribed { get; set; }

    public virtual Discussion Discussion { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
