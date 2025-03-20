using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using NuGet.Versioning;
using System.Diagnostics;
using System.Security.Claims;
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
            

            
            Debug.WriteLine(this.GetUserId());
            // userlogin的取得id方法
            var userID = this.GetUserId();
            //存cookie
            Response.Cookies.Append("OriginalUserId", userID, new CookieOptions
            {
                HttpOnly = true,
                Secure = true, // 根據你的環境決定是否設置
                Expires = DateTimeOffset.UtcNow.AddMinutes(10) // 設定適當的過期時間
            });


            var userdb = _context.Users.FirstOrDefault(u => u.UserId == userID);
            if(userdb != null)
            {
                var userinfo = new User()
                {
                    Nickname = userdb.Nickname,
                    Email = userdb.Email,
                    PhotoUrl = userdb.PhotoUrl,
                    Gender = userdb.Gender,
                    Birthdate = userdb.Birthdate,
                    Address = userdb.Address,
                    Phone = userdb.Phone
                };

                return View(userinfo);
            }
            else
            {
                return NotFound();
            }
           
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
        public  IActionResult SettingUser(string Email, string Gender, DateTime Birthdate, string Address, string Phone)
        {
            var TrueUserId = HttpContext.User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)!.Value;
            var userEntity = _context.Users.Find(TrueUserId);
            Phone = Phone.Replace("-", "").Trim();
            if (userEntity == null)
            {
                return NotFound();
            }
  
            userEntity.Email = Email;
            userEntity.Gender = Gender;
            userEntity.Birthdate = Birthdate;
            userEntity.Address = Address;
            userEntity.Phone = Phone;

            _context.SaveChanges();
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
            if (userEntity.Password != OldPW)
            {
                TempData["Error"] = "舊密碼錯誤，更改失敗!";
                return RedirectToAction("Setting");
            }
            else
            {
                
                userEntity.Password = NewPW;
                _context.SaveChanges();
                TempData["Success"] = "密碼更新成功!";
                return RedirectToAction("Setting");
            }
               
        }

        public IActionResult Permissions()
        {

            return View();
        }

        [HttpGet]
        public IActionResult BindThirdLogin(string provider, string returnURL = "/" )
        {
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
           
            var result = await HttpContext.AuthenticateAsync(CookieAuthenticationDefaults.AuthenticationScheme);
            if (!result.Succeeded)
            {
                TempData["Error"] = "綁定失敗，請再試一次!";
                return RedirectToAction("Permissions");
            }

            
            //取得第三方登入者的資料
            var oldclaims = result.Principal.Identities.FirstOrDefault()?.Claims; 
            var email = oldclaims?.FirstOrDefault(c => c.Type == ClaimTypes.Email)?.Value;
            var providerID = oldclaims?.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;

            if (email == null ||   providerID == null)
            {
                TempData["Error"] = "綁定失敗，請使用其他方式!";
                return RedirectToAction("Permissions");
            }
            //取得目前登入使用者
            var userid = this.GetUserId();
            var user = _context.Users.FirstOrDefault(u => u.UserId == userid);
            if (user == null)
            {
                TempData["Error"] = "綁定失敗，請重新登入!";
                return RedirectToAction("Login");
            }
            //目前第三方登入的帳號是否已經被綁定
            var existUser = _context.Users.FirstOrDefault(u =>  u.ProviderId == providerID);
            if (existUser != null && existUser.UserId != user.UserId)
            {
                TempData["Error"] = "此帳號已經被綁定!";
                return RedirectToAction("Permissions");
            }

            
            user.ProviderId = providerID;
            _context.SaveChanges();

            TempData["Success"] = "綁定成功!";



            return RedirectToAction("Permissions");


        }

    }
}
