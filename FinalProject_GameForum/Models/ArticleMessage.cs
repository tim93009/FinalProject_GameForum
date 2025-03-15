using System;
using System.Collections.Generic;

namespace FinalProject_GameForum.Models;

public partial class ArticleMessage
{
    public int ArticleMessageId { get; set; }

    public int ArticleId { get; set; }

    public string UserId { get; set; } = null!;

    public string MessageContent { get; set; } = null!;

    public DateTime? EditDate { get; set; }

    public virtual Article Article { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
