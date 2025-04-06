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

            // 取得相關商品（相同類別的其他商品，排除當前商品）
            var relatedProducts = _db.Products
                .Where(p => p.ProductCategoryId == product.ProductCategoryId && p.ProductId != productId)
                .Take(6) // 限制顯示數量，例如 5 個
                .ToList();

            // 取得當前使用者的瀏覽紀錄
            string userId = HttpContext.User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
            var viewHistory = new List<Product>();
            if (!string.IsNullOrEmpty(userId))
            {
                viewHistory = _db.ViewHistories
                    .Where(vh => vh.UserId == userId)
                    .Include(vh => vh.Product)
                    .OrderByDescending(vh => vh.ViewDate) // 按瀏覽時間排序
                    .Take(6) // 限制顯示數量，例如 5 個
                    .Select(vh => vh.Product)
                    .ToList();

                // 記錄當前瀏覽
                var existingHistory = _db.ViewHistories
                    .FirstOrDefault(vh => vh.UserId == userId && vh.ProductId == productId);
                if (existingHistory == null)
                {
                    _db.ViewHistories.Add(new ViewHistory
                    {
                        UserId = userId,
                        ProductId = (int)productId,
                        ViewDate = DateTime.Now
                    });
                }
                else
                {
                    existingHistory.ViewDate = DateTime.Now; // 更新瀏覽時間
                }
                _db.SaveChanges();
            }

            // 使用 ViewBag 或 ViewModel 傳遞資料
            ViewBag.RelatedProducts = relatedProducts;
            ViewBag.ViewHistory = viewHistory;

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
