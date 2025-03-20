using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ganss.Xss;
using AngleSharp.Dom;

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

            // **自訂允許的 HTML 標籤**
            var sanitizer = new HtmlSanitizer();
            sanitizer.AllowedTags.Add("img");
            sanitizer.AllowedAttributes.Add("src");
            sanitizer.AllowedAttributes.Add("alt");
            sanitizer.AllowedTags.Add("a");
            sanitizer.AllowedAttributes.Add("href");

            // 允許 <iframe>
            sanitizer.AllowedTags.Add("iframe");
            sanitizer.AllowedAttributes.Add("src");
            sanitizer.AllowedAttributes.Add("frameborder");
            sanitizer.AllowedAttributes.Add("allowfullscreen");
            sanitizer.AllowedAttributes.Add("class");

            // 過濾 URL，確保 <iframe> 只允許 YouTube
            sanitizer.PostProcessNode += (s, e) =>
            {
                if (e.Node is IElement element && element.TagName.Equals("iframe", StringComparison.OrdinalIgnoreCase))
                {
                    var srcAttribute = element.GetAttribute("src");
                    if (srcAttribute != null &&
                        !srcAttribute.StartsWith("https://www.youtube.com/embed/") &&
                        !srcAttribute.StartsWith("https://youtube.com/embed/"))
                    {
                        element.Remove(); // 移除不安全的 <iframe>
                    }
                }
            };

            // 過濾文章內容
            articleContent = sanitizer.Sanitize(articleContent);

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
