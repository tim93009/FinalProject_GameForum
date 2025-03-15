using System;
using System.Collections.Generic;

namespace FinalProject_GameForum.Models;

public partial class NewsMessage
{
    public int NewsMessageId { get; set; }

    public int NewsId { get; set; }

    public string UserId { get; set; } = null!;

    public string MessageContent { get; set; } = null!;

    public DateTime? EditDate { get; set; }

    public virtual News News { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
