using BCrypt.Net;
using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualStudio.Web.CodeGenerators.Mvc.Templates.BlazorIdentity.Pages.Manage;
using Newtonsoft.Json;
using NuGet.Versioning;
using System.Diagnostics;
using System.Security.Claims;
using System.Text.RegularExpressions;
using System.Threading.Tasks;


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
            var userinfo = this.GetUserInfo(_context);

            Debug.WriteLine(userinfo);
            return View(userinfo);



        }


        [HttpPost]
        public async Task<IActionResult> Setting(string Nickname, IFormFile? Photourl)
        {
          
            var TrueUserId = HttpContext.User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)!.Value;
            var userEntity = _context.Users.Find(TrueUserId);
            if(userEntity == null)
            {
                return NotFound();
            }

            if(Photourl != null && Photourl.Length > 0)
            {
                var filename = Path.GetFileName(Photourl.FileName);
                var filepath = Path.Combine("wwwroot/img/User", filename);
                using (var dataStream = new FileStream(filepath, FileMode.Create))
                {
                   await  Photourl.CopyToAsync(dataStream);
                }
                userEntity.PhotoUrl = "/img/User/" + filename;
            }


            userEntity.Nickname = Nickname;
 

            _context.SaveChanges();

            var claimsidentity = (ClaimsIdentity)HttpContext.User.Identity!;
            claimsidentity.RemoveClaim(claimsidentity.FindFirst(ClaimTypes.Name));
            claimsidentity.AddClaim(new Claim(ClaimTypes.Name, Nickname));
            claimsidentity.AddClaim(new Claim("name", Nickname));
            claimsidentity.RemoveClaim(claimsidentity.FindFirst("photo"));
            claimsidentity.AddClaim(new Claim("photo", userEntity.PhotoUrl ?? "/img/Login/headphoto.jpg"));

            await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, new ClaimsPrincipal(claimsidentity));

            
            return View(userEntity);
        }

        [HttpPost]
        public  IActionResult SettingUser(string Email, string Gender, DateTime? Birthdate, string Address, string Phone)
        {
            var realemail = false;

            if (string.IsNullOrWhiteSpace(Email))
            {
                TempData["SettingError"] = "信箱不能為空，請重新輸入!";
                return RedirectToAction("Setting");
            }

            string emailPattern = @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
            realemail = Regex.IsMatch(Email, emailPattern);

           


            if (!realemail )
            {
                TempData["SettingError"] = "信箱格式錯誤，請重新輸入!";
                return RedirectToAction("Setting");
            }

            var TrueUserId = HttpContext.User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)!.Value;
            var userEntity = _context.Users.Find(TrueUserId);
            if (!string.IsNullOrWhiteSpace(Phone) )
            {
                Phone = Phone.Replace("-", "").Trim();
            }
           
            if (userEntity == null)
            {
                return NotFound();
            }


  
            userEntity.Email = Email;
            userEntity.Gender = !string.IsNullOrWhiteSpace(Gender)?  Gender : userEntity.Gender;
            userEntity.Birthdate = Birthdate ?? userEntity.Birthdate;
            userEntity.Address = !string.IsNullOrWhiteSpace(Address) ? Address : userEntity.Address;
            userEntity.Phone = !string.IsNullOrWhiteSpace(Phone) ? Phone : userEntity.Phone;

            _context.SaveChanges();
            TempData["SetSuccess"] = "更新成功!";
            return RedirectToAction("Setting");
        }

        [HttpPost]
        public IActionResult SettingPW(string OldPW, string NewPW, string TruePW)
        {
            var TrueUserId = HttpContext.User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)!.Value;
            var userEntity = _context.Users.Find(TrueUserId);
            if (userEntity == null)
            {
                return NotFound();
            }
            if (!BCrypt.Net.BCrypt.Verify(OldPW,userEntity.Password))
            {
                TempData["SettingError"] = "舊密碼錯誤，更改失敗!";
                return RedirectToAction("Setting");
            }
            else
            {
                
                userEntity.Password = BCrypt.Net.BCrypt.HashPassword(NewPW);
                _context.SaveChanges();
                TempData["SetSuccess"] = "密碼更新成功!";
                return RedirectToAction("Setting");
            }
               
        }
        [Authorize]
        public IActionResult Permissions()
        {
            var userinfo = this.GetUserInfo(_context);
            return View(userinfo);
        }

        [HttpGet]
        public IActionResult BindThirdLogin(string provider, string returnURL = "/" )
        {
            var NowuserId = this.GetUserInfo(_context).UserId;
            
            TempData["userid"] = NowuserId;
            TempData["provider"] = provider;
           

            var redirectUrl = Url.Action("BindThirdLoginCallback", "Setting", new {returnURL});
            var properties = new AuthenticationProperties
            {
                RedirectUri = redirectUrl
            };
            return Challenge(properties, provider);
        }
        [HttpGet]
        public async Task<IActionResult> BindThirdLoginCallBack(string returnURL = "/")
        {
            //取得使用者用什麼綁定
            var userid = TempData["userid"] as string;
            var provider = TempData["provider"] as string;
            var user = _context.Users.FirstOrDefault(u => u.UserId == userid);




            var result = await HttpContext.AuthenticateAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            if (!result.Succeeded)
            {
                TempData["ThirdError"] = "綁定失敗，請再試一次!";
                return RedirectToAction("Permissions");
            }
            

            //取得第三方登入者的資料
            var Thirdclaims = result.Principal.Identities.FirstOrDefault()?.Claims; 
            var email = Thirdclaims?.FirstOrDefault(c => c.Type == ClaimTypes.Email)?.Value;
            var providerID = Thirdclaims?.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
            var RepeatEmail = _context.Users.FirstOrDefault(u => u.Email == email);
            //if (RepeatEmail == null && )
            //{
            //    TempData["ThirdError"] = "該信箱已有帳號，請使用其他信箱";
            //    var OldClaims = new List<Claim>
            //     {
            //    new Claim(ClaimTypes.NameIdentifier, user.UserId),
            //    new Claim(ClaimTypes.Name, user.Nickname),
            //    new Claim("name", user.Nickname),
            //    new Claim(ClaimTypes.Email, user.Email!),
            //    new Claim("photo", user.PhotoUrl ?? "/img/Login/headphoto.jpg"),

            //    };
            //    var ClaimsIdentity = new ClaimsIdentity(OldClaims, CookieAuthenticationDefaults.AuthenticationScheme);
            //    var AuthProperties = new AuthenticationProperties { IsPersistent = true };
            //    await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, new ClaimsPrincipal(ClaimsIdentity), AuthProperties);
            //    return RedirectToAction("Permissions");
                
            //}
            if (email == null ||   providerID == null)
            {
                TempData["ThirdError"] = "綁定失敗，請使用其他方式!";
                var OldClaims = new List<Claim>
                 {
                new Claim(ClaimTypes.NameIdentifier, user.UserId),
                new Claim(ClaimTypes.Name, user.Nickname),
                new Claim("name", user.Nickname),
                new Claim(ClaimTypes.Email, user.Email!),
                new Claim("photo", user.PhotoUrl ?? "/img/Login/headphoto.jpg"),

                };
                var ClaimsIdentity = new ClaimsIdentity(OldClaims, CookieAuthenticationDefaults.AuthenticationScheme);
                var AuthProperties = new AuthenticationProperties { IsPersistent = true };
                await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, new ClaimsPrincipal(ClaimsIdentity), AuthProperties);
                return RedirectToAction("Permissions");
              
            }
            //取得目前登入使用者
        
            
            if (user == null)
            {
                TempData["ThirdError"] = "綁定失敗，請重新登入!";
                return RedirectToAction("Login");
            }
            //若信箱不同則跳回原本的頁面 登入自己原本的帳號
            if (user.Email != email)
            {
                TempData["ThirdError"] = "綁定失敗，信箱不同!";
                
                var OldClaims = new List<Claim>
                 {
                new Claim(ClaimTypes.NameIdentifier, user.UserId),
                new Claim(ClaimTypes.Name, user.Nickname),
                new Claim("name", user.Nickname),
                new Claim(ClaimTypes.Email, user.Email!),
                new Claim("photo", user.PhotoUrl ?? "/img/Login/headphoto.jpg"),
                
                };
                var ClaimsIdentity = new ClaimsIdentity(OldClaims, CookieAuthenticationDefaults.AuthenticationScheme);
                var AuthProperties = new AuthenticationProperties { IsPersistent = true };
                await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, new ClaimsPrincipal(ClaimsIdentity), AuthProperties);
                return RedirectToAction("Permissions");
            }

            //目前第三方登入的帳號是否已經被綁定
            var existUser = _context.Users.FirstOrDefault(u =>  u.ProviderId == providerID);
            if (existUser != null && existUser.UserId != user.UserId && user.ProviderId != null)
            {
                TempData["ThirdError"] = "此帳號已經綁定過囉!";
                return RedirectToAction("Permissions");
            }

            user.Provider = provider;
            user.ProviderId = providerID;
            _context.SaveChanges();



            var newclaims = new List<Claim>
            {
                new Claim(ClaimTypes.NameIdentifier, user.UserId),
                new Claim(ClaimTypes.Name, user.Nickname),
                new Claim("name", user.Nickname),
                new Claim(ClaimTypes.Email, user.Email!),
                new Claim("photo", user.PhotoUrl ?? "/img/Login/headphoto.jpg"),
                new Claim("provider", user.Provider!),
                new Claim("providerid", user.ProviderId)
            };


            var claimsIdentity = new ClaimsIdentity(newclaims, CookieAuthenticationDefaults.AuthenticationScheme);
            var authProperties = new AuthenticationProperties { IsPersistent = true };
            await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, new ClaimsPrincipal(claimsIdentity), authProperties);


            TempData["ThirdSuccess"] = "綁定成功!";
            return RedirectToAction("Permissions");
        }

        public IActionResult UnbindThirdLogin()
        {
            var user = this.GetUserInfo(_context);
            user.Provider = null;
            user.ProviderId = null;
            _context.SaveChanges();
            TempData["ThirdSuccess"] = "解除綁定成功!";
            return RedirectToAction("Permissions");
        }

    }
}
