using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace FinalProject_GameForum.Models
{
    public class MyDbContext : DbContext
    {
        public MyDbContext(DbContextOptions<MyDbContext> options) : base(options)        {
        }

        public DbSet<CustomerProblem> CustomerProblems { get; set; } 
        public DbSet<User> User { get; set; }
    }
}
