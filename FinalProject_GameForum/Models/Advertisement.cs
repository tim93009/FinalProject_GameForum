using System;
using System.Collections.Generic;

namespace FinalProject_GameForum.Models;

public partial class Advertisement
{
    public int AdvertisementId { get; set; }

    public string AdvertisementName { get; set; } = null!;

    public string Category { get; set; } = null!;

    public string? ImageUrl { get; set; }
}
