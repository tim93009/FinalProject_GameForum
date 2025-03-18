using System;
using System.Collections.Generic;

namespace FinalProject_GameForum.Models;

public partial class User
{
    public string UserId { get; set; } = null!;

    public string? Password { get; set; }

    public string Nickname { get; set; } = null!;

    public string? PhotoUrl { get; set; }

    public string? Gender { get; set; }

    public DateTime? Birthdate { get; set; }

    public string? Address { get; set; }

    public string? Email { get; set; }

    public string? Phone { get; set; }

    public DateTime? RegisterDate { get; set; }

    public string? Provider { get; set; }

    public string? ProviderId { get; set; }

    public virtual ICollection<ArticleMessage> ArticleMessages { get; set; } = new List<ArticleMessage>();

    public virtual ICollection<Article> Articles { get; set; } = new List<Article>();

    public virtual ICollection<CustomerProblem> CustomerProblems { get; set; } = new List<CustomerProblem>();

    public virtual ICollection<NewsMessage> NewsMessages { get; set; } = new List<NewsMessage>();

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual ICollection<ShoppingCart> ShoppingCarts { get; set; } = new List<ShoppingCart>();

    public virtual ICollection<ViewHistory> ViewHistories { get; set; } = new List<ViewHistory>();
}
