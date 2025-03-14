using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Mvc;

namespace FinalProject_GameForum.Controllers
{
    public class ProductController : Controller
    {
        private readonly GameForumContext _db;

        public ProductController(GameForumContext db)
        {
            _db = db;
        }

        public IActionResult Index()
        {
            List<Product> objProductList = _db.Products.ToList();
            return View(objProductList);
        }
    }
}
