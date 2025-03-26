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
            var viewData = new ShoppingViewData
            {
                Products = await _db.Products
                    .Include(p => p.ProductCategory)
                    .ToListAsync(),
                Advertisements = await _db.Advertisements
                    .Take(5) // 假設顯示 3 個廣告，可根據需求調整
                    .ToListAsync()
            };

            return View(viewData);
        }

        //商城導覽列搜尋商品功能
        public IActionResult Search(string searchTerm)
        {
            if (string.IsNullOrEmpty(searchTerm))
            {
                return RedirectToAction("Index");
            }

            var products = _db.Products
                .Where(p => p.ProductName.Contains(searchTerm) ||
                           (p.ProductDescription != null && p.ProductDescription.Contains(searchTerm)))
                .ToList();

            return View(products);
        }
    }

    // 數據容器類
    public class ShoppingViewData
    {
        public List<Product> Products { get; set; }
        public List<Advertisement> Advertisements { get; set; }        
    }
}
