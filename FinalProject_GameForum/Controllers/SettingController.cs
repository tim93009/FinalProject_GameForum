using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
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
            

            var user = HttpContext.User;
            Debug.WriteLine(this.GetUserId());
            var userID = this.GetUserId();
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
                return RedirectToAction("Setting");
            }
               
        }

        public IActionResult Permissions()
        {
            return View();
        }
        
    }
}
