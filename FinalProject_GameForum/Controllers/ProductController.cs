using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FinalProject_GameForum.Controllers
{
    public class ProductController : Controller
    {
        private readonly GameForumContext _db;

        public ProductController(GameForumContext db)
        {
            _db = db;
        }

        public IActionResult Index(int? productId)
        {
            if (productId == null)
            {
                return NotFound("請提供商品 ID");
            }

            // 查詢單一商品並包含相關資料
            var product = _db.Products
                .Include(p => p.ProductCategory) // 包含商品分類
                .Include(p => p.ProductAdditionalImages) // 包含額外圖片
                .FirstOrDefault(p => p.ProductId == productId);

            if (product == null)
            {
                return NotFound("找不到指定的商品");
            }

            return View(product);
        }
    }
}
