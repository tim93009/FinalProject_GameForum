using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ganss.Xss;
using AngleSharp.Dom;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;

namespace FinalProject_GameForum.Controllers
{
    public class ArticleEditController : Controller
    {
        private readonly GameForumContext _context;
        private string userId => User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? string.Empty; // 取得登入使用者 ID

        public ArticleEditController(GameForumContext context)
        {
            _context = context;
        }

        [HttpGet]
        [Authorize]
        public async Task<IActionResult> Index(int? articleGroupId)
        {
            if (articleGroupId.HasValue)
            {

                var articleGroup = await _context.ArticleGroups
                    .FirstOrDefaultAsync(g => g.ArticleGroupId == articleGroupId.Value);

                if (articleGroup != null)
                {
                    ViewBag.IsReply = true;
                    ViewBag.ArticleGroupId = articleGroupId.Value;
                    ViewBag.ArticleTitle = $"Re: {articleGroup.ArticleTitle}";
                    ViewBag.Category = articleGroup.Category;
                }
            }
            else
            {
                ViewBag.IsReply = false;
            }

            return View();
        }

        [HttpGet]
        [Authorize]
        public async Task<IActionResult> Reply(int? articleGroupId)
        {
            if (articleGroupId.HasValue)
            {

                var articleGroup = await _context.ArticleGroups
                    .FirstOrDefaultAsync(g => g.ArticleGroupId == articleGroupId.Value);

                if (articleGroup != null)
                {
                    ViewBag.IsReply = true;
                    ViewBag.ArticleGroupId = articleGroupId.Value;
                    ViewBag.ArticleTitle = $"Re: {articleGroup.ArticleTitle}";
                    ViewBag.Category = articleGroup.Category;
                }
            }
            else
            {
                ViewBag.IsReply = false;
            }

            return View();
        }

        private static string CheckHtml(string input)
        {
            // 自訂允許的 HTML 標籤
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
            return sanitizer.Sanitize(input);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Submit(int discussionId, string articleTitle, string articleContent, IFormFile imgFile)
        {
            // 驗證輸入
            if (string.IsNullOrEmpty(articleTitle) || string.IsNullOrEmpty(articleContent))
            {
                ModelState.AddModelError("", "標題和內容不能為空");
                return View("Index");
            }

            var articleLocation = await _context.ArticleGroups
                .FirstOrDefaultAsync(g => g.DiscussionId == discussionId);

            CheckHtml(articleContent);

            if (articleLocation == null)
            {
                ModelState.AddModelError("", "指定的版或文章群組不存在");
                return View("Index");
            }

            // 處理封面圖片 (如果有上傳)
            byte[]? coverImage = null;
            if (imgFile != null && imgFile.Length > 0)
            {
                using (MemoryStream ms = new MemoryStream())
                {
                    await imgFile.CopyToAsync(ms);
                    coverImage = ms.ToArray();
                }
                articleLocation.CoverImage = coverImage; // 更新 ArticleGroup 的封面圖片
                _context.ArticleGroups.Update(articleLocation);
            }

            // 創建回文（Article）
            var article = new Article
            {
                UserId = userId,
                ArticleContent = articleContent,
                PostDate = DateTime.Now,
                EditDate = null,
                Status = "存活"
            };

            // 存入資料庫
            _context.Articles.Add(article);
            await _context.SaveChangesAsync();

            // 重定向到該文章群組的頁面（假設有個顯示頁面）
            return RedirectToAction("Index", "Article");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> ReplyArticle(int discussionId, string articleContent, int? articleGroupId)
        {
            if (articleGroupId.HasValue)
            {
                var articleLocation = await _context.ArticleGroups
                .FirstOrDefaultAsync(g => g.ArticleGroupId == articleGroupId);

                CheckHtml(articleContent);

                // 創建回文（Article）
                var article = new Article
                {
                    UserId = userId,
                    ArticleGroupId = articleGroupId.Value,
                    ArticleContent = articleContent,
                    PostDate = DateTime.Now,
                    EditDate = null,
                    Status = "存活"
                };

                // 存入資料庫
                _context.Articles.Add(article);
                await _context.SaveChangesAsync();

                // 重定向到該文章群組的頁面（假設有個顯示頁面）
                return RedirectToAction("Index", "Article", new { id = articleGroupId.Value });
            }
            return View("Index", "Home");
        }
    }
}
