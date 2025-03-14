using System;
using System.Collections.Generic;

namespace FinalProject_GameForum.Models;

public partial class Product
{
    public int ProductId { get; set; }

    public string ProductName { get; set; } = null!;

    public string? ProductDescription { get; set; }

    public string? MainImageUrl { get; set; }

    public int Price { get; set; }

    public int? ProductCategoryId { get; set; }

    public int? Stock { get; set; }

    public int? Sold { get; set; }

    public double? Rating { get; set; }

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual ICollection<ProductAdditionalImage> ProductAdditionalImages { get; set; } = new List<ProductAdditionalImage>();

    public virtual ProductCategory? ProductCategory { get; set; }

    public virtual ICollection<ShoppingCart> ShoppingCarts { get; set; } = new List<ShoppingCart>();

    public virtual ICollection<ViewHistory> ViewHistories { get; set; } = new List<ViewHistory>();
}
