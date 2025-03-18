namespace FinalProject_GameForum.Models
{
    //登入驗證資料模型
    public class LoginPost
    {
        public string? Account { get; set; }
        public string? Password_P { get; set; }
        public bool Rememberme { get; set; }
        public string? Email_P { get; set; }
    }
}
