using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace FinalProject_GameForum.Models;

public partial class CustomerProblem
{
    public int QuestionId { get; set; }

    public string UserId { get; set; } = null!;

    public string? QuestionType { get; set; }

    public string? QuestionDescription { get; set; }

    public byte[]? Image { get; set; }

    public virtual User User { get; set; } = null!;

    [NotMapped]
    public string? ImageBase64 { get; set; }
}
