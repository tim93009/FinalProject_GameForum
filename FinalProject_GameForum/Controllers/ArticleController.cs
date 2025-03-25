using System.Security.Claims;
using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FinalProject_GameForum.Controllers
{
    public class ArticleController : Controller
    {
        private readonly GameForumContext _context;
        private string userId => User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? string.Empty; // 取得登入使用者 ID

        public ArticleController(GameForumContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult Index(int id)
        {
            // 查詢當前文章群組
            ArticleGroup? currentArticleGroup = _context.ArticleGroups
            .Include(ag => ag.Articles)
            .FirstOrDefault(ag => ag.ArticleGroupId == id);

            if (currentArticleGroup == null)
            {
                return NotFound();
            }

            // 查詢當前文章群組的文章
            List<Article> articles = _context.Articles
           .Include(a => a.ArticleGroup)
           .Include(a => a.User)
           .Include(a => a.ArticleMessages)
               .ThenInclude(am => am.User)
           .Where(a => a.ArticleGroupId == id)
           .ToList();

            // 查詢同看板同類別的其他文章（延伸閱讀）
            var relatedArticles = _context.Articles
                .Where(a => a.ArticleGroup!.DiscussionId == currentArticleGroup.DiscussionId
                         && a.ArticleGroup.Category == currentArticleGroup.Category
                         && a.ArticleGroupId != id) // 排除當前文章群組
                .Take(4) // 限制為 4 篇
                .Select(a => new
                {
                    a.ArticleGroupId,
                    Title = a.ArticleGroup!.ArticleTitle,
                    Image = a.ArticleGroup.CoverImage != null
                        ? $"data:image/jpeg;base64,{Convert.ToBase64String(a.ArticleGroup.CoverImage)}"
                        : null
                })
                .ToList();

            // 不足四篇的情況 
            if (relatedArticles.Count < 4)
            {
                var additionalArticles = _context.Articles
                    .Where(a => a.ArticleGroup!.DiscussionId == currentArticleGroup.DiscussionId
                             && a.ArticleGroupId != id)
                    .Take(4 - relatedArticles.Count)
                    .Select(a => new
                    {
                        a.ArticleGroupId,
                        Title = a.ArticleGroup!.ArticleTitle,
                        Image = a.ArticleGroup.CoverImage != null 
                        ? $"data:image/jpeg;base64,{Convert.ToBase64String(a.ArticleGroup.CoverImage)}" 
                        : null
                    })
                    .ToList();
                relatedArticles.AddRange(additionalArticles);
            }

            ViewBag.ArticleGroupId = id;
            ViewBag.RelatedArticles = relatedArticles;
            return View(articles);
        }

        [HttpPost]
        [Authorize]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> MessageSubmit(string messageContent, int articleId, int articleGroupId)
        {
            Article? articleLocation = await _context.Articles
            .FirstOrDefaultAsync(a => a.ArticleId == articleId);

            if (articleLocation == null)
            {
                return NotFound();
            }

            // 創建留言
            var message = new ArticleMessage()
            {
                UserId = userId,
                ArticleId = articleId,
                MessageContent = messageContent,
                EditDate = DateTime.Now,
            };

            // 存入資料庫
            _context.ArticleMessages.Add(message);
            await _context.SaveChangesAsync();

            // 重定向到該文章群組的頁面
            return RedirectToAction("Index", "Article", new { id = articleGroupId });
        }
    }
}
