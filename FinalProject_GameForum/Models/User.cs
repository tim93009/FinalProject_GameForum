using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;

namespace FinalProject_GameForum.Models
{
    
    public class User
    {
        [Key]
        public string? user_id { get; set; }
        public string? password { get; set; }
        public string? nickname { get; set; }
        public byte[]? photoUrl { get; set; }
        public string? gender { get; set; }
        public DateTime? birthdate { get; set; }
        public string? address { get; set; }
        public string? email { get; set; }
        public string? phone { get; set; }
        public DateTime? registerDate { get; set; }
    }
}
