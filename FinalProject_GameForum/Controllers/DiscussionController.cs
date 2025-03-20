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

            // 按分類顯示看板
            if (!string.IsNullOrEmpty(category))
            {
                discussions = discussions.Where(d => d.Category == category);
            }

            // 搜尋看板
            if (!string.IsNullOrEmpty(search))
            {
                discussions = discussions.Where(d => d.DiscussionName.Contains(search));
            }

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
            var articles = _context.Articles
                .Include(a => a.User)
                .Include(a => a.ArticleGroup)  // 包含 ArticleGroup，才能訪問其中的屬性
                .Where(a => a.ArticleGroup.DiscussionId == discussionId);

            // 按分類顯示文章
            if (!string.IsNullOrEmpty(category))
            {
                articles = articles.Where(a => a.ArticleGroup.Category == category);
            }

            // 按標題搜尋文章（標題包含關鍵字）
            if (!string.IsNullOrEmpty(search))
            {
                articles = articles.Where(a => a.ArticleGroup.ArticleTitle.Contains(search));
            }

            var articleList = articles.OrderByDescending(a => a.PostDate).ToList();

            return PartialView("_ArticleList", articleList);
        }







    }
}
