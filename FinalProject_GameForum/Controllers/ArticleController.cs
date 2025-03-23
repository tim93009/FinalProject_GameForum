using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FinalProject_GameForum.Controllers
{
    public class ArticleController : Controller
    {
        private readonly GameForumContext _context;

        public ArticleController(GameForumContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult Index(int id)
        {
            List<Article> articles = _context.Articles
           .Include(a => a.ArticleGroup)
           .Include(a => a.User)
           .Include(a => a.ArticleMessages)
               .ThenInclude(m => m.User)
           .Where(a => a.ArticleGroupId == id)
           .ToList();

            ViewBag.ArticleGroupId = id;
            return View(articles);
        }
    }
}
