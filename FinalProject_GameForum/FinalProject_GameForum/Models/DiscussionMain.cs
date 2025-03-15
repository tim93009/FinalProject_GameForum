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
    }

    public class Post
    {
        public string Title { get; set; }
        public string Author { get; set; }
        public int Comments { get; set; }
        public string ImageUrl { get; set; }
    }

    public class Users
    {
        public string Name { get; set; }
        public string AvatarUrl { get; set; }
    }
}
