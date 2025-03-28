using System;
using System.Collections.Generic;

namespace FinalProject_GameForum.Models;

public partial class Relationship
{
    public int RelationshipId { get; set; }

    public string PersonAid { get; set; } = null!;

    public string? PersonBid { get; set; }

    public string? RelationshipType { get; set; }

    public virtual User PersonA { get; set; } = null!;
}
