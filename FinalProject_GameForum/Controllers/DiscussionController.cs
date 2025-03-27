using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Security.Claims;

namespace FinalProject_GameForum.Controllers
{
    public class DiscussionController : Controller
    {
        private readonly GameForumContext _context;
        private const int PageSize = 5; // 每頁顯示文章數量

        public DiscussionController(GameForumContext context)
        {
            _context = context;
        }

        // 討論區 看板列表
        public IActionResult Index(string? category, string? search)
        {
            var discussions = _context.Discussions.AsQueryable();

            // 按分類顯示看板，並依人氣排序
            if (!string.IsNullOrEmpty(category))
            {
                discussions = discussions.Where(d => d.Category == category);
            }

            // 搜尋看板
            if (!string.IsNullOrEmpty(search))
            {
                discussions = discussions.Where(d => d.DiscussionName.Contains(search));
            }

            // 最終結果都要按照人氣降序排序
            discussions = discussions.OrderByDescending(d => d.Views ?? 0);

            return View(discussions.ToList());
        }


        // 討論區首頁
        public IActionResult DisHome(int id)
        {
            var discussion = _context.Discussions
                .FirstOrDefault(d => d.DiscussionId == id);
            if (discussion == null)
            {
                return NotFound();  // 如果沒有這個看板，回傳 404
            }

            // 查詢該看板下 Views 最高的 3 筆文章（依 ArticleGroup 計算）
            var hotArticles = _context.ArticleGroups
                .Where(ag => ag.DiscussionId == id && !string.IsNullOrEmpty(ag.ArticleTitle))
                .OrderByDescending(ag => ag.Views ?? 0)
                .Take(3)
                .ToList();
            ViewBag.HotArticles = hotArticles;

            return View(discussion);
        }


        // 加載文章列表（按看板ID）
        public IActionResult LoadArticleList(int discussionId, string? category, string? search, int page = 1)
        {
            // 先取出所有屬於該討論版且狀態為 "存在" 的文章
            var articlesQuery = _context.Articles
                .Include(a => a.User)
                .Include(a => a.ArticleGroup)
                .Where(a => a.ArticleGroup.DiscussionId == discussionId && a.Status == "存在");

            // 按 ArticleGroup 的分類篩選
            if (!string.IsNullOrEmpty(category))
            {
                articlesQuery = articlesQuery.Where(a => a.ArticleGroup.Category == category);
            }

            // 按 ArticleGroup 的標題搜尋
            if (!string.IsNullOrEmpty(search))
            {
                articlesQuery = articlesQuery.Where(a => a.ArticleGroup.ArticleTitle.Contains(search));
            }

            // 取最早一筆文章作為樓主
            var groupedArticles = articlesQuery
                .AsEnumerable()
                .GroupBy(a => a.ArticleGroup.ArticleGroupId)
                .Select(g => g.OrderBy(a => a.PostDate).First())
                .OrderByDescending(a => a.PostDate);

            // 分頁邏輯：跳過 (page-1)*PageSize 筆，取 PageSize 筆
            var pagedArticles = groupedArticles
                .Skip((page - 1) * PageSize)
                .Take(PageSize)
                .ToList();

            // 如果需要回傳總頁數，可在ViewBag中傳遞
            int totalArticles = groupedArticles.Count();
            ViewBag.TotalPages = (int)System.Math.Ceiling(totalArticles / (double)PageSize);
            ViewBag.CurrentPage = page;

            return PartialView("_ArticleList", pagedArticles);
        }

        [HttpPost]
        [Authorize]
        public IActionResult Subscribe(int discussionId)
        {
            string UserId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? string.Empty;

            // 查詢是否已經訂閱
            var existingSubscription = _context.SubscribedDiscussions
                .FirstOrDefault(s => s.UserId == UserId && s.SubscribedDiscussionId == discussionId);

            if (existingSubscription == null)
            {
                // 如果還沒訂閱，則新增
                var newSubscription = new SubscribedDiscussion
                {
                    UserId = UserId,
                    DiscussionId = discussionId,
                    IsSubscribed = true
                };

                _context.SubscribedDiscussions.Add(newSubscription);
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
