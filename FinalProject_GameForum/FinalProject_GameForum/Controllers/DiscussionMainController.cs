using Microsoft.AspNetCore.Mvc;
using FinalProject_GameForum.Models;

namespace FinalProject_GameForum.Controllers
{
    public class DiscussionMainController : Controller
    {
        public IActionResult Index()
        {
            //ViewData["Layout"] = "_LayoutForum";

            // 建立假資料
            var model = new ForumViewModel
            {

                BannerImage = "/images/maplestory_banner.jpg",

                BoardAdmin = new Users { Name = "gary330105", AvatarUrl = "https://example.com/avatar.jpg" },
                TotalPosts = 5000,
                RecentPosts = 100,
                FeaturedPosts = new List<Post>
                {
                    new Post { Id = 1, Title = "超好玩的遊戲", Author = "player1", Comments = 50, Views = 1000, ImageUrl = "https://example.com/post1.jpg" },
                    new Post { Id = 2, Title = "新攻略分享", Author = "player2", Comments = 30, Views = 500, ImageUrl = "https://example.com/post2.jpg" },
                    new Post { Id = 3, Title = "不好玩的遊戲", Author = "player3", Comments = 60, Views = 1200, ImageUrl = "https://example.com/post1.jpg" },
                    new Post { Id = 4, Title = "有點好玩的遊戲", Author = "player4", Comments = 77, Views = 1500, ImageUrl = "https://example.com/post1.jpg" },

                },

                //文章列表假資料
                AllPosts = new List<Post>
                {
                    new Post { Id = 1, Category = "攻略", Title = "新手入門指南", Author = "player1", Comments = 10, Views = 200, LastReplyTime = DateTime.Now },
                    new Post { Id = 2, Category = "閒聊", Title = "最近的新活動", Author = "player2", Comments = 20, Views = 500, LastReplyTime = DateTime.Now },
                    new Post { Id = 3, Category = "問題", Title = "這個裝備怎麼刷?", Author = "player3", Comments = 5, Views = 150, LastReplyTime = DateTime.Now },
                    new Post { Id = 4, Category = "創作", Title = "荒野", Author = "player4", Comments = 5, Views = 150, LastReplyTime = DateTime.Now },
                    new Post { Id = 5, Category = "情報", Title = "最新版本更新（2025／03／16）", Author = "player5", Comments = 5, Views = 150, LastReplyTime = DateTime.Now },
                    new Post { Id = 6, Category = "問題", Title = "捏臉", Author = "player6", Comments = 5, Views = 150, LastReplyTime = DateTime.Now },
                    new Post { Id = 7, Category = "情報", Title = "New Boss", Author = "player7", Comments = 5, Views = 150, LastReplyTime = DateTime.Now }

                }

            };

            return View(model);
        }
    }
}
