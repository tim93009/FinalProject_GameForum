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
        private string userId => User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? string.Empty; // 取得登入使用者 ID

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

        [HttpPost]
        [Authorize]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> MessageSubmit(string messageContent, int articleId, int articleGroupId)
        {
            Article? articleLocation = await _context.Articles
            .FirstOrDefaultAsync(a => a.ArticleId == articleId);

            // 創建留言
            var message = new ArticleMessage()
            {
                UserId = userId,
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
    }
}
