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
        private string UserId => User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? string.Empty; // 取得登入使用者 ID

        public ArticleController(GameForumContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult Index(int id, int page = 1, int pageSize = 10)
        {
            // 查詢當前文章群組
            ArticleGroup? currentArticleGroup = _context.ArticleGroups
            .Include(ag => ag.Articles)
            .FirstOrDefault(ag => ag.ArticleGroupId == id);

            if (currentArticleGroup == null)
            {
                return NotFound();
            }

            // 計算總數
            int totalArticles = _context.Articles.Count(a => a.ArticleGroupId == id);

            // 查詢當前文章群組的文章（分頁處理）
            List<Article> articles = _context.Articles
                .Include(a => a.ArticleGroup)
                .Include(a => a.User)
                .Include(a => a.ArticleMessages)
                    .ThenInclude(am => am.User)
                .Where(a => a.ArticleGroupId == id && a.Status == "存在")
                .OrderBy(a => a.PostDate)
                .Skip((page - 1) * pageSize) // 跳過前面 (page-1) * pageSize 篇文章
                .Take(pageSize) // 取 pageSize 篇文章
                .ToList();

            // 計算總頁數
            int totalPages = (int)Math.Ceiling(totalArticles / (double)pageSize);

            // 查詢同看板同類別的其他文章（延伸閱讀）
            var relatedArticles = _context.Articles
                .Include(a => a.ArticleGroup)
                .Where(a => a.ArticleGroup!.DiscussionId == currentArticleGroup.DiscussionId
                         && a.ArticleGroup.Category == currentArticleGroup.Category
                         && a.ArticleGroupId != id
                         && a.Status == "存在") // 排除當前文章群組
                .Take(4) // 限制為 4 篇
                .Select(a => new
                {
                    a.ArticleGroupId,
                    a.ArticleGroup!.Category,
                    Title = a.ArticleGroup!.ArticleTitle,
                    Image = a.ArticleGroup.CoverImage != null
                        ? $"data:image/jpeg;base64,{Convert.ToBase64String(a.ArticleGroup.CoverImage)}"
                        : null
                })
                .ToList();

            // 不足四篇的情況 
            if (relatedArticles.Count < 4)
            {
                var existingIds = relatedArticles.Select(a => a.ArticleGroupId).ToHashSet(); // 使用 HashSet 提高查找效率
                var additionalArticles = _context.Articles
                    .Include(a => a.ArticleGroup)
                    .Where(a => a.ArticleGroup!.DiscussionId == currentArticleGroup.DiscussionId
                             && a.ArticleGroupId != id
                             && !existingIds.Contains(a.ArticleGroupId)
                             && a.Status == "存在") // 排除已選取的文章
                    .GroupBy(a => a.ArticleGroupId) // 按 ArticleGroupId 分組，避免重複
                    .Select(g => g.First()) // 每組取第一篇
                    .Take(4 - relatedArticles.Count)
                    .AsEnumerable() // 切換到客戶端處理
                    .Select(a => new
                    {
                        a.ArticleGroupId,
                        a.ArticleGroup!.Category,
                        Title = a.ArticleGroup!.ArticleTitle,
                        Image = a.ArticleGroup.CoverImage != null
                            ? $"data:image/jpeg;base64,{Convert.ToBase64String(a.ArticleGroup.CoverImage)}"
                            : null
                    })
                    .ToList();
                relatedArticles.AddRange(additionalArticles);
            }

            // 查詢是否已訂閱
            bool isSubscribed = _context.SubscribedArticles
                .Any(sa => sa.UserId == UserId && sa.ArticleGroupId == id && sa.IsSubscribed == true);


            ViewBag.UserId = UserId;
            ViewBag.ArticleGroupId = id;
            ViewBag.RelatedArticles = relatedArticles;
            ViewBag.PageSize = pageSize;
            ViewBag.Page = page;
            ViewBag.TotalPages = totalPages;
            ViewBag.Subscribed = isSubscribed;
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
                UserId = UserId,
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

        [HttpPost]
        [Authorize]
        public IActionResult Subscribe(int articleGroupId)
        {
            // 查詢是否已經訂閱
            var existingSubscription = _context.SubscribedArticles
                .FirstOrDefault(s => s.UserId == UserId && s.ArticleGroupId == articleGroupId);

            if (existingSubscription == null)
            {
                // 如果還沒訂閱，則新增
                var newSubscription = new SubscribedArticle
                {
                    UserId = UserId,
                    ArticleGroupId = articleGroupId,
                    IsSubscribed = true
                };

                _context.SubscribedArticles.Add(newSubscription);
                _context.SaveChanges();

                return Json(new { success = true, message = "訂閱成功！", isSubscribed = true });
            }
            else
            {
                // 如果已經訂閱，則取消訂閱
                existingSubscription.IsSubscribed = !existingSubscription.IsSubscribed;
                _context.SaveChanges();

                string message = (existingSubscription.IsSubscribed ?? false) ? "訂閱成功！" : "已取消訂閱。";
                return Json(new { success = true, message, isSubscribed = existingSubscription.IsSubscribed });
            }
        }
    }
}
