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

        public IActionResult Index()
        {
            return View();
        }

        // 討論區首頁
        public IActionResult DisHome()
        {
            var articles = _context.Articles
                .Include(a => a.User)
                .Include(a => a.ArticleGroup)
                .OrderByDescending(a => a.PostDate)
                .ToList();

            return View(articles);
        }

        // 加載文章列表
        public IActionResult LoadArticleList()
        {
            var articles = _context.Articles
                .Include(a => a.User)
                .Include(a => a.ArticleGroup)
                .OrderByDescending(a => a.PostDate)
                .ToList();

            return PartialView("_ArticleList", articles);  // 返回部分視圖
        }

    }
}
