using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Mvc;

namespace FinalProject_GameForum.Controllers
{
    public class NewsController : Controller
    {
        private readonly GameForumContext _context;
        public NewsController(GameForumContext context)
        {
            _context = context;
        }

        public IActionResult Index()
        {
            var news = _context.News.ToList();
            return View(news);
        }
        public IActionResult News()
        {
            return View();
        }
    }

}
