﻿using System;
using System.Collections.Generic;

namespace FinalProject_GameForum.Models;

public partial class ProductCategory
{
    public int ProductCategoryId { get; set; }

    public string Category { get; set; } = null!;

    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}
