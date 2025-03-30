using FinalProject_GameForum.Filters;
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

        public async Task<IActionResult> Index(string? category, string? search)
        {
            var NewsHome = await _context.News
                .OrderByDescending(n => n.EditDate)
                .Take(3)
                .ToListAsync();

                
            var NewsDetailQuery = _context.News.AsQueryable();

            if (!string.IsNullOrEmpty(category))
            {
                NewsDetailQuery = NewsDetailQuery.Where(n => n.Category != null && n.Category == category);
            }

            var NewsDetail = await NewsDetailQuery
                .OrderByDescending(n => n.EditDate)
                .Include(n => n.NewsImages)
                .Include(n => n.NewsMessages)
                .Take(10)
                .ToListAsync();

			

		var model = new NewsViewModel
            {
                NewsHome = NewsHome,
                NewsDetail = NewsDetail
            };
            return View(model);
        }

		/* 搜索功能 */
		public IActionResult Search(string search)
		{
			if (string.IsNullOrEmpty(search))
			{
				return RedirectToAction("Index");
			}

			var news = _context.News
				.Where(n => n.NewsTitle.Contains(search) ||
						   (n.NewsContent != null && n.NewsContent.Contains(search)))
				.ToList();

			return View(news);
		}
	
	public async Task<IActionResult> News(int id, string messageContent)
        {
            var userId = User.Identity?.IsAuthenticated == true 
                ? User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value 
                : null;

            ViewBag.IsAuthenticated = User.Identity?.IsAuthenticated == true;


                var newsDetail = await _context.News
                    .Include(n => n.NewsImages)
                    .Include(n => n.NewsMessages)
                    .ThenInclude(m => m.User)
                    .FirstOrDefaultAsync(n => n.NewsId == id);

            ViewBag.NewsMessages = newsDetail?.NewsMessages != null
                ? newsDetail.NewsMessages.OrderBy(m => m.EditDate).ToList() 
                : new List<NewsMessage>();

            ViewBag.RelatedNews = newsDetail?.NewsMessages != null ? await _context.News
                .Where(n => n.Category == newsDetail.Category && n.NewsId != id)  
                .OrderByDescending(n => n.EditDate)
                .Take(3)
                .ToListAsync()
                : new List<News>(); 

            var model = new NewsViewModel
            {
                NewsDetail = newsDetail != null ? new List<News> { newsDetail } : new List<News>(),
                NewsHome = await _context.News
                    .OrderByDescending(n => n.EditDate)
                    .Take(5)
                    .ToListAsync()
            };

            if (userId == null)
            {
                ModelState.AddModelError(string.Empty, "請先登入!!");
                return View(model);
            }

            if (string.IsNullOrWhiteSpace(messageContent))
            {
                ModelState.AddModelError("messageContent", "留言內容不能為空。");
                return View(model);
            }

            var user = await _context.Users.FirstOrDefaultAsync(u => u.UserId == userId);

            if (user == null)
            {
                ModelState.AddModelError(string.Empty, "用戶不存在");
                return View(model);
            }

            var newMessage = new NewsMessage
            {
                NewsId = id,
                MessageContent = messageContent,
                UserId = userId,
                EditDate = DateTime.UtcNow,
                User = user
            };

            _context.NewsMessages.Add(newMessage);
            await _context.SaveChangesAsync();

            return RedirectToAction("News", new { id });

        }
        public class NewsViewModel
        {
            public List<News> NewsHome { get; set; } = new List<News>();
            public List<News> NewsDetail { get; set; } = new List<News>();
        }
    }    
}
