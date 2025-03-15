using Microsoft.AspNetCore.Mvc;

namespace FinalProject_GameForum.Controllers
{
    public class ArticleEditController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public IActionResult SaveContent(string content)
        {
            // content 變數會接收到 HTML 格式的 Quill 內容
            System.IO.File.WriteAllText("wwwroot/tempcontent/content.html", content);

            return RedirectToAction("Index");
        }
    }
}
