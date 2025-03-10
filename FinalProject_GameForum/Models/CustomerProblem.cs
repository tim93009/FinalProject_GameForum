using System.ComponentModel.DataAnnotations;

namespace FinalProject_GameForum.Models
{
    public class CustomerProblem
    {
        [Key]
        public int QuestionId { get; set; }

        [Required]
        public int User_id { get; set; } // 使用者ID

        public string? QuestionType { get; set; } // 問題類型

        public string? QuestionDescription { get; set; } // 問題描述

        public byte[]? Image { get; set; } // 圖片 (Binary)
    }
}
