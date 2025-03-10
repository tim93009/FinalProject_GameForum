using Microsoft.AspNetCore.Mvc;

namespace FinalProject_GameForum.Controllers
{
    public class PersonalController : Controller
    {
        public IActionResult Personal()
        {
            return View();
        }
    }
}
