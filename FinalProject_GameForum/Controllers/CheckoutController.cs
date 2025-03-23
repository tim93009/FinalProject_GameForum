using FinalProject_GameForum.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace FinalProject_GameForum.Controllers
{
    public class CheckoutController : Controller
    {
        private readonly GameForumContext _db;
        public CheckoutController(GameForumContext db)
        {
            _db = db;
        }
        public IActionResult Index()
        {
            // 假設使用當前登入用戶的 UserId 來查詢購物車
            //string userId = User.Identity?.Name ?? "defaultUser"; // 若未登入，使用預設值
            string userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;

            var cartItems = _db.ShoppingCarts
                .Include(c => c.Product) // 包含 Product 資料
                    .ThenInclude(p => p.ProductCategory) // 添加這行以載入 ProductCategory
                .Include(c => c.User)    // 包含 User 資料
                .Where(c => c.UserId == userId)
                .ToList();

            return View(cartItems);
        }

        // POST: /Checkout/RemoveFromCart
        // 移除購物車中的指定項目
        [HttpPost]
        public IActionResult RemoveFromCart(int id)
        {
            var item = _db.ShoppingCarts.Find(id);
            if (item == null)
            {
                return Json(new { success = false, message = "找不到該項目" });
            }

            _db.ShoppingCarts.Remove(item);
            _db.SaveChanges();

            return Json(new { success = true });
        }

        // POST: /Checkout/SubmitOrder
        // 處理訂單提交
        [HttpPost]
        public IActionResult SubmitOrder(IFormCollection form)
        {
            // 從表單中獲取收件人資訊
            string userName = form["uname"];
            string cellphone = form["ucell"];
            string email = form["uemail"];
            string postalCode = form["upostal"];
            string address = form["uaddress"];
            string cityCode = form["ucity"];
            string telephone = form["utel"];
            bool sendSms = form["usms"] == "on";

            // 獲取當前用戶的購物車項目
            string userId = User.Identity?.Name ?? "defaultUser";
            var cartItems = _db.ShoppingCarts
                .Include(c => c.Product)
                .Where(c => c.UserId == userId)
                .ToList();

            if (!cartItems.Any())
            {
                return Json(new { success = false, message = "購物車是空的" });
            }

            // 為每個購物車項目創建獨立的 Order
            foreach (var cartItem in cartItems)
            {
                // 更新數量（從表單中獲取）
                string quantityKey = $"quantity[{cartItem.ShoppingCartId}]";
                int quantity = cartItem.Quantity; // 預設使用購物車中的數量
                if (form.ContainsKey(quantityKey))
                {
                    if (int.TryParse(form[quantityKey], out int formQuantity) && formQuantity > 0)
                    {
                        quantity = formQuantity;
                    }
                }

                // 創建 Order 實例
                var order = new Order
                {
                    UserId = userId,
                    ProductId = cartItem.ProductId,
                    Quantity = quantity,
                    OrderDate = DateTime.Now,
                    OrderStatusId = 1, // 假設 1 表示 "待處理" 狀態，需根據實際 OrderStatus 表調整
                    ShippingAddress = $"{postalCode} {address}"
                };

                _db.Orders.Add(order);
            }

            // 清空購物車
            _db.ShoppingCarts.RemoveRange(cartItems);
            _db.SaveChanges();

            return RedirectToAction("OrderSuccess");
        }

        // GET: /Checkout/OrderSuccess
        // 訂單提交成功後的頁面
        public IActionResult OrderSuccess()
        {
            return View();
        }
    }
}
