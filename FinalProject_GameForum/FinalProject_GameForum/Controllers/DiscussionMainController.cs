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
                //FeaturedPosts = new List<Post>
                //{
                //    new Post { Title = "【密技】DiscordBOT 提醒您放風時間結束了", Author = "TMSBug_v2", Comments = 12, ImageUrl = "/images/post1.jpg" },
                //    new Post { Title = "【劇情】奧術之河重製！(更新至艾斯佩拉)", Author = "寶家", Comments = 29, ImageUrl = "/images/post2.jpg" }
                //},
                //BoardAdmin = new Users { Name = "管理員", AvatarUrl = "/images/admin_avatar.png" },
                //TotalPosts = 6125,
                //RecentPosts = 6
                BoardAdmin = new Users { Name = "gary330105", AvatarUrl = "https://example.com/avatar.jpg" },
                TotalPosts = 5000,
                RecentPosts = 100,
                FeaturedPosts = new List<Post>
                {
                    new Post { Id = 1, Title = "超好玩的遊戲", Author = "player1", Comments = 50, Views = 1000, ImageUrl = "https://example.com/post1.jpg" },
                    new Post { Id = 2, Title = "新攻略分享", Author = "player2", Comments = 30, Views = 500, ImageUrl = "https://example.com/post2.jpg" }
                },
                AllPosts = new List<Post>
                {
                    new Post { Id = 1, Category = "攻略", Title = "新手入門指南", Author = "player1", Comments = 10, Views = 200, LastReplyTime = DateTime.Now },
                    new Post { Id = 2, Category = "閒聊", Title = "最近的新活動", Author = "player2", Comments = 20, Views = 500, LastReplyTime = DateTime.Now },
                    new Post { Id = 3, Category = "問題", Title = "這個裝備怎麼刷?", Author = "player3", Comments = 5, Views = 150, LastReplyTime = DateTime.Now }
                }

            };

            return View(model);
        }
    }
}
