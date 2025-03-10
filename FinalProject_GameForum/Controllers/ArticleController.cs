using Microsoft.AspNetCore.Mvc;

namespace FinalProject_GameForum.Controllers
{
    public class ArticleController : Controller
    {
        public IActionResult Index()
        {
            ViewBag.Name = "五冠王";
            ViewBag.Id = "faker";
            ViewBag.CreteTime = DateTime.Now.ToString();
            return View();
        }
    }
}
