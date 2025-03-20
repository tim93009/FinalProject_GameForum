using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FinalProject_GameForum.Controllers
{
    public class ArticleEditController : Controller
    {
        private readonly GameForumContext _context;

        public ArticleEditController(GameForumContext context)
        {
            _context = context;
        }

        public IActionResult Index()
        {
            return View();
        }
       

        [HttpPost]
        public async Task<IActionResult> Submit(string articleTitle, int articleType, string articleContent, IFormFile imgFile)
        {
            if (string.IsNullOrEmpty(articleTitle) || string.IsNullOrEmpty(articleContent))
            {
                ModelState.AddModelError("", "標題和內容不能為空");
                return View();
            }

            // 找到對應的 ArticleGroup (文章分類)
            ArticleGroup articleGroup = await _context.ArticleGroups.FirstAsync(g => g.ArticleGroupId == 1);            


            // 讀取封面圖片 (存入 byte[] 格式)
            byte[]? coverImage = null;
            if (imgFile != null && imgFile.Length > 0)
            {
                using (MemoryStream ms = new MemoryStream())
                {
                    await imgFile.CopyToAsync(ms);
                    coverImage = ms.ToArray();
                }
                articleGroup.CoverImage = coverImage; // 更新封面圖片
            }

            // 創建文章物件
            var article = new Article
            {
                UserId = "User001",
                ArticleGroupId = 1,
                ArticleContent = articleContent,
                PostDate = DateTime.Now,
                Status = "文章"
            };

            // 存入資料庫
            _context.Articles.Add(article);
            await _context.SaveChangesAsync();

            return RedirectToAction("Index" ,"Home");
        }
    }
}
