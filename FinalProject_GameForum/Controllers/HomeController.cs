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

            var adProduct = _context.Products
                .Where(a => a.MainImageUrl != null)
                .OrderBy(x => Guid.NewGuid())
                .Take(2)
                .Select(a => new 
                {
                    MainImageUrl = a.MainImageUrl,
                    ProductId = a.ProductId,
                    ProductName = a.ProductName
                })
                .ToList();

            ViewBag.news = newsList;
            ViewBag.product = productList;
            ViewBag.dis = viewsList;
            ViewBag.ad = adProduct;
            return View();
        }
        public IActionResult GetRandomAD ()
        {
            var adProduct = _context.Products
                    .Where(a => a.MainImageUrl != null)
                    .OrderBy(x => Guid.NewGuid())
                    .Take(1)
                    .Select(a => new
                    {
                        MainImageUrl = Url.Content(a.MainImageUrl),
                        ProductId = a.ProductId
                    })
                    .FirstOrDefault();
            _logger.LogInformation("Random AD: ProductId={0}, ImageUrl={1}",
                    adProduct?.ProductId, adProduct?.MainImageUrl);

            if (adProduct == null)
            {
                return NotFound();
            }

            return Json(adProduct);
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
