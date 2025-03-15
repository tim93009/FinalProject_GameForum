using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Mvc;

namespace iSpan_MSIT62_Final_Project.Controllers
{    
    public class ShoppingMallController : Controller
    {
        private readonly GameForumContext _db;

        public ShoppingMallController(GameForumContext db)
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
