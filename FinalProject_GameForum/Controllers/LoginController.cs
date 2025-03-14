using System.Security.Claims;
using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using NuGet.Protocol;
using Microsoft.AspNetCore.Authorization;
using System.Threading.Tasks;

namespace FinalProject_GameForum.Controllers
{
    public class LoginController : Controller
    {
        private readonly GameForumContext _context;
        protected  UserInfoService _UserInfo { get; set; }

        public LoginController(GameForumContext context, UserInfoService userInfo)
        {
            _context = context;
            _UserInfo = userInfo;
        }
        public IActionResult Login()
        {
            return View();

        }
        [HttpPost]
        public IActionResult Login(LoginPost loginPost)
        {
            var Userinfos = (from a in _context.Users
                             where a.UserId == loginPost.UserId_P && a.Password == loginPost.Password_P
                             select a).SingleOrDefault();
            if(Userinfos == null)
            {
                TempData["Error"] = "帳號密碼錯誤，請修改!";
                return RedirectToAction("Login");
            }
            else
            {
                //Identity 要求Claim類別格式對應指派登入成功的用戶資料
                var varClaims = new List<Claim>
            {
                new Claim(ClaimTypes.Name, Userinfos.Nickname),
                new Claim("FullName", Userinfos.Nickname),
                new Claim(ClaimTypes.Email, Userinfos.Email!),
                new Claim("UserEmail", Userinfos.Email!)
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
                    new ClaimsPrincipal(ClaimsIdentity),authProperties);

               

            }

            return RedirectToAction("Index", "Home");

        }

        public IActionResult Register() 
        {
            return View();
        }



        [Authorize]
        public  IActionResult Logout()
        {
            HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            return RedirectToAction("Index", "Home");

        }


        public IActionResult ForgotPW()
        {
            return View();
        }
    }
}
