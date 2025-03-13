using System;
using System.Collections.Generic;

namespace FinalProject_GameForum.Models;

public partial class Order
{
    public int OrderId { get; set; }

    public string UserId { get; set; } = null!;

    public int ProductId { get; set; }

    public int Quantity { get; set; }

    public DateTime? OrderDate { get; set; }

    public int OrderStatusId { get; set; }

    public string ShippingAddress { get; set; } = null!;

    public virtual OrderStatus OrderStatus { get; set; } = null!;

    public virtual Product Product { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}
