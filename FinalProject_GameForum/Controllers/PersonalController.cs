using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Mvc;

namespace FinalProject_GameForum.Controllers
{
    public class PersonalController : Controller
    {
        private readonly GameForumContext _context;
        public PersonalController(GameForumContext context)
        {
            _context = context;
        }
        public IActionResult Personal()
        {
           
            return View();
        }
        public IActionResult Collect()
        {
            return View();
        }
        public IActionResult Log()
        {
            return View();
        }
        public IActionResult Friends()
        {
            return View();
        }
    }
}
