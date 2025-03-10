using Microsoft.AspNetCore.Mvc;

namespace FinalProject_GameForum.Controllers
{
    public class ArticleController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
