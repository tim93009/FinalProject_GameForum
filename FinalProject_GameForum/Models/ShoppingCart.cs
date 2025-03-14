using System;
using System.Collections.Generic;

namespace FinalProject_GameForum.Models;

public partial class ShoppingCart
{
    public int ShoppingCartId { get; set; }

    public string UserId { get; set; } = null!;

    public int ProductId { get; set; }

    public int Quantity { get; set; }

    public virtual Product Product { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
