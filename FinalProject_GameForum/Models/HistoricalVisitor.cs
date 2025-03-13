using System;
using System.Collections.Generic;

namespace FinalProject_GameForum.Models;

public partial class HistoricalVisitor
{
    public int HistoricalVisitorId { get; set; }

    public string OwnerId { get; set; } = null!;

    public string? VisitorId { get; set; }

    public DateTime? VisitTime { get; set; }

    public virtual User Owner { get; set; } = null!;

    public virtual User? Visitor { get; set; }
}
