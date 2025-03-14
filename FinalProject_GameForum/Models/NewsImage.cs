using System;
using System.Collections.Generic;

namespace FinalProject_GameForum.Models;

public partial class NewsImage
{
    public int NewsImageId { get; set; }

    public int NewsId { get; set; }

    public string ImageUrl { get; set; } = null!;

    public virtual News News { get; set; } = null!;
}
