using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;
using System.Security.Claims;

namespace FinalProject_GameForum.Controllers
{
    public class ShoppingCartController : Controller
    {
        private readonly GameForumContext _db;

        public ShoppingCartController(GameForumContext db)
        {
            _db = db;
        }

        [Authorize]
        public IActionResult Index()
        {
            string userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (string.IsNullOrEmpty(userId))
            {
                return RedirectToAction("Login", "Account");
            }

            var cartItems = _db.ShoppingCarts
                .Include(sc => sc.Product)
                .Where(sc => sc.UserId == userId)
                .ToList();

            return View(cartItems);
        }

        [HttpPost]
        [Authorize]
        [ValidateAntiForgeryToken]
        public IActionResult UpdateCartQuantity(int shoppingCartId, int quantity)
        {
            string userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (string.IsNullOrEmpty(userId))
            {
                return Json(new { success = false, message = "請先登入" });
            }

            var cartItem = _db.ShoppingCarts
                .Include(sc => sc.Product)
                .FirstOrDefault(sc => sc.ShoppingCartId == shoppingCartId && sc.UserId == userId);

            if (cartItem == null)
            {
                return Json(new { success = false, message = "購物車項目不存在" });
            }

            if (quantity <= 0)
            {
                _db.ShoppingCarts.Remove(cartItem);
                _db.SaveChanges();
                return Json(new { success = true, removed = true });
            }
            else if (cartItem.Product.Stock < quantity)
            {
                return Json(new
                {
                    success = false,
                    message = $"庫存不足，僅剩 {cartItem.Product.Stock} 件",
                    stock = cartItem.Product.Stock // 返回當前庫存
                });
            }
            else
            {
                cartItem.Quantity = quantity;
                _db.SaveChanges();
                return Json(new
                {
                    success = true,
                    newQuantity = cartItem.Quantity,
                    price = cartItem.Product.Price,
                    stock = cartItem.Product.Stock // 返回庫存資訊
                });
            }
        }

        [HttpPost]
        [Authorize]
        [ValidateAntiForgeryToken]
        public IActionResult ClearCart()
        {
            string userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (string.IsNullOrEmpty(userId))
            {
                return Json(new { success = false, message = "請先登入" });
            }

            var cartItems = _db.ShoppingCarts.Where(sc => sc.UserId == userId);
            _db.ShoppingCarts.RemoveRange(cartItems);
            _db.SaveChanges();

            return Json(new { success = true });
        }
    }
}