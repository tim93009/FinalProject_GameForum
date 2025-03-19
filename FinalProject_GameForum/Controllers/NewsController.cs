using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Threading.Tasks;

namespace FinalProject_GameForum.Controllers
{
    public class NewsController : Controller
    {
        private readonly GameForumContext _context;
        public NewsController(GameForumContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            var NewsHome = await _context.News
                .OrderByDescending(n => n.EditDate)
                .Take(3)
                .ToListAsync();

            var NewsDetail = await _context.News
                .OrderByDescending(n => n.EditDate)
                .Include(n => n.NewsImages)
                .Include(n => n.NewsMessages)
                .ToListAsync();

            var model = new NewsViewModel
            {
                NewsHome = NewsHome,
                NewsDetail = NewsDetail
            };
            var news = _context.News.ToList();
            return View(model);
        }
        public IActionResult News(int id)
        {
            var newsItem = _context.News
            .Include(n => n.NewsImages)
            .Include(n => n.NewsMessages)
            .FirstOrDefault(n => n.NewsId == id);

            if(newsItem == null)
            {
                return NotFound();
            }

			var newsMessages = _context.NewsMessages
						.Where(m => m.NewsId == id)
						.OrderByDescending(m => m.EditDate)
						.ToList();

			ViewBag.NewsMessages = newsMessages ?? new List<NewsMessage>();

			var relatedNews = _context.News
            .Where(n => n.NewsId != id)
            .Take(3)
            .ToList();

            ViewBag.RelatedNews = relatedNews;


            return View(newsItem);
        }

    }

}
