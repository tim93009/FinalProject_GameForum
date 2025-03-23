using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using FinalProject_GameForum.Models;
using System.Linq;
using System.Threading.Tasks;
using System.Security.Claims;

namespace FinalProject_GameForum.Controllers
{
    public class OrderController : Controller
    {
        private readonly GameForumContext _context;

        public OrderController(GameForumContext context)
        {
            _context = context;
        }

        // 訂單列表：只讀取目前登入用戶的訂單
        public async Task<IActionResult> Index()
        {
            string currentUserId = HttpContext.User.FindFirst("UserID")?.Value;
            if (string.IsNullOrEmpty(currentUserId))
            {
                return RedirectToAction("Login", "Login");
            }

            var orders = await _context.Orders
                .Include(o => o.Product)
                    .ThenInclude(p => p.ProductCategory)
                .Include(o => o.OrderStatus)
                .Where(o => o.UserId == currentUserId)
                .ToListAsync();

            return View(orders);
        }

        // 訂單詳情：確認訂單屬於目前用戶
        public async Task<IActionResult> Details(int id)
        {
            string currentUserId = HttpContext.User.FindFirst("UserID")?.Value;
            if (string.IsNullOrEmpty(currentUserId))
            {
                return RedirectToAction("Login", "Login");
            }

            var order = await _context.Orders
                .Include(o => o.Product)
                    .ThenInclude(p => p.ProductCategory)
                .Include(o => o.OrderStatus)
                .FirstOrDefaultAsync(o => o.OrderId == id && o.UserId == currentUserId);

            if (order == null)
            {
                return NotFound();
            }

            return View(order);
        }

        // 訂單搜尋：依訂單編號搜尋，目前僅顯示登入用戶的訂單
        public async Task<IActionResult> Search(string? searchOrderId)
        {
            string currentUserId = HttpContext.User.FindFirst("UserID")?.Value;
            if (string.IsNullOrEmpty(currentUserId))
            {
                return RedirectToAction("Login", "Login");
            }

            var orders = _context.Orders
                .Include(o => o.Product)
                    .ThenInclude(p => p.ProductCategory)
                .Include(o => o.OrderStatus)
                .Where(o => o.UserId == currentUserId)
                .AsQueryable();

            if (!string.IsNullOrEmpty(searchOrderId))
            {
                orders = orders.Where(o => o.OrderId.ToString().Contains(searchOrderId));
            }

            return View("Index", await orders.ToListAsync());
        }

        // 取消訂單：僅當訂單屬於目前用戶且狀態為 1 時可取消
        [HttpPost]
        public async Task<IActionResult> CancelOrder(int id)
        {
            string currentUserId = HttpContext.User.FindFirst("UserID")?.Value;
            if (string.IsNullOrEmpty(currentUserId))
            {
                return Json(new { success = false, message = "未登入" });
            }

            var order = await _context.Orders.FirstOrDefaultAsync(o =>
                o.OrderId == id && o.UserId == currentUserId && o.OrderStatusId == 1);

            if (order == null)
            {
                return Json(new { success = false, message = "找不到該訂單或該訂單無法取消" });
            }

            _context.Orders.Remove(order);
            await _context.SaveChangesAsync();

            return Json(new { success = true });
        }
    }
}
