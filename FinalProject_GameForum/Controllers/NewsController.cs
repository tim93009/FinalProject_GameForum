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
                .Take(8)
                .ToListAsync();

            var model = new NewsViewModel
            {
                NewsHome = NewsHome,
                NewsDetail = NewsDetail
            };
            return View(model);
        }
        public async Task<IActionResult> News(int id, string messageContent)
        {
            var userId = User.Identity?.IsAuthenticated == true ? User.Identity.Name : null;
            ViewBag.IsAuthenticated = User.Identity?.IsAuthenticated == true;

            if (userId == null)
            {
                ModelState.AddModelError(string.Empty, "請先登入!!");

                var newsDetail = await _context.News
                    .Include(n => n.NewsImages)
                    .Include(n => n.NewsMessages)
                    .FirstOrDefaultAsync(n => n.NewsId == id);

                ViewBag.NewsMessages = newsDetail?.NewsMessages != null
                ? newsDetail.NewsMessages.OrderByDescending(m => m.EditDate)
                .ToList() : new List<NewsMessage>();

                ViewBag.RelatedNews = await _context.News
                .Where(n => n.NewsId != id)  
                .OrderByDescending(n => n.EditDate)
                .Take(3)
                .ToListAsync();

                var model = new NewsViewModel
                {
                    NewsDetail = newsDetail != null ? new List<News> { newsDetail } : new List<News>(),
                    NewsHome = await _context.News
                        .OrderByDescending(n => n.EditDate)
                        .Take(5)
                        .ToListAsync()
                };

                return View(model);
            }

            if (string.IsNullOrWhiteSpace(messageContent))
            {
                ModelState.AddModelError("messageContent", "留言內容不能為空。");

                var newsDetail = await _context.News
                    .Include(n => n.NewsImages)
                    .Include(n => n.NewsMessages)
                    .FirstOrDefaultAsync(n => n.NewsId == id);

                ViewBag.NewsMessages = newsDetail?.NewsMessages != null
                ? newsDetail.NewsMessages.OrderByDescending(m => m.EditDate)
                .ToList() : new List<NewsMessage>();

                ViewBag.RelatedNews = await _context.News
                .Where(n => n.NewsId != id)
                .OrderByDescending(n => n.EditDate)
                .Take(3)
                .ToListAsync();

                var model = new NewsViewModel
                {
                    NewsDetail = newsDetail != null ? new List<News> { newsDetail } : new List<News>(),
                    NewsHome = await _context.News.OrderByDescending(n => n.EditDate).Take(5).ToListAsync()
                };

                return View(model);
            }

            var newMessage = new NewsMessage
            {
                NewsId = id,
                MessageContent = messageContent,
                UserId = userId,
                EditDate = DateTime.UtcNow
            };

            _context.NewsMessages.Add(newMessage);
            await _context.SaveChangesAsync();

            return RedirectToAction("News", new { id });

        }

    }

}
