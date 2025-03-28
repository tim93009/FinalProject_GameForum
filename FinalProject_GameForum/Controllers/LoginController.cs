
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
using System.ComponentModel.DataAnnotations;
using System.Text.RegularExpressions;

namespace FinalProject_GameForum.Controllers
{
    public class LoginController : Controller
    {
        private readonly GameForumContext _context;


        public LoginController(GameForumContext context)
        {
            _context = context;

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


            if (user == null || !BCrypt.Net.BCrypt.Verify(loginPost.Password_P,user.Password))
            {
                TempData["Error"] = "帳號密碼錯誤，請修改!";
                return RedirectToAction("Login");
            }

            else
            {
                //Identity 要求Claim類別格式對應指派登入成功的用戶資料
                var varClaims = new List<Claim>();
                if (isEmail)
                {
                    varClaims.Add(new Claim(ClaimTypes.NameIdentifier, user.UserId));
                    varClaims.Add(new Claim("UserID", user.UserId!));
                    varClaims.Add(new Claim(ClaimTypes.Name, user.Nickname));
                    varClaims.Add(new Claim("name", user.Nickname));
                    varClaims.Add(new Claim(ClaimTypes.Email, user.Email!));
                    varClaims.Add(new Claim("UserEmail", user.Email!));
                    varClaims.Add(new Claim("UserPW", user.Password!));
                    varClaims.Add(new Claim("photo", user.PhotoUrl ?? "/img/Login/headphoto.jpg"));
                }
                else
                {
                    varClaims.Add(new Claim(ClaimTypes.NameIdentifier, user.UserId));
                    varClaims.Add(new Claim("UserID", user.UserId!));
                    varClaims.Add(new Claim(ClaimTypes.Name, user.Nickname));
                    varClaims.Add(new Claim("name", user.Nickname));
                    varClaims.Add(new Claim("UserPW", user.Password!));
                    varClaims.Add(new Claim("photo", user.PhotoUrl ?? "/img/Login/headphoto.jpg"));
                }
                ;
                //建構ClaimsIdentity Cookie 用戶驗證物件的狀態存取案例。
                var ClaimsIdentity = new ClaimsIdentity(varClaims, CookieAuthenticationDefaults.AuthenticationScheme);

                //依據使用者決定是否勾選[記住我]
                var authProperties = new AuthenticationProperties
                {
                    IsPersistent = loginPost.Rememberme,
                    ExpiresUtc = loginPost.Rememberme ? DateTimeOffset.UtcNow.AddDays(1) : null
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

            string emailPattern = @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
            var realemail = Regex.IsMatch(email, emailPattern);

            if (realemail == false)
            {
                TempData["Error"] = "信箱格式錯誤，請重新輸入!";
                return RedirectToAction("Register");
            }

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


            string hashpassword = BCrypt.Net.BCrypt.HashPassword(pswd);


            User newUser = new User
            {
                UserId = user_id,
                Password = hashpassword,
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
        public IActionResult ForgotPW(string email)
        {

            var TrueEmail = _context.Users.SingleOrDefault(e => e.Email == email);

            if (TrueEmail == null)
            {
                TempData["Error"] = "信箱錯誤! 請重新輸入!";
            }
            else
            {

                TempData["email"] = email;


            }
            return View();
        }



        [HttpPost]
        public IActionResult ReSetPw(string email, string NewPw)
        {
            var user = _context.Users.FirstOrDefault(e => e.Email == email);
            string hashpassword = BCrypt.Net.BCrypt.HashPassword(NewPw);
            user!.Password = hashpassword;
            _context.SaveChanges();

            TempData["Asept"] = "密碼重設成功! 請重新登入!";
            return RedirectToAction("Login");

        }

        [HttpGet]
        public IActionResult ThirdLogin(string provider, string returnURL = "/")
        {
            TempData["LoginProvider"] = provider; 
            
            var redirectUrl = Url.Action("ThirdLoginCallback","Login", new { returnURL });
            var properties = new AuthenticationProperties
            {
                RedirectUri = redirectUrl
            };
            return Challenge(properties, provider);
        }
        [HttpGet]
        public async Task<IActionResult> ThirdLoginCallBack(string returnURL = "/")
        {
            
            var result = await HttpContext.AuthenticateAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            if (!result.Succeeded)
            {
                TempData["Error"] = "登入失敗，請再試一次!";
                return RedirectToAction("Login");
            }
            //判斷有沒有拿到登入者的資料
            var oldclaims = result.Principal.Claims.ToList();
            
            var email = oldclaims?.FirstOrDefault(c => c.Type == ClaimTypes.Email)?.Value;
            var name = oldclaims?.FirstOrDefault(c => c.Type == ClaimTypes.Name)?.Value;
            var provider = TempData["LoginProvider"] as string;
            var providerID = oldclaims?.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
            
            
         
            if (email == null)
            {
                TempData["Error"] = "無法取得信箱，請使用其他方式登入!";
                return RedirectToAction("Login");
            }
            //判斷是否有此信箱
            var user = _context.Users.FirstOrDefault(u => u.Email == email);
            if (user != null && user?.Email != email)
            {
                TempData["Error"] = "您已註冊過，請使用原帳號登入!";
                return RedirectToAction("Login");
            }
            var userID = string.Empty;
            if (!string.IsNullOrEmpty(user.UserId))
            {
                 userID = user.UserId;
            }
            else
            {
                 userID = oldclaims?.FirstOrDefault(c => c.Type == ClaimTypes.Email)?.Value;
            }


            if (user != null)
            {
                var newclaims = new List<Claim>()
                {
                    new Claim(ClaimTypes.NameIdentifier, userID!),
                    new Claim(ClaimTypes.Name,user.Nickname),
                    new Claim("name",user.Nickname),
                    new Claim(ClaimTypes.Email, email!),
                    new Claim("photo", user.PhotoUrl ?? "/img/Login/headphoto.jpg" )
                };


                var claimIdentity = new ClaimsIdentity(newclaims, CookieAuthenticationDefaults.AuthenticationScheme);
                var authPropertie = new AuthenticationProperties { IsPersistent = true };
                await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, new ClaimsPrincipal(claimIdentity), authPropertie);
                return RedirectToAction("Index", "Home");
            }



            user = new User
            {
                UserId = userID!,
                Email = email,
                Nickname = name!,
                ProviderId = providerID
            };

            _context.Users.Add(user);
            _context.SaveChanges();

            var claimsIdentity = new ClaimsIdentity(oldclaims, CookieAuthenticationDefaults.AuthenticationScheme);
            var authProperties = new AuthenticationProperties { IsPersistent = true };
            await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, new ClaimsPrincipal(claimsIdentity), authProperties);
            return RedirectToAction("Index", "Home");


        }


        // 標註使用 LoginCheckFilter
        [HttpGet]
        [ServiceFilter(typeof(FinalProject_GameForum.Filters.LoginCheckFilter))]
        public IActionResult CheckLoginStatus()
        {
            // 如果 Filter 沒攔截，就表示已登入
            return Json(new { loggedIn = true });
        }


    }
}
