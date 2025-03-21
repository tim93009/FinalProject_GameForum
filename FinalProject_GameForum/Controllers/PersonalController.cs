﻿using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace FinalProject_GameForum.Controllers
{
    public class PersonalController : Controller
    {
        private readonly GameForumContext _context;
        public PersonalController(GameForumContext context)
        {
            _context = context;
        }
        
        public async Task<IActionResult> Personal(string ownerid )
        {
            if(string.IsNullOrEmpty(ownerid))
            {
                return RedirectToAction("Login", "Login");
                
            }
            if (User.Identity!.IsAuthenticated)
            {
                var viewid = this.GetUserInfo(_context).UserId;
                if(viewid != ownerid)
                {
                    var today = DateTime.Today;
                    var tomorrow = today.AddDays(1);

                    bool exists = _context.HistoricalVisitors.Any(x =>
                        x.OwnerId == ownerid &&
                        x.VisitorId == viewid &&
                        x.VisitTime >= today &&
                        x.VisitTime < tomorrow);
                    if (!exists)
                    {

                        var visitor = new HistoricalVisitor
                        {
                            OwnerId = ownerid,
                            VisitorId = viewid,
                            VisitTime = DateTime.Now
                        };
                        _context.HistoricalVisitors.Add(visitor);
                        await _context.SaveChangesAsync();
                    }
                }
            }

            var ownerinfo = _context.Users.Find(ownerid);
            if (ownerinfo == null)
            {
                return NotFound("找不到使用者");
            }
            var visitors = _context.HistoricalVisitors.Where(x => x.OwnerId == ownerid)
                .OrderByDescending(x => x.VisitTime)
                .ToList();

            var friends = _context.Relationships.Where( x => x.PersonAid == ownerid && x.RelationshipType == "Accepted").ToList();



            var viewuserinfo = visitors.Select(x =>
            {
                var user = _context.Users.Find(x.VisitorId);
                return new User
                {
                    UserId = user!.UserId,
                    Nickname = user.Nickname,
                    PhotoUrl = user.PhotoUrl
                };
            }).ToList();

            var viewinfo = new PersonalView
            {
                owner = ownerinfo,
                visitors = visitors,
                viewuser = viewuserinfo,
                friends = friends
                
            };



            return View(viewinfo);
        }
        public IActionResult Collect()
        {
            return View();
        }
        public IActionResult Log()
        {
            return View();
        }
        public IActionResult Friends(string ownerid)
        {
            if (!User.Identity!.IsAuthenticated)
            {
                return RedirectToAction("Login", "Login");
            }
            else
            {
                var friends = _context.Relationships.Where(x => x.PersonAid == ownerid && x.RelationshipType == "Accepted").ToList();
                var followers = _context.Relationships.Where(x => x.PersonAid == ownerid && x.RelationshipType == "Following").ToList(); ;
                var requests =  _context.Relationships.Where(x => x.PersonAid == ownerid && x.RelationshipType == "Request").ToList(); ;

                

            }
            return View();
        }
    }
}
