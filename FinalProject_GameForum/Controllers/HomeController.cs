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
                .OrderByDescending(n => n.EditDate)
				.Take(6)
				.ToList();

            var productList = _context.Products
                .OrderBy(p => p.Sold)
                .Take(5)
                .ToList();

            var viewsList = _context.Discussions
                .OrderByDescending(v => v.Views)
                .Take(6)
                .ToList();

            var allProduct = _context.Products
                .OrderBy(a => a.ProductId)
                .ToList();
            
                int halfCount = allProduct.Count / 2;
                var firstHalfAds = allProduct.Take(halfCount).ToList();
                var secondHalfAds = allProduct.Skip(halfCount).ToList();

                var random = new Random();
                var randomFirstAd = firstHalfAds.OrderBy(x => random.Next()).Take(1).ToList();
                var randomSecondAd = secondHalfAds
                    .Where(x => x.ProductId != randomFirstAd[0].ProductId)
                    .OrderBy(x => random.Next())
                    .Take(1)
                    .ToList();

            
            ViewBag.news = newsList;
            ViewBag.product = productList;
            ViewBag.dis = viewsList;
            ViewBag.RandomFirstAd = randomFirstAd;
            ViewBag.RandomSecondAd = randomSecondAd;
            return View();
        }
        
        [HttpGet]
        public IActionResult GetRandomAd()
        {
            var allProducts = _context.Products.ToList();
            var random = new Random();
            var randomAd = allProducts.OrderBy(x => random.Next()).First();
            return Json(new
            {
                ProductId = randomAd.ProductId,
                MainImageUrl = randomAd.MainImageUrl,
                ProductName = randomAd.ProductName
            });
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
