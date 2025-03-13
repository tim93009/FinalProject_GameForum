using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace FinalProject_GameForum.Models;

public partial class GameForumContext : DbContext
{
    public GameForumContext()
    {
    }

    public GameForumContext(DbContextOptions<GameForumContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Advertisement> Advertisements { get; set; }

    public virtual DbSet<Article> Articles { get; set; }

    public virtual DbSet<ArticleGroup> ArticleGroups { get; set; }

    public virtual DbSet<ArticleMessage> ArticleMessages { get; set; }

    public virtual DbSet<CustomerProblem> CustomerProblems { get; set; }

    public virtual DbSet<Discussion> Discussions { get; set; }

    public virtual DbSet<HistoricalVisitor> HistoricalVisitors { get; set; }

    public virtual DbSet<News> News { get; set; }

    public virtual DbSet<NewsImage> NewsImages { get; set; }

    public virtual DbSet<NewsMessage> NewsMessages { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<OrderStatus> OrderStatuses { get; set; }

    public virtual DbSet<Product> Products { get; set; }

    public virtual DbSet<ProductAdditionalImage> ProductAdditionalImages { get; set; }

    public virtual DbSet<ProductCategory> ProductCategories { get; set; }

    public virtual DbSet<Relationship> Relationships { get; set; }

    public virtual DbSet<ShoppingCart> ShoppingCarts { get; set; }

    public virtual DbSet<User> Users { get; set; }

    public virtual DbSet<ViewHistory> ViewHistories { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Server=localhost\\SQLEXPRESS;Database=GameForum;Integrated Security=True;Trusted_Connection=True;TrustServerCertificate=True;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Advertisement>(entity =>
        {
            entity.HasKey(e => e.AdvertisementId).HasName("PK__Advertis__7F50179140B29894");

            entity.ToTable("Advertisement");

            entity.Property(e => e.AdvertisementId).HasColumnName("advertisement_id");
            entity.Property(e => e.AdvertisementName)
                .HasMaxLength(50)
                .HasColumnName("advertisementName");
            entity.Property(e => e.Category)
                .HasMaxLength(24)
                .HasColumnName("category");
            entity.Property(e => e.ImageUrl)
                .HasMaxLength(250)
                .HasColumnName("imageUrl");
        });

        modelBuilder.Entity<Article>(entity =>
        {
            entity.HasKey(e => e.ArticleId).HasName("PK__Article__CC36F6603193FACC");

            entity.ToTable("Article");

            entity.Property(e => e.ArticleId).HasColumnName("article_id");
            entity.Property(e => e.ArticleTitle)
                .HasMaxLength(50)
                .HasColumnName("articleTitle");
            entity.Property(e => e.CoverImage).HasColumnType("image");
            entity.Property(e => e.EditDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("editDate");
            entity.Property(e => e.PostDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("postDate");
            entity.Property(e => e.Status)
                .HasMaxLength(10)
                .HasColumnName("status");
            entity.Property(e => e.UserId)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("user_id");

            entity.HasOne(d => d.User).WithMany(p => p.Articles)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Article__user_id__66603565");
        });

        modelBuilder.Entity<ArticleGroup>(entity =>
        {
            entity.HasKey(e => e.ArticleGroupId).HasName("PK__ArticleG__9DEC28CAE5E573D3");

            entity.ToTable("ArticleGroup");

            entity.Property(e => e.ArticleGroupId)
                .ValueGeneratedOnAdd()
                .HasColumnName("articleGroup_id");
            entity.Property(e => e.Category)
                .HasMaxLength(24)
                .HasColumnName("category");
            entity.Property(e => e.Views)
                .HasDefaultValue(0)
                .HasColumnName("views");

            entity.HasOne(d => d.ArticleGroupNavigation).WithOne(p => p.ArticleGroup)
                .HasForeignKey<ArticleGroup>(d => d.ArticleGroupId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ArticleGroup_Article");
        });

        modelBuilder.Entity<ArticleMessage>(entity =>
        {
            entity.HasKey(e => e.ArticleMessageId).HasName("PK__ArticleM__693D9D55E646CB09");

            entity.ToTable("ArticleMessage");

            entity.Property(e => e.ArticleMessageId).HasColumnName("articleMessage_id");
            entity.Property(e => e.ArticleId).HasColumnName("article_id");
            entity.Property(e => e.EditDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("editDate");
            entity.Property(e => e.MessageContent)
                .HasMaxLength(250)
                .HasColumnName("messageContent");
            entity.Property(e => e.UserId)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("user_id");

            entity.HasOne(d => d.Article).WithMany(p => p.ArticleMessages)
                .HasForeignKey(d => d.ArticleId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__ArticleMe__artic__68487DD7");

            entity.HasOne(d => d.User).WithMany(p => p.ArticleMessages)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__ArticleMe__user___693CA210");
        });

        modelBuilder.Entity<CustomerProblem>(entity =>
        {
            entity.HasKey(e => e.QuestionId);

            entity.Property(e => e.Image).HasColumnType("image");
            entity.Property(e => e.QuestionDescription).HasMaxLength(1000);
            entity.Property(e => e.QuestionType).HasMaxLength(50);
            entity.Property(e => e.UserId)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("User_id");

            entity.HasOne(d => d.User).WithMany(p => p.CustomerProblems)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_CustomerProblems_User");
        });

        modelBuilder.Entity<Discussion>(entity =>
        {
            entity.HasKey(e => e.DiscussionId).HasName("PK__Discussi__2AC5FD65588BFC89");

            entity.ToTable("Discussion");

            entity.Property(e => e.DiscussionId).HasColumnName("discussion_id");
            entity.Property(e => e.ArticleGroupId).HasColumnName("articleGroup_id");
            entity.Property(e => e.Category)
                .HasMaxLength(24)
                .HasColumnName("category");
            entity.Property(e => e.DiscussionDescription)
                .HasMaxLength(500)
                .HasColumnName("discussionDescription");
            entity.Property(e => e.DiscussionName)
                .HasMaxLength(50)
                .HasColumnName("discussionName");
            entity.Property(e => e.ImageUrl)
                .HasMaxLength(250)
                .HasColumnName("imageUrl");
            entity.Property(e => e.Views)
                .HasDefaultValue(0)
                .HasColumnName("views");

            entity.HasOne(d => d.ArticleGroup).WithMany(p => p.Discussions)
                .HasForeignKey(d => d.ArticleGroupId)
                .HasConstraintName("FK_Discussion_ArticleGroup");
        });

        modelBuilder.Entity<HistoricalVisitor>(entity =>
        {
            entity.Property(e => e.HistoricalVisitorId).ValueGeneratedNever();
            entity.Property(e => e.OwnerId)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.VisitTime).HasColumnType("datetime");
            entity.Property(e => e.VisitorId)
                .HasMaxLength(50)
                .IsUnicode(false);

            entity.HasOne(d => d.Owner).WithMany(p => p.HistoricalVisitorOwners)
                .HasForeignKey(d => d.OwnerId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_HistoricalVisitors_User");

            entity.HasOne(d => d.Visitor).WithMany(p => p.HistoricalVisitorVisitors)
                .HasForeignKey(d => d.VisitorId)
                .HasConstraintName("FK_HistoricalVisitors_User1");
        });

        modelBuilder.Entity<News>(entity =>
        {
            entity.HasKey(e => e.NewsId).HasName("PK__News__4C27CCD879E9F154");

            entity.Property(e => e.NewsId).HasColumnName("news_id");
            entity.Property(e => e.Category)
                .HasMaxLength(24)
                .HasColumnName("category");
            entity.Property(e => e.EditDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("editDate");
            entity.Property(e => e.ImageUrl)
                .HasMaxLength(250)
                .HasColumnName("imageUrl");
            entity.Property(e => e.NewsContent).HasColumnName("newsContent");
            entity.Property(e => e.NewsTitle)
                .HasMaxLength(50)
                .HasColumnName("newsTitle");
        });

        modelBuilder.Entity<NewsImage>(entity =>
        {
            entity.HasKey(e => e.NewsImageId).HasName("PK__NewsImag__55468B3F7623409E");

            entity.ToTable("NewsImage");

            entity.Property(e => e.NewsImageId).HasColumnName("newsImage_id");
            entity.Property(e => e.ImageUrl)
                .HasMaxLength(250)
                .HasColumnName("imageUrl");
            entity.Property(e => e.NewsId).HasColumnName("news_id");

            entity.HasOne(d => d.News).WithMany(p => p.NewsImages)
                .HasForeignKey(d => d.NewsId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__NewsImage__news___6E01572D");
        });

        modelBuilder.Entity<NewsMessage>(entity =>
        {
            entity.HasKey(e => e.NewsMessageId).HasName("PK__NewsMess__B607BBB34A952065");

            entity.ToTable("NewsMessage");

            entity.Property(e => e.NewsMessageId).HasColumnName("newsMessage_id");
            entity.Property(e => e.EditDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("editDate");
            entity.Property(e => e.MessageContent)
                .HasMaxLength(250)
                .HasColumnName("messageContent");
            entity.Property(e => e.NewsId).HasColumnName("news_id");
            entity.Property(e => e.UserId)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("user_id");

            entity.HasOne(d => d.News).WithMany(p => p.NewsMessages)
                .HasForeignKey(d => d.NewsId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__NewsMessa__news___6EF57B66");

            entity.HasOne(d => d.User).WithMany(p => p.NewsMessages)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__NewsMessa__user___6FE99F9F");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.OrderId).HasName("PK__Order__46596229720DF249");

            entity.ToTable("Order");

            entity.Property(e => e.OrderId).HasColumnName("order_id");
            entity.Property(e => e.OrderDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("orderDate");
            entity.Property(e => e.OrderStatusId).HasColumnName("orderStatus_id");
            entity.Property(e => e.ProductId).HasColumnName("product_id");
            entity.Property(e => e.Quantity).HasColumnName("quantity");
            entity.Property(e => e.ShippingAddress)
                .HasMaxLength(100)
                .HasColumnName("shippingAddress");
            entity.Property(e => e.UserId)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("user_id");

            entity.HasOne(d => d.OrderStatus).WithMany(p => p.Orders)
                .HasForeignKey(d => d.OrderStatusId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Order__orderStat__70DDC3D8");

            entity.HasOne(d => d.Product).WithMany(p => p.Orders)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Order__product_i__71D1E811");

            entity.HasOne(d => d.User).WithMany(p => p.Orders)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Order__user_id__72C60C4A");
        });

        modelBuilder.Entity<OrderStatus>(entity =>
        {
            entity.HasKey(e => e.OrderStatusId).HasName("PK__OrderSta__527F3408C566EED6");

            entity.ToTable("OrderStatus");

            entity.Property(e => e.OrderStatusId).HasColumnName("orderStatus_id");
            entity.Property(e => e.Status)
                .HasMaxLength(20)
                .HasColumnName("status");
        });

        modelBuilder.Entity<Product>(entity =>
        {
            entity.HasKey(e => e.ProductId).HasName("PK__Product__47027DF518849693");

            entity.ToTable("Product");

            entity.Property(e => e.ProductId).HasColumnName("product_id");
            entity.Property(e => e.MainImageUrl)
                .HasMaxLength(250)
                .HasColumnName("mainImageUrl");
            entity.Property(e => e.Price).HasColumnName("price");
            entity.Property(e => e.ProductCategoryId).HasColumnName("productCategory_id");
            entity.Property(e => e.ProductDescription)
                .HasMaxLength(500)
                .HasColumnName("productDescription");
            entity.Property(e => e.ProductName)
                .HasMaxLength(50)
                .HasColumnName("productName");
            entity.Property(e => e.Rating)
                .HasDefaultValue(0.0)
                .HasColumnName("rating");
            entity.Property(e => e.Sold)
                .HasDefaultValue(0)
                .HasColumnName("sold");
            entity.Property(e => e.Stock)
                .HasDefaultValue(0)
                .HasColumnName("stock");

            entity.HasOne(d => d.ProductCategory).WithMany(p => p.Products)
                .HasForeignKey(d => d.ProductCategoryId)
                .HasConstraintName("FK__Product__product__73BA3083");
        });

        modelBuilder.Entity<ProductAdditionalImage>(entity =>
        {
            entity.HasKey(e => e.ProductAdditionalImageId).HasName("PK__ProductA__DDBE70B9F3D16FEA");

            entity.ToTable("ProductAdditionalImage");

            entity.Property(e => e.ProductAdditionalImageId).HasColumnName("productAdditionalImage_id");
            entity.Property(e => e.AdditionalImageUrl)
                .HasMaxLength(250)
                .HasColumnName("additionalImageUrl");
            entity.Property(e => e.ProductId).HasColumnName("product_id");

            entity.HasOne(d => d.Product).WithMany(p => p.ProductAdditionalImages)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__ProductAd__produ__74AE54BC");
        });

        modelBuilder.Entity<ProductCategory>(entity =>
        {
            entity.HasKey(e => e.ProductCategoryId).HasName("PK__ProductC__01D20E30112B0B57");

            entity.ToTable("ProductCategory");

            entity.Property(e => e.ProductCategoryId).HasColumnName("productCategory_id");
            entity.Property(e => e.Category)
                .HasMaxLength(24)
                .HasColumnName("category");
        });

        modelBuilder.Entity<Relationship>(entity =>
        {
            entity.Property(e => e.RelationshipId).ValueGeneratedNever();
            entity.Property(e => e.PersonAId)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("PersonA_ID");
            entity.Property(e => e.PersonBId)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("PersonB_ID");
            entity.Property(e => e.RelationshipType).HasMaxLength(50);

            entity.HasOne(d => d.PersonA).WithMany(p => p.RelationshipPersonAs)
                .HasForeignKey(d => d.PersonAId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Relationships_User");

            entity.HasOne(d => d.PersonB).WithMany(p => p.RelationshipPersonBs)
                .HasForeignKey(d => d.PersonBId)
                .HasConstraintName("FK_Relationships_User1");
        });

        modelBuilder.Entity<ShoppingCart>(entity =>
        {
            entity.HasKey(e => e.ShoppingCartId).HasName("PK__Shopping__1C91548FB3205FC6");

            entity.ToTable("ShoppingCart");

            entity.Property(e => e.ShoppingCartId).HasColumnName("shoppingCart_id");
            entity.Property(e => e.ProductId).HasColumnName("product_id");
            entity.Property(e => e.Quantity).HasColumnName("quantity");
            entity.Property(e => e.UserId)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("user_id");

            entity.HasOne(d => d.Product).WithMany(p => p.ShoppingCarts)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__ShoppingC__produ__778AC167");

            entity.HasOne(d => d.User).WithMany(p => p.ShoppingCarts)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__ShoppingC__user___787EE5A0");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("PK__User__B9BE370F2D35C770");

            entity.ToTable("User");

            entity.Property(e => e.UserId)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("user_id");
            entity.Property(e => e.Address)
                .HasMaxLength(100)
                .HasColumnName("address");
            entity.Property(e => e.Birthdate)
                .HasColumnType("datetime")
                .HasColumnName("birthdate");
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .HasColumnName("email");
            entity.Property(e => e.Gender)
                .HasMaxLength(1)
                .IsUnicode(false)
                .HasColumnName("gender");
            entity.Property(e => e.Nickname)
                .HasMaxLength(50)
                .HasColumnName("nickname");
            entity.Property(e => e.Password)
                .HasMaxLength(64)
                .IsUnicode(false)
                .HasColumnName("password");
            entity.Property(e => e.Phone)
                .HasMaxLength(10)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("phone");
            entity.Property(e => e.PhotoUrl)
                .HasMaxLength(250)
                .HasColumnName("photoUrl");
            entity.Property(e => e.RegisterDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("registerDate");
        });

        modelBuilder.Entity<ViewHistory>(entity =>
        {
            entity.HasKey(e => e.ViewHistoryId).HasName("PK__ViewHist__2BA828D7DE0D5E33");

            entity.ToTable("ViewHistory");

            entity.Property(e => e.ViewHistoryId).HasColumnName("viewHistory_id");
            entity.Property(e => e.ProductId).HasColumnName("product_id");
            entity.Property(e => e.UserId)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("user_id");
            entity.Property(e => e.ViewDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime")
                .HasColumnName("viewDate");

            entity.HasOne(d => d.Product).WithMany(p => p.ViewHistories)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__ViewHisto__produ__797309D9");

            entity.HasOne(d => d.User).WithMany(p => p.ViewHistories)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__ViewHisto__user___7A672E12");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
