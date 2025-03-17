using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Mvc;

namespace FinalProject_GameForum.Controllers
{
    public class ArticleEditController : Controller
    {
        private readonly GameForumContext _context;

        public ArticleEditController(GameForumContext context)
        {
            _context = context;
        }

        public IActionResult Index()
        {
            return View();
        }

        //[HttpPost]
        //public IActionResult SaveContent(string content)
        //{
        //    // content 變數會接收到 HTML 格式的 Quill 內容
        //    System.IO.File.WriteAllText("wwwroot/tempcontent/content.html", content);

        //    return RedirectToAction("Index");
        //}

        [HttpPost]
        public async Task<IActionResult> Submit(IFormFile? image, string userId, string questionType, string content)
        {
            var article = new Article
            {
                UserId = userId,
                ArticleContent = content
            };

            _context.Articles.Add(article);
            await _context.SaveChangesAsync();

            return RedirectToAction("Index", "Home");
        }
    }
}
