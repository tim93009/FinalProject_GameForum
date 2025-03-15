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
                FeaturedPosts = new List<Post>
                {
                    new Post { Title = "【密技】DiscordBOT 提醒您放風時間結束了", Author = "TMSBug_v2", Comments = 12, ImageUrl = "/images/post1.jpg" },
                    new Post { Title = "【劇情】奧術之河重製！(更新至艾斯佩拉)", Author = "寶家", Comments = 29, ImageUrl = "/images/post2.jpg" }
                },
                BoardAdmin = new Users { Name = "管理員", AvatarUrl = "/images/admin_avatar.png" },
                TotalPosts = 6125,
                RecentPosts = 6
            };

            return View(model);
        }
    }
}
