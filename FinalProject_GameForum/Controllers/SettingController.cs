using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using System.Security.Claims;

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
            Debug.WriteLine(user.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value);
            var userID = user.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
            var userdb = _context.Users.FirstOrDefault(u => u.UserId == userID);
            if(userdb != null)
            {
                var userinfo = new User()
                {
                    Nickname = userdb.Nickname,
                    Email = userdb.Email,
                    PhotoUrl = userdb.PhotoUrl
                };

                return View(userinfo);
            }
            else
            {
                return NotFound();
            }
           
        }


        [HttpPost]
        public IActionResult Setting(string Nickname, string Photourl)
        {
           Debug.WriteLine(Photourl);
            var TrueUserId = HttpContext.User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)!.Value;
            var userEntity = _context.Users.Find(TrueUserId);
            if(userEntity == null)
            {
                return NotFound();
            }
            userEntity.Nickname = Nickname;
            
            userEntity.PhotoUrl = Photourl;

            _context.SaveChanges();

            return View(userEntity);
        }

        public IActionResult Permissions()
        {
            return View();
        }
        
    }
}
