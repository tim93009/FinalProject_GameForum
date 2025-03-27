using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ganss.Xss;
using AngleSharp.Dom;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;

namespace FinalProject_GameForum.Controllers
{
    [Authorize]
    public class ArticleEditController : Controller
    {
        private readonly GameForumContext _context;
        private string userId => User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? string.Empty; // 取得登入使用者 ID

        public ArticleEditController(GameForumContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<IActionResult> Index(int? id)
        {
            var articleGroup = await _context.Discussions
                .FirstOrDefaultAsync(g => g.DiscussionId == id);

            if (articleGroup != null)
            {
                ViewBag.IsReply = true;
                ViewBag.DiscussionId = id;
            }

            return View();
        }

        [HttpGet]
        public async Task<IActionResult> Reply(int? articleGroupId)
        {
            var articleGroup = await _context.ArticleGroups
                .FirstOrDefaultAsync(g => g.ArticleGroupId == articleGroupId);

            if (articleGroup != null)
            {
                ViewBag.IsReply = true;
                ViewBag.ArticleGroupId = articleGroupId;
                ViewBag.ArticleTitle = $"Re: {articleGroup.ArticleTitle}";
                ViewBag.Category = articleGroup.Category;
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
        public async Task<IActionResult> Submit(int discussionId, string articleTitle, string articleContent, IFormFile imgFile, string articleType, string action)
        {
            // 驗證輸入
            if (action == "publish" && (string.IsNullOrEmpty(articleTitle) || string.IsNullOrEmpty(articleContent)))
            {
                ModelState.AddModelError("", "標題和內容不能為空");
                return View("Index");
            }

            var articleLocation = await _context.Discussions
                .FirstOrDefaultAsync(g => g.DiscussionId == discussionId);

            CheckHtml(articleContent);

            // 處理封面圖片 (如果有上傳)
            byte[]? coverImage = null;
            if (imgFile != null && imgFile.Length > 0)
            {
                using (MemoryStream ms = new MemoryStream())
                {
                    await imgFile.CopyToAsync(ms);
                    coverImage = ms.ToArray();
                } 
            }

            // 判斷是否是儲存草稿
            bool isDraft = action == "saveDraft";

            var articleGroup = new ArticleGroup
            {
                DiscussionId = discussionId,
                Category = articleType,
                Views = 0,
                ArticleTitle = articleTitle,
                CoverImage = coverImage
            };

            _context.ArticleGroups.Add(articleGroup);
            await _context.SaveChangesAsync();

            // 創建發文（Article）
            var article = new Article
            {
                UserId = userId,
                ArticleContent = articleContent,
                PostDate = DateTime.Now,
                EditDate = null,
                Status = isDraft ? "草稿" : "存在",
                ArticleGroupId = articleGroup.ArticleGroupId // 這裡使用自動產生的 ArticleGroupId
            };

            // 存入資料庫
            _context.Articles.Add(article);
            await _context.SaveChangesAsync();

            // 根據狀態選擇跳轉頁面
            if (isDraft)
            {
                return RedirectToAction("Index", "Article");
            }
            else
            {
                return RedirectToAction("Index", "Article", new { id = articleGroup.ArticleGroupId });
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> ReplyArticle(string articleContent, int? articleGroupId)
        {
            var articleLocation = await _context.ArticleGroups
            .FirstOrDefaultAsync(g => g.ArticleGroupId == articleGroupId);

            CheckHtml(articleContent);

            // 創建回文（Article）
            var article = new Article
            {
                UserId = userId,
                ArticleGroupId = articleGroupId,
                ArticleContent = articleContent,
                PostDate = DateTime.Now,
                EditDate = null,
                Status = "存在"
            };

            // 存入資料庫
            _context.Articles.Add(article);
            await _context.SaveChangesAsync();

            // 重定向到該文章群組的頁面（假設有個顯示頁面）
            return RedirectToAction("Index", "Article", new { id = articleGroupId });
        }
    }
}
