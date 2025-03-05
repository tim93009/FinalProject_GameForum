using Microsoft.AspNetCore.Mvc;

namespace FinalProject_GameForum.Controllers
{
    public class ProductController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
