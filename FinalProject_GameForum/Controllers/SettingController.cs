using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace FinalProject_GameForum.Controllers
{
  
    
    
    public class SettingController : Controller
    {
        private readonly GameForumContext _context;

        public SettingController(GameForumContext context)
        {
            _context = context;
        }
        [Authorize]
        public IActionResult Setting()
        {
            var user = HttpContext.User;

            var userinfo = new User()
            {
                Nickname = user.Identity!.Name!,
                Email = user.Claims.FirstOrDefault(c => c.Type == "email")?.Value,
            };
            
            return View(userinfo);
        }
        public IActionResult Permissions()
        {
            return View();
        }
        
    }
}
