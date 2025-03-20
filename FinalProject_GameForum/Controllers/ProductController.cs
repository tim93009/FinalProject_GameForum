using System.Security.Claims;
using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Authorization;
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

        [HttpPost]
        [Authorize] // 確保使用者已登入，若無登入系統可移除此屬性並自行處理 UserId
        public IActionResult AddToCart(int productId, int quantity)
        {
            var user = HttpContext.User;

            // 取得當前使用者 ID（假設使用 ASP.NET Identity）
            string userId = user.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value; 
            if (string.IsNullOrEmpty(userId))
            {
                return Json(new { success = false, message = "請先登入" });
            }

            // 檢查商品是否存在
            var product = _db.Products.FirstOrDefault(p => p.ProductId == productId);
            if (product == null)
            {
                return Json(new { success = false, message = "商品不存在" });
            }

            // 檢查庫存
            if (product.Stock < quantity)
            {
                return Json(new { success = false, message = "庫存不足" });
            }

            // 檢查購物車中是否已有該商品
            var cartItem = _db.ShoppingCarts
                .FirstOrDefault(sc => sc.UserId == userId && sc.ProductId == productId);

            if (cartItem != null)
            {
                // 若已存在，更新數量
                cartItem.Quantity += quantity;
            }
            else
            {
                // 若不存在，新增一筆
                cartItem = new ShoppingCart
                {
                    UserId = userId,
                    ProductId = productId,
                    Quantity = quantity
                };
                _db.ShoppingCarts.Add(cartItem);
            }

            // 儲存變更到資料庫
            _db.SaveChanges();

            return Json(new { success = true });
        }
    }
}
