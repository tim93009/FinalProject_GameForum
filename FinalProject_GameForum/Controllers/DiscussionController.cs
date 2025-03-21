using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FinalProject_GameForum.Controllers
{
    public class DiscussionController : Controller
    {
        private readonly GameForumContext _context;

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

            return View(discussion);  // 傳遞 Discussion 模型到 View
        }



        // 加載文章列表（按看板ID）
        public IActionResult LoadArticleList(int discussionId, string? category, string? search)
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
                .OrderByDescending(a => a.PostDate)
                .ToList();

            return PartialView("_ArticleList", groupedArticles);
        }
        


    }
}
