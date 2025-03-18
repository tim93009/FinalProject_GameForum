
using System.Security.Claims;
using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using NuGet.Protocol;
using Microsoft.AspNetCore.Authorization;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore.Query.SqlExpressions;
using BCrypt.Net;
using Microsoft.CodeAnalysis.Scripting;

namespace FinalProject_GameForum.Controllers
{
    public class LoginController : Controller
    {
        private readonly GameForumContext _context;
        protected UserInfoService _userInfo { get; set; }

        public LoginController(GameForumContext context, UserInfoService userInfo)
        {
            _context = context;
            _userInfo = userInfo;
        }
        public IActionResult Login()
        {
            return View();

        }
        [HttpPost]
        public IActionResult Login(LoginPost loginPost)
        {
            var account = loginPost.Account!.Trim();
            bool isEmail = account.Contains("@");


            User? user = isEmail
                ? _context.Users.SingleOrDefault(u => u.Email == loginPost.Account)
                : _context.Users.SingleOrDefault(u => u.UserId == loginPost.Account);


            if (user == null || !BCrypt.Net.BCrypt.Verify(loginPost.Password_P, user.Password))
            {
                TempData["Error"] = "帳號密碼錯誤，請修改!";
                return RedirectToAction("Login");
            }

            else
            {
                //Identity 要求Claim類別格式對應指派登入成功的用戶資料
                var varClaims = new List<Claim>
                {
                    new Claim(ClaimTypes.Name, user.Nickname),
                    new Claim("FullName", user.Nickname),
                    new Claim(ClaimTypes.Email, user.Email!),
                    new Claim("UserEmail", user.Email!),
                    new Claim("UserPW", user.Password)
                };
                //建構ClaimsIdentity Cookie 用戶驗證物件的狀態存取案例。
                var ClaimsIdentity = new ClaimsIdentity(varClaims, CookieAuthenticationDefaults.AuthenticationScheme);

                //依據使用者決定是否勾選[記住我]
                var authProperties = new AuthenticationProperties
                {
                    IsPersistent = loginPost.Rememberme
                };
                //執行ClaimsIdentity Cookie 用戶驗證物件的操作登入動作(使用Cookie操作內部驗證狀態控管與流程執行)
                HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme,
                    new ClaimsPrincipal(ClaimsIdentity), authProperties);
            }

            return RedirectToAction("Index", "Home");

        }

        public IActionResult Register()
        {
            return View();
        }

        [HttpPost]

        public IActionResult Register(string user_id, string pswd, string nkname, string email)
        {
            var TrueUser = _context.Users.FirstOrDefault(u => u.UserId == user_id);
            var TrueNickname = _context.Users.FirstOrDefault(u => u.Nickname == nkname);
            var TrueEmail = _context.Users.FirstOrDefault(u => u.Email == email);

            if (TrueNickname != null)
            {
                TempData["Error"] = "暱稱已存在，請嘗試別的暱稱!";
                return RedirectToAction("Register");
            }

            if (TrueEmail != null)
            {
                TempData["Error"] = "信箱已存在，請嘗試別的信箱!";
                return RedirectToAction("Register");
            }

            if (TrueUser != null)
            {
                TempData["Error"] = "帳號已存在，請嘗試別的帳號!";
                return RedirectToAction("Register");
            }



            var HashPW = BCrypt.Net.BCrypt.HashPassword(pswd);

            User newUser = new User
            {
                UserId = user_id,
                Password = HashPW,
                Nickname = nkname,
                Email = email,
            };

            _context.Users.Add(newUser);
            _context.SaveChanges();

            TempData["Success"] = "註冊成功，請登入!";
            return RedirectToAction("Login");
        }

        [HttpPost]
        public IActionResult CheckNickname(string nkname)
        {

            var TrueNickname = _context.Users.FirstOrDefault(u => u.Nickname == nkname);
            if (TrueNickname != null)
            {
                return Json(new { exists = true }); // 回傳暱稱已存在
            }
            return Json(new { exists = false }); // 暱稱可以使用
        }



        [Authorize]
        public IActionResult Logout()
        {
            HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("Index", "Home");

        }

        public IActionResult ForgotPW()
        {
            return View();
        }

        [HttpPost]
        public IActionResult ForgotPW(string phone)
        {
            phone = phone.Replace("-", "").Trim();
            var TruePhone = _context.Users.SingleOrDefault(e => e.Phone == phone);

            if (TruePhone == null)
            {
                TempData["Error"] = "手機號碼錯誤! 請重新輸入!";
            }
            else
            {

                TempData["phone"] = phone;


            }
            return View();
        }



        [HttpPost]
        public IActionResult ReSetPw(string phone, string NewPw)
        {
            var user = _context.Users.SingleOrDefault(e => e.Phone == phone);
            user!.Password = BCrypt.Net.BCrypt.HashPassword(NewPw);
            _context.SaveChanges();

            TempData["Asept"] = "密碼重設成功! 請重新登入!";
            return RedirectToAction("Login");

        }

    }
}
