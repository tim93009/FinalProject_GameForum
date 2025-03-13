using System;
using System.Collections.Generic;

namespace FinalProject_GameForum.Models;

public partial class Relationship
{
    public int RelationshipId { get; set; }

    public string PersonAId { get; set; } = null!;

    public string? PersonBId { get; set; }

    public string? RelationshipType { get; set; }

    public virtual User PersonA { get; set; } = null!;

    public virtual User? PersonB { get; set; }
}
