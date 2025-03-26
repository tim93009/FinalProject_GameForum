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
            entity.HasKey(e => e.AdvertisementId).HasName("PK__Advertis__C4C7F42D027ABD6B");

            entity.ToTable("Advertisement");

            entity.Property(e => e.AdvertisementId).HasColumnName("AdvertisementID");
            entity.Property(e => e.AdvertisementName).HasMaxLength(50);
            entity.Property(e => e.Category).HasMaxLength(24);
            entity.Property(e => e.HyperUrl)
                .HasMaxLength(200)
                .IsUnicode(false);
            entity.Property(e => e.ImageUrl).HasMaxLength(250);
        });

        modelBuilder.Entity<Article>(entity =>
        {
            entity.HasKey(e => e.ArticleId).HasName("PK__Article__CC36F66090AB9C5B");

            entity.ToTable("Article");

            entity.Property(e => e.ArticleId).HasColumnName("ArticleID");
            entity.Property(e => e.ArticleGroupId).HasColumnName("ArticleGroupID");
            entity.Property(e => e.EditDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.PostDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.Status).HasMaxLength(10);
            entity.Property(e => e.UserId)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("UserID");

            entity.HasOne(d => d.ArticleGroup).WithMany(p => p.Articles)
                .HasForeignKey(d => d.ArticleGroupId)
                .HasConstraintName("FK_Article_ArticleGroup1");

            entity.HasOne(d => d.User).WithMany(p => p.Articles)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Article__user_id__66603565");
        });

        modelBuilder.Entity<ArticleGroup>(entity =>
        {
            entity.HasKey(e => e.ArticleGroupId).HasName("PK__ArticleG__9DEC28CAA7277795");

            entity.ToTable("ArticleGroup");

            entity.Property(e => e.ArticleGroupId).HasColumnName("ArticleGroupID");
            entity.Property(e => e.ArticleTitle).HasMaxLength(100);
            entity.Property(e => e.Category).HasMaxLength(24);
            entity.Property(e => e.CoverImage).HasColumnType("image");
            entity.Property(e => e.DiscussionId).HasColumnName("DiscussionID");
            entity.Property(e => e.Views).HasDefaultValue(0);

            entity.HasOne(d => d.Discussion).WithMany(p => p.ArticleGroups)
                .HasForeignKey(d => d.DiscussionId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ArticleGroup_Discussion");
        });

        modelBuilder.Entity<ArticleMessage>(entity =>
        {
            entity.HasKey(e => e.ArticleMessageId).HasName("PK__ArticleM__1AF9C29849736554");

            entity.ToTable("ArticleMessage");

            entity.Property(e => e.ArticleMessageId).HasColumnName("ArticleMessageID");
            entity.Property(e => e.ArticleId).HasColumnName("ArticleID");
            entity.Property(e => e.EditDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.MessageContent).HasMaxLength(250);
            entity.Property(e => e.UserId)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("UserID");

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

            entity.Property(e => e.QuestionId).HasColumnName("QuestionID");
            entity.Property(e => e.Image).HasColumnType("image");
            entity.Property(e => e.QuestionDescription).HasMaxLength(1000);
            entity.Property(e => e.QuestionType).HasMaxLength(50);
            entity.Property(e => e.UserId)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("UserID");

            entity.HasOne(d => d.User).WithMany(p => p.CustomerProblems)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_CustomerProblems_User");
        });

        modelBuilder.Entity<Discussion>(entity =>
        {
            entity.ToTable("Discussion");

            entity.Property(e => e.DiscussionId).HasColumnName("DiscussionID");
            entity.Property(e => e.Category).HasMaxLength(24);
            entity.Property(e => e.DiscussionDescription).HasMaxLength(500);
            entity.Property(e => e.DiscussionName).HasMaxLength(50);
            entity.Property(e => e.ImageUrl).HasMaxLength(250);
            entity.Property(e => e.Views).HasDefaultValue(0);
        });

        modelBuilder.Entity<HistoricalVisitor>(entity =>
        {
            entity.Property(e => e.HistoricalVisitorId).HasColumnName("HistoricalVisitorID");
            entity.Property(e => e.OwnerId)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("OwnerID");
            entity.Property(e => e.VisitTime).HasColumnType("datetime");
            entity.Property(e => e.VisitorId)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("VisitorID");
        });

        modelBuilder.Entity<News>(entity =>
        {
            entity.HasKey(e => e.NewsId).HasName("PK__News__954EBDD35879DE4F");

            entity.Property(e => e.NewsId).HasColumnName("NewsID");
            entity.Property(e => e.Category).HasMaxLength(24);
            entity.Property(e => e.EditDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.ImageUrl).HasMaxLength(250);
            entity.Property(e => e.NewsTitle).HasMaxLength(50);
        });

        modelBuilder.Entity<NewsImage>(entity =>
        {
            entity.HasKey(e => e.NewsImageId).HasName("PK__NewsImag__E8D22582DD65A3B6");

            entity.ToTable("NewsImage");

            entity.Property(e => e.NewsImageId).HasColumnName("NewsImageID");
            entity.Property(e => e.ImageUrl).HasMaxLength(250);
            entity.Property(e => e.NewsId).HasColumnName("NewsID");

            entity.HasOne(d => d.News).WithMany(p => p.NewsImages)
                .HasForeignKey(d => d.NewsId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__NewsImage__NewsI__6C190EBB");
        });

        modelBuilder.Entity<NewsMessage>(entity =>
        {
            entity.HasKey(e => e.NewsMessageId).HasName("PK__NewsMess__FAB86F1985C612F2");

            entity.ToTable("NewsMessage");

            entity.Property(e => e.NewsMessageId).HasColumnName("NewsMessageID");
            entity.Property(e => e.EditDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.MessageContent).HasMaxLength(250);
            entity.Property(e => e.NewsId).HasColumnName("NewsID");
            entity.Property(e => e.UserId)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("UserID");

            entity.HasOne(d => d.News).WithMany(p => p.NewsMessages)
                .HasForeignKey(d => d.NewsId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__NewsMessa__NewsI__6D0D32F4");

            entity.HasOne(d => d.User).WithMany(p => p.NewsMessages)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__NewsMessa__user___6FE99F9F");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.OrderId).HasName("PK__Order__C3905BAFC72C609A");

            entity.ToTable("Order");

            entity.Property(e => e.OrderId).HasColumnName("OrderID");
            entity.Property(e => e.Cellphone)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.OrderDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.OrderStatusId).HasColumnName("OrderStatusID");
            entity.Property(e => e.ProductId).HasColumnName("ProductID");
            entity.Property(e => e.RecipientName)
                .HasMaxLength(50)
                .IsFixedLength();
            entity.Property(e => e.SendSms)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.ShippingAddress).HasMaxLength(100);
            entity.Property(e => e.Telephone)
                .HasMaxLength(20)
                .IsUnicode(false);
            entity.Property(e => e.TelephoneCityCode)
                .HasMaxLength(10)
                .IsUnicode(false);
            entity.Property(e => e.UserId)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("UserID");

            entity.HasOne(d => d.OrderStatus).WithMany(p => p.Orders)
                .HasForeignKey(d => d.OrderStatusId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Order__OrderStat__6EF57B66");

            entity.HasOne(d => d.Product).WithMany(p => p.Orders)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Order__ProductID__6FE99F9F");

            entity.HasOne(d => d.User).WithMany(p => p.Orders)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Order__user_id__72C60C4A");
        });

        modelBuilder.Entity<OrderStatus>(entity =>
        {
            entity.HasKey(e => e.OrderStatusId).HasName("PK__OrderSta__BC674F416D5CF23B");

            entity.ToTable("OrderStatus");

            entity.Property(e => e.OrderStatusId).HasColumnName("OrderStatusID");
            entity.Property(e => e.Status).HasMaxLength(20);
        });

        modelBuilder.Entity<Product>(entity =>
        {
            entity.HasKey(e => e.ProductId).HasName("PK__Product__B40CC6EDEF73D1ED");

            entity.ToTable("Product");

            entity.Property(e => e.ProductId).HasColumnName("ProductID");
            entity.Property(e => e.MainImageUrl).HasMaxLength(250);
            entity.Property(e => e.ProductCategoryId).HasColumnName("ProductCategoryID");
            entity.Property(e => e.ProductDescription).HasMaxLength(500);
            entity.Property(e => e.ProductName).HasMaxLength(50);
            entity.Property(e => e.Rating).HasDefaultValue(0.0);
            entity.Property(e => e.Sold).HasDefaultValue(0);
            entity.Property(e => e.Stock).HasDefaultValue(0);

            entity.HasOne(d => d.ProductCategory).WithMany(p => p.Products)
                .HasForeignKey(d => d.ProductCategoryId)
                .HasConstraintName("FK__Product__Product__71D1E811");
        });

        modelBuilder.Entity<ProductAdditionalImage>(entity =>
        {
            entity.HasKey(e => e.ProductAdditionalImageId).HasName("PK__ProductA__EE272CE459D32344");

            entity.ToTable("ProductAdditionalImage");

            entity.Property(e => e.ProductAdditionalImageId).HasColumnName("ProductAdditionalImageID");
            entity.Property(e => e.AdditionalImageUrl).HasMaxLength(250);
            entity.Property(e => e.ProductId).HasColumnName("ProductID");

            entity.HasOne(d => d.Product).WithMany(p => p.ProductAdditionalImages)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__ProductAd__Produ__72C60C4A");
        });

        modelBuilder.Entity<ProductCategory>(entity =>
        {
            entity.HasKey(e => e.ProductCategoryId).HasName("PK__ProductC__3224ECEE84E32DF4");

            entity.ToTable("ProductCategory");

            entity.Property(e => e.ProductCategoryId).HasColumnName("ProductCategoryID");
            entity.Property(e => e.Category).HasMaxLength(24);
        });

        modelBuilder.Entity<Relationship>(entity =>
        {
            entity.Property(e => e.RelationshipId).HasColumnName("RelationshipID");
            entity.Property(e => e.PersonAid)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("PersonAID");
            entity.Property(e => e.PersonBid)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("PersonBID");
            entity.Property(e => e.RelationshipType).HasMaxLength(50);
        });

        modelBuilder.Entity<ShoppingCart>(entity =>
        {
            entity.HasKey(e => e.ShoppingCartId).HasName("PK__Shopping__7A789A846999409B");

            entity.ToTable("ShoppingCart");

            entity.Property(e => e.ShoppingCartId).HasColumnName("ShoppingCartID");
            entity.Property(e => e.ProductId).HasColumnName("ProductID");
            entity.Property(e => e.UserId)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("UserID");

            entity.HasOne(d => d.Product).WithMany(p => p.ShoppingCarts)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__ShoppingC__Produ__73BA3083");

            entity.HasOne(d => d.User).WithMany(p => p.ShoppingCarts)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__ShoppingC__user___787EE5A0");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("PK__User__B9BE370F8393A9A1");

            entity.ToTable("User");

            entity.Property(e => e.UserId)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("UserID");
            entity.Property(e => e.Address).HasMaxLength(100);
            entity.Property(e => e.Birthdate).HasColumnType("datetime");
            entity.Property(e => e.Email).HasMaxLength(100);
            entity.Property(e => e.Gender)
                .HasMaxLength(1)
                .IsUnicode(false);
            entity.Property(e => e.Nickname).HasMaxLength(50);
            entity.Property(e => e.Password)
                .HasMaxLength(128)
                .IsUnicode(false);
            entity.Property(e => e.Phone)
                .HasMaxLength(10)
                .IsUnicode(false)
                .IsFixedLength();
            entity.Property(e => e.PhotoUrl).HasMaxLength(250);
            entity.Property(e => e.Provider)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.ProviderId)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("ProviderID");
            entity.Property(e => e.RegisterDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
        });

        modelBuilder.Entity<ViewHistory>(entity =>
        {
            entity.HasKey(e => e.ViewHistoryId).HasName("PK__ViewHist__55D4BB13553D69A5");

            entity.ToTable("ViewHistory");

            entity.Property(e => e.ViewHistoryId).HasColumnName("ViewHistoryID");
            entity.Property(e => e.ProductId).HasColumnName("ProductID");
            entity.Property(e => e.UserId)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("UserID");
            entity.Property(e => e.ViewDate)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");

            entity.HasOne(d => d.Product).WithMany(p => p.ViewHistories)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__ViewHisto__Produ__75A278F5");

            entity.HasOne(d => d.User).WithMany(p => p.ViewHistories)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__ViewHisto__user___7A672E12");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
