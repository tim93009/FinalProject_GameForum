using Microsoft.AspNetCore.Mvc;

namespace FinalProject_GameForum.Controllers
{
    public class DiscussionController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
