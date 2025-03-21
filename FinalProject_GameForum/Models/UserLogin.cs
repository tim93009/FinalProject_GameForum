using System.Security.Claims;
using FinalProject_GameForum.Controllers;
using Microsoft.AspNetCore.Mvc;
using Microsoft.CodeAnalysis.CSharp.Syntax;
using Microsoft.EntityFrameworkCore;

namespace FinalProject_GameForum.Models
{

    public static class UserLogin
    {
        // 取得現在登入中的使用者資訊
        public static User GetUserInfo(this Controller controller, GameForumContext context)
        {
            var userID = controller.HttpContext.User.Claims.FirstOrDefault(u => u.Type == ClaimTypes.NameIdentifier)!.Value;
            var userdb = context.Users.FirstOrDefault(u => u.UserId == userID);
            if (userdb != null)
            {
                var userInfo = context.Users.FirstOrDefault(u => u.UserId == userID);
                return userInfo!;
            }
            else
            {
                return null!;
            }
            
           
        }
    }
}
