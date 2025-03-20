using System.Security.Claims;
using FinalProject_GameForum.Controllers;
using Microsoft.AspNetCore.Mvc;
using Microsoft.CodeAnalysis.CSharp.Syntax;

namespace FinalProject_GameForum.Models
{
    
    public static class UserLogin
    {
       public static string GetUserId(this Controller controller)
        {
            return controller.HttpContext.User.Claims.FirstOrDefault(u => u.Type == ClaimTypes.NameIdentifier)!.Value;
        }
    }
}
