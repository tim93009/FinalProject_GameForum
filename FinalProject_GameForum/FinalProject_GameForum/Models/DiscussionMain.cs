using System.Collections.Generic;

namespace FinalProject_GameForum.Models
{
    public class ForumViewModel
    {
        public string BannerImage { get; set; } // 首頁大橫幅
        public List<Post> FeaturedPosts { get; set; } // 精選文章
        public Users BoardAdmin { get; set; } // 板主
        public int TotalPosts { get; set; } // 總文章數
        public int RecentPosts { get; set; } // 近期更新
        public List<Post> AllPosts { get; set; } // 文章列表
    }

    public class Post
    {
        public int Id { get; set; }
        public string Category { get; set; } // 文章分類
        public string Title { get; set; } // 文章標題
        public string Author { get; set; } // 作者
        public int Comments { get; set; } // 回應數
        public int Views { get; set; } // 瀏覽數
        public DateTime LastReplyTime { get; set; } // 最新回應時間
        public string ImageUrl { get; set; } // 文章縮圖
    }

    public class Users
    {
        public string Name { get; set; }
        public string AvatarUrl { get; set; }
    }
}
