using FinalProject_GameForum.Models;
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

        public async Task<IActionResult> Personal(string ownerid)
        {
            string? currentUserId = null;
            bool isOwner = false;

            if (User.Identity.IsAuthenticated) // 確保使用者有登入
            {
                currentUserId = this.GetUserInfo(_context).UserId; // 取得目前登入使用者的 ID
                isOwner = (currentUserId == ownerid); // 判斷是否為本人的頁面
            }


            if (string.IsNullOrEmpty(ownerid) && User.Identity!.IsAuthenticated)
            {
                ownerid = this.GetUserInfo(_context).UserId;
            }
            
            if (User.Identity!.IsAuthenticated)
            {
                var viewid = this.GetUserInfo(_context).UserId;
                if (viewid != ownerid)
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
            var visitors = _context.HistoricalVisitors.Where(x => x.OwnerId == ownerid && x.VisitTime >= DateTime.Today && x.VisitTime < DateTime.Today.AddDays(1))
                .OrderByDescending(x => x.VisitTime)
                .ToList();

            var friends = _context.Relationships.Where(x => (x.PersonAid == ownerid || x.PersonBid == ownerid) && x.RelationshipType == "Accepted").ToList();

            // **檢查是否已經是好友**
            bool isFriend = _context.Relationships.Any(x =>
                (x.PersonAid == currentUserId && x.PersonBid == ownerid ||
                 x.PersonBid == currentUserId && x.PersonAid == ownerid) &&
                x.RelationshipType == "Accepted");

            //檢查是否送出好友請求
            bool isRequest = _context.Relationships.Any(x => x.PersonAid == currentUserId && x.PersonBid == ownerid && x.RelationshipType == "Request");

            // **檢查是否已經送出請求**
            bool IsFollow = _context.Relationships.Any(x =>
                x.PersonAid == currentUserId && x.PersonBid == ownerid && x.RelationshipType == "Following");

           
            
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
                Isowner = isOwner,
                owner = ownerinfo,
                visitors = visitors,
                viewuser = viewuserinfo,
                friends = friends,
                Isfriend = isFriend,
                IsFollow = IsFollow,
                IsRequest = isRequest,
                

            };
            var Article = (from a in _context.ArticleGroups
                          join b in _context.Articles
                          on a.ArticleGroupId equals b.ArticleGroupId
                          where b.UserId == ownerid
                          select new
                          {
                              a.ArticleGroupId,
                              a.CoverImage,
                              a.ArticleTitle,
                              b.ArticleContent
                          }).ToList();

            ViewBag.Article = Article;


            return View(viewinfo);
        }
        public IActionResult Collect(string ownerid)
        {
            string? currentUserId = null;
            bool isOwner = false;

            if (User.Identity.IsAuthenticated) // 確保使用者有登入
            {
                currentUserId = this.GetUserInfo(_context).UserId; // 取得目前登入使用者的 ID
                isOwner = (currentUserId == ownerid); // 判斷是否為本人的頁面
            }

            var ownerinfo = _context.Users.Find(ownerid);
            if (ownerinfo == null)
            {
                return NotFound("找不到使用者");
            }
            var friends = _context.Relationships.Where(x => (x.PersonAid == ownerid || x.PersonBid == ownerid) && x.RelationshipType == "Accepted").ToList();

            // **檢查是否已經是好友**
            bool isFriend = _context.Relationships.Any(x =>
                (x.PersonAid == currentUserId && x.PersonBid == ownerid ||
                 x.PersonBid == currentUserId && x.PersonAid == ownerid) &&
                x.RelationshipType == "Accepted");

            //檢查是否送出好友請求
            bool isRequest = _context.Relationships.Any(x => x.PersonAid == currentUserId && x.PersonBid == ownerid && x.RelationshipType == "Request");

            // **檢查是否已經送出請求**
            bool IsFollow = _context.Relationships.Any(x =>
                x.PersonAid == currentUserId && x.PersonBid == ownerid && x.RelationshipType == "Following");
            var viewinfo = new PersonalView
            {
                Isowner = isOwner,
                owner = ownerinfo,
                friends = friends,
                Isfriend = isFriend,
                IsFollow = IsFollow,
                IsRequest = isRequest

            };


           
            return View(viewinfo);
        }
        public IActionResult Log(string ownerid)
        {
            string? currentUserId = null;
            bool isOwner = false;

            if (User.Identity.IsAuthenticated) // 確保使用者有登入
            {
                currentUserId = this.GetUserInfo(_context).UserId; // 取得目前登入使用者的 ID
                isOwner = (currentUserId == ownerid); // 判斷是否為本人的頁面
            }

            var ownerinfo = _context.Users.Find(ownerid);
            if (ownerinfo == null)
            {
                return NotFound("找不到使用者");
            }
            var friends = _context.Relationships.Where(x => (x.PersonAid == ownerid || x.PersonBid == ownerid) && x.RelationshipType == "Accepted").ToList();

            // **檢查是否已經是好友**
            bool isFriend = _context.Relationships.Any(x =>
                (x.PersonAid == currentUserId && x.PersonBid == ownerid ||
                 x.PersonBid == currentUserId && x.PersonAid == ownerid) &&
                x.RelationshipType == "Accepted");
            //檢查是否已經送出好友請求
            bool isRequest = _context.Relationships.Any(x => x.PersonAid == currentUserId && x.PersonBid == ownerid && x.RelationshipType == "Request");


            // **檢查是否已經追蹤**
            bool IsFollow = _context.Relationships.Any(x =>
                x.PersonAid == currentUserId && x.PersonBid == ownerid && x.RelationshipType == "Following");
            var viewinfo = new PersonalView
            {
                Isowner = isOwner,
                owner = ownerinfo,
                friends = friends,
                Isfriend = isFriend,
                IsFollow = IsFollow,
                IsRequest = isRequest


            };

            return View(viewinfo);
        }
        //CRUD好友
        public IActionResult Friends(string ownerid, string status)
        {

           
            string? currentUserId = null;
            bool isOwner = false;

            if (User.Identity.IsAuthenticated) // 確保使用者有登入
            {
                currentUserId = this.GetUserInfo(_context).UserId; // 取得目前登入使用者的 ID
                isOwner = (currentUserId == ownerid); // 判斷是否為本人的頁面
            }
            //尋找擁有者id
            var ownerinfo = _context.Users.Find(ownerid);
            if (ownerinfo == null)
            {
                return NotFound("找不到使用者");
            }

            //創一個清單存放好友狀態是哪個就抓哪個
            List<Relationship> friends = new List<Relationship>();

            switch (status)
            {
                case "Friends":
                    friends = _context.Relationships
                        .Where(x => (x.PersonAid == ownerid || x.PersonBid == ownerid) && x.RelationshipType == "Accepted")
                        .ToList();
                    break;
                case "Followers":
                    friends = _context.Relationships
                        .Where(x => x.PersonBid == ownerid && x.RelationshipType == "Following")
                        .ToList();
                    break;
                case "Followings":
                    friends = _context.Relationships
                        .Where(x => x.PersonAid == ownerid && x.RelationshipType == "Following")
                        .ToList();
                    break;
                case "Requests":
                    friends = _context.Relationships
                        .Where(x => x.PersonBid == ownerid && x.RelationshipType == "Request")
                        .ToList();
                    break;
            }
            //若狀態擁有者是被動的狀態就將對方的資料存入清單
            List<User> FriendBInfo = new List<User>();

            if (status == "Followers" || status == "Requests")
            {
                  FriendBInfo = friends.Select(x =>
                {
                    var user = _context.Users.Find(x.PersonAid);
                    return new User
                    {
                        UserId = user.UserId,
                        Nickname = user.Nickname,
                        PhotoUrl = user.PhotoUrl
                    };
                }).ToList();
            }
            else
            {
                FriendBInfo = friends.Select(x =>
                {
                    var user = _context.Users.Find(ownerid == x.PersonBid ? x.PersonAid : x.PersonBid);
                    return new User
                    {
                        UserId = user.UserId,
                        Nickname = user.Nickname,
                        PhotoUrl = user.PhotoUrl
                    };
                }).ToList();
            }


            // **檢查是否已經是好友**
            bool isFriend = _context.Relationships.Any(x =>
                (x.PersonAid == currentUserId && x.PersonBid == ownerid ||
                 x.PersonBid == currentUserId && x.PersonAid == ownerid) &&
                x.RelationshipType == "Accepted");
            //檢查是否送出好友請求
            bool isRequest = _context.Relationships.Any(x => x.PersonAid == currentUserId && x.PersonBid == ownerid && x.RelationshipType == "Request");

            // **檢查是否已經追蹤**
            bool IsFollow = _context.Relationships.Any(x =>
                x.PersonAid == currentUserId && x.PersonBid == ownerid && x.RelationshipType == "Following");

            var viewModel = new PersonalView
            {
                owner = ownerinfo,
                viewuser = FriendBInfo,
                Isowner = isOwner,
                friends = friends,
                status = status,
                Isfriend = isFriend,
                IsFollow = IsFollow,
                IsRequest = isRequest

            };

            return View(viewModel);
        }

      //接受好友
        public IActionResult AcceptFriend(string requestid)
        {
            var FriendRequest = _context.Relationships.FirstOrDefault(x => x.PersonAid == requestid && x.RelationshipType == "Request");
            if (FriendRequest != null && FriendRequest.RelationshipType == "Request")
            {
                FriendRequest.PersonAid = FriendRequest.PersonBid;
                FriendRequest.PersonBid = requestid;
               FriendRequest.RelationshipType = "Accepted";
                _context.SaveChanges();
            }
            return RedirectToAction("Friends", new { ownerid = this.GetUserInfo(_context).UserId, status = "Requests" });
        }
        // 拒絕請求當好友
        public IActionResult RemoveFriend(string requestid)
        {
            var FriendRequest = _context.Relationships.FirstOrDefault(x => x.PersonAid == requestid && x.RelationshipType == "Request");
            if (FriendRequest != null && FriendRequest.RelationshipType == "Request")
            {
                _context.Relationships.Remove(FriendRequest);
                _context.SaveChanges();
            }
            return RedirectToAction("Friends", new { ownerid = this.GetUserInfo(_context).UserId, status = "Requests" });
        }
        //移除接受、追蹤、被追蹤的好友
        public IActionResult DeleteFriend(string requestid,string status )
        {
            if(status == "Friends")
            {
                var friend = _context.Relationships.FirstOrDefault(x => x.PersonBid == requestid && x.RelationshipType == "Accepted");
                if(friend != null)
                {
                    _context.Relationships.Remove(friend);
                    _context.SaveChanges();
                    return RedirectToAction("Friends", new { ownerid = this.GetUserInfo(_context).UserId, status = "Accepted" });
                }
            }else if (status == "Followers")
            {
                var follower = _context.Relationships.FirstOrDefault(x => x.PersonAid == requestid && x.RelationshipType == "Following");
                if(follower != null)
                {
                    _context.Relationships.Remove(follower);
                    _context.SaveChanges();
                    return RedirectToAction("Friends", new { ownerid = this.GetUserInfo(_context).UserId, status = "Followers" });
                }
            }else if (status == "Followings")
            {
                var following = _context.Relationships.FirstOrDefault(x => x.PersonBid == requestid && x.RelationshipType == "Following");
                if (following != null)
                {
                    _context.Relationships.Remove(following);
                    _context.SaveChanges();
                    return RedirectToAction("Friends", new { ownerid = this.GetUserInfo(_context).UserId, status = "Followings" });
                }
            }
            return RedirectToAction("Friends", new { ownerid = this.GetUserInfo(_context).UserId, status = "Accepted" });

        }

        public IActionResult AddFriend(string requestid)
        {
            if (!User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Login", "Login");
            }
            //當前使用者id
            var ownerid =  this.GetUserInfo(_context).UserId;
            var TrueRequest = _context.Relationships.FirstOrDefault(x => x.PersonAid == ownerid 
                && x.PersonBid == requestid 
                && x.RelationshipType == "Accepted" 
                || x.RelationshipType == "Request");
            if(TrueRequest == null)
            {
                var NewRequest = new Relationship
                {
                    PersonAid = ownerid,
                    PersonBid = requestid,
                    RelationshipType = "Request"
                };

                _context.Relationships.Add(NewRequest);
                _context.SaveChanges();
            }
            else
            {
                TempData["Error"] = "已經送出過好友請求";
            }


                return RedirectToAction("Personal", new { ownerid = requestid });
        }
        public IActionResult AddFollow(string requestid)
        {
            if (!User.Identity.IsAuthenticated)
            {
                return RedirectToAction("Login", "Login");
            }
            //當前使用者id
            var ownerid = this.GetUserInfo(_context).UserId;
            var TrueRequest = _context.Relationships.FirstOrDefault(x => x.PersonAid == ownerid
                && x.PersonBid == requestid
                && x.RelationshipType == "Following");
            if (TrueRequest == null)
            {
                var NewRequest = new Relationship
                {
                    PersonAid = ownerid,
                    PersonBid = requestid,
                    RelationshipType = "Following"
                };

                _context.Relationships.Add(NewRequest);
                _context.SaveChanges();
            }
            else
            {
                TempData["Error"] = "正在追蹤";
            }


            return RedirectToAction("Personal", new { ownerid = requestid });
        }
    }
}
