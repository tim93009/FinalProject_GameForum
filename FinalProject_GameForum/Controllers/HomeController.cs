using System.Diagnostics;
using System.Security.Claims;
using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace FinalProject_GameForum.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly GameForumContext _context;

        public HomeController(ILogger<HomeController> logger, GameForumContext context)
        {
            _logger = logger;
            _context = context;
        }


		public IActionResult Index()
        {
            var newsList = _context.News
				.OrderBy(n => n.NewsId)
				.Take(6)
				.ToList();
			return View(newsList);
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }


        public override void OnActionExecuted(ActionExecutedContext context)
        {
            base.OnActionExecuted(context);

            if(User.Identity!.IsAuthenticated)
            {
                var userId = User.Claims.FirstOrDefault(u=> u.Type == ClaimTypes.NameIdentifier)!.Value;
                var user = _context.Users.Find(userId);
               
            }
        }
    }
}
