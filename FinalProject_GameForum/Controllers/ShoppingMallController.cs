using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace iSpan_MSIT62_Final_Project.Controllers
{    
    public class ShoppingMallController : Controller
    {
        private readonly GameForumContext _db;

        public ShoppingMallController(GameForumContext db)
        {
            _db = db;
        }

        // 列出所有商品
        public async Task<IActionResult> Index()
        {
            var products = await _db.Products.Include(p => p.ProductCategory).ToListAsync();
            return View(products);
        }
    }
}
