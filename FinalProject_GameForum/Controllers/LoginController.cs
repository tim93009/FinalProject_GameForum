using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Mvc;
using NuGet.Protocol;

namespace FinalProject_GameForum.Controllers
{
    public class LoginController : Controller
    {
        private readonly MyDbContext _context;

        public LoginController(MyDbContext context)
        {
            _context = context;
        }
        public IActionResult Login()
        {
            return View();
        }

        public IActionResult Register() 
        {
            return View();
        }



        //[HttpPost]
        //public IActionResult Register(User user)
        //{
        //    var TrueUser = _context.User.Where(u => u.user_id == user.user_id).Select(u => u.user_id).FirstOrDefault();
        //    if (TrueUser != null)
        //    {
        //        TempData["Error"] = "帳號已經存在，請嘗試使別的帳號!";
        //        return RedirectToAction("Register");
        //    }

        //    return RedirectToAction("Index", "Home");

             

        //}

        public IActionResult ForgotPW()
        {
            return View();
        }
    }
}
